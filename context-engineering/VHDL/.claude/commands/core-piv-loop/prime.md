# VHDL Project - Technical Prime

## Code Quality Standards

### VHDL Style & Conventions

#### Formatting & Linting
- **Line Length**: 100 characters (enforced by linter)
- **Indentation**: 2 spaces (no tabs)
- **Case**: VHDL keywords lowercase, signal/entity names snake_case
- **Naming**:
  - Entities: `module_name`
  - Signals: `signal_name`, `signal_name_n` (active-low)
  - Generics: `GENERIC_NAME` (uppercase)
  - Constants: `CONSTANT_NAME` (uppercase)
  - Ports: `clk`, `rst_n`, `data_in`, `data_out`

#### Code Organization
- **Entity First**: Entity declaration before architecture
- **Port Order**: Clock, reset, inputs, outputs
- **Architecture**: Declarative region, then process/concurrent statements
- **Process Sensitivity**: Complete sensitivity lists or use `*` (VHDL-2008)
- **Comments**: Explain "why", not "what"; use `--` for single line

#### Timing & Clocking
- **Clock Domains**: Clearly separate and document
- **Synchronous Design**: Prefer synchronous logic over asynchronous
- **Reset**: Active-low asynchronous reset (rst_n) for all flip-flops
- **CDC (Clock Domain Crossing)**: Use synchronizers (2-stage minimum)
- **Timing Constraints**: Document setup/hold requirements

#### Synthesis Considerations
- **Avoid**: Latches, combinatorial loops, incomplete sensitivity lists
- **Prefer**: Registered outputs, explicit state machines
- **Optimization**: Use generics for parameterization
- **Resource Awareness**: Consider LUT/FF usage, avoid unnecessary logic

#### Testbenches
- **Organization**: Separate testbench files (tb_*.vhd)
- **Naming**: `tb_entity_name` for testbench
- **Structure**: Clock generation, stimulus, assertions
- **Coverage**: Aim for >80% code coverage
- **Assertions**: Use `assert` statements for validation

#### Documentation
- **File Headers**: Entity name, purpose, author, date
- **Port Descriptions**: Comment each port with direction and purpose
- **Generics**: Document default values and valid ranges
- **Timing Diagrams**: Include for complex interfaces (SPI, AXI, etc.)

### Simulation & Synthesis

#### Simulation Tools
- **Preferred**: GHDL (open-source), ModelSim, VCS
- **Waveform Viewer**: GTKWave (GHDL), ModelSim GUI
- **Test Framework**: VUNIT for structured testing

#### Synthesis Tools
- **FPGA**: Vivado (Xilinx), Quartus (Intel), Lattice Diamond
- **ASIC**: Synopsys Design Compiler, Cadence Genus
- **Constraints**: XDC (Xilinx), SDC (standard), UCF (legacy)

#### Build Process
```bash
# Compile
ghdl -a --std=2008 entity.vhd
ghdl -a --std=2008 tb_entity.vhd

# Elaborate
ghdl -e --std=2008 tb_entity

# Simulate
ghdl -r --std=2008 tb_entity --vcd=waveform.vcd

# View
gtkwave waveform.vcd
```

## Semantic Patterns & Idioms

### Module Interface Pattern

```vhdl
entity module_name is
  generic (
    WIDTH : integer := 8;
    DEPTH : integer := 256
  );
  port (
    clk       : in  std_logic;
    rst_n     : in  std_logic;
    -- Inputs
    data_in   : in  std_logic_vector(WIDTH-1 downto 0);
    valid_in  : in  std_logic;
    -- Outputs
    data_out  : out std_logic_vector(WIDTH-1 downto 0);
    valid_out : out std_logic
  );
end entity module_name;
```
**Pattern**: Clock/reset first, then inputs, then outputs; use `_n` suffix for active-low

### Synchronous Process Pattern

```vhdl
process(clk, rst_n) is
begin
  if rst_n = '0' then
    counter <= (others => '0');
  elsif rising_edge(clk) then
    if enable = '1' then
      counter <= counter + 1;
    end if;
  end if;
end process;
```
**Pattern**: Async reset, then synchronous logic on rising_edge

### State Machine Pattern

```vhdl
type state_t is (IDLE, ACTIVE, DONE);
signal state, next_state : state_t;

-- Sequential: state register
process(clk, rst_n) is
begin
  if rst_n = '0' then
    state <= IDLE;
  elsif rising_edge(clk) then
    state <= next_state;
  end if;
end process;

-- Combinatorial: next state logic
process(state, input_signal) is
begin
  next_state <= state;
  case state is
    when IDLE =>
      if input_signal = '1' then
        next_state <= ACTIVE;
      end if;
    when ACTIVE =>
      next_state <= DONE;
    when DONE =>
      next_state <= IDLE;
  end case;
end process;
```
**Pattern**: Separate sequential (state register) and combinatorial (next state) logic

### Clock Domain Crossing Pattern

```vhdl
-- Synchronizer for CDC
signal async_signal : std_logic;
signal sync_stage1, sync_stage2 : std_logic;

process(clk_dest, rst_n) is
begin
  if rst_n = '0' then
    sync_stage1 <= '0';
    sync_stage2 <= '0';
  elsif rising_edge(clk_dest) then
    sync_stage1 <= async_signal;
    sync_stage2 <= sync_stage1;
  end if;
end process;

-- Use sync_stage2 (2-stage synchronizer)
```
**Pattern**: Minimum 2-stage synchronizer for CDC, use in destination clock domain

### Parameterized Module Pattern

```vhdl
entity fifo is
  generic (
    WIDTH : integer := 8;
    DEPTH : integer := 16;
    ADDR_WIDTH : integer := 4  -- log2(DEPTH)
  );
  port (
    clk : in std_logic;
    -- ...
  );
end entity fifo;

architecture rtl of fifo is
  type mem_t is array (0 to DEPTH-1) of std_logic_vector(WIDTH-1 downto 0);
  signal mem : mem_t;
begin
  -- Use WIDTH, DEPTH, ADDR_WIDTH in logic
end architecture rtl;
```
**Pattern**: Use generics for configurable width/depth, calculate derived values

### Testbench Pattern

```vhdl
entity tb_module_name is
end entity tb_module_name;

architecture tb of tb_module_name is
  constant CLK_PERIOD : time := 10 ns;
  signal clk, rst_n : std_logic;
  signal data_in, data_out : std_logic_vector(7 downto 0);
begin
  -- Clock generation
  process is
  begin
    clk <= '0';
    wait for CLK_PERIOD / 2;
    clk <= '1';
    wait for CLK_PERIOD / 2;
  end process;

  -- DUT instantiation
  dut : entity work.module_name
    port map (
      clk => clk,
      rst_n => rst_n,
      data_in => data_in,
      data_out => data_out
    );

  -- Stimulus
  process is
  begin
    rst_n <= '0';
    wait for CLK_PERIOD;
    rst_n <= '1';

    data_in <= x"AA";
    wait for CLK_PERIOD;

    assert data_out = x"AA" report "Output mismatch" severity error;
    wait;
  end process;
end architecture tb;
```
**Pattern**: Clock generation, DUT instantiation, stimulus, assertions

## Common Practices

### Timing Analysis
- **Setup Time**: Data must be stable before clock edge
- **Hold Time**: Data must remain stable after clock edge
- **Propagation Delay**: Time from input to output
- **Critical Path**: Longest combinatorial path determines max frequency
- **Slack**: Positive = timing met, negative = timing violated

### Reset Strategy
- **Asynchronous Reset**: Fast reset, but requires synchronization
- **Synchronous Reset**: Slower but cleaner, preferred for most logic
- **Hybrid**: Async reset to known state, then sync for fine control

### Simulation Debugging
- **Waveforms**: Use GTKWave to inspect signals over time
- **Assertions**: Catch errors early with `assert` statements
- **Logging**: Use `report` statements for debug output
- **Breakpoints**: Set in simulator for step-through debugging

### Synthesis Optimization
- **Area**: Minimize logic gates and flip-flops
- **Speed**: Reduce critical path delay
- **Power**: Reduce switching activity and clock frequency
- **Trade-offs**: Usually area vs. speed vs. power

## File Organization Conventions

### Directory Structure
```
project/
├── src/
│   ├── entity_name.vhd
│   ├── module_a.vhd
│   └── module_b.vhd
├── tb/
│   ├── tb_entity_name.vhd
│   ├── tb_module_a.vhd
│   └── tb_module_b.vhd
├── sim/
│   └── (simulation outputs)
├── synth/
│   └── (synthesis outputs)
├── constraints/
│   ├── timing.xdc
│   └── pinout.xdc
├── doc/
│   ├── architecture.md
│   └── timing_diagrams.md
└── Makefile
```

### File Naming
- **Entities**: `module_name.vhd`
- **Testbenches**: `tb_module_name.vhd`
- **Packages**: `package_name_pkg.vhd`
- **Constraints**: `constraints.xdc` or `constraints.sdc`

### Build Automation
```makefile
# Compile all sources
compile:
	ghdl -a --std=2008 src/*.vhd
	ghdl -a --std=2008 tb/*.vhd

# Simulate
simulate: compile
	ghdl -e --std=2008 tb_entity_name
	ghdl -r --std=2008 tb_entity_name --vcd=sim/waveform.vcd

# View waveforms
view:
	gtkwave sim/waveform.vcd

# Clean
clean:
	rm -rf work/ *.o *.vcd
```

## VHDL Version & Standards

- **VHDL-2008**: Preferred (modern features, better synthesis)
- **VHDL-2002**: Acceptable (widely supported)
- **VHDL-1993**: Legacy (avoid for new projects)

### VHDL-2008 Features
- `all` in sensitivity lists
- `to_integer()` for conversions
- `rising_edge()` / `falling_edge()` (preferred over `'event`)
- Uninitialized signals default to '0'

## Testing & Verification

### Unit Testing
- Test individual modules in isolation
- Use testbenches with clear stimulus/response
- Verify all states and transitions

### Integration Testing
- Test module interactions
- Verify data flow between modules
- Check timing between clock domains

### Coverage Goals
- **Line Coverage**: >80%
- **Branch Coverage**: >80%
- **State Coverage**: All states exercised
- **Transition Coverage**: All state transitions tested

## Performance Considerations

- **Frequency**: Document target clock frequency
- **Latency**: Pipeline stages affect throughput
- **Throughput**: Data rate through module
- **Resource Usage**: LUTs, FFs, BRAMs, DSPs
- **Power**: Dynamic and static power consumption

---

**Last Updated:** [Current Date]  
**Version:** 1.0
