# VHDL Project PRD Template

This template defines the structure for VHDL project PRDs. When `/create-prd` is called, generate a document following this structure.

---

# $PROJECT_NAME - Product Requirements Document

## Project Overview

Brief description of the hardware module/system being built.

**Example:** "A VHDL-based SPI slave interface module for configuring programmable timers via serial communication."

## Value Proposition

Key benefits and use cases.

**Example:**
- Flexible configuration via standard SPI protocol
- Compact FPGA implementation
- Easy integration with microcontroller systems

## Core Features

List of main features/capabilities.

**Example:**
- SPI slave interface (modes 0-3)
- Packet-based command protocol
- Multiple independent timers
- Interrupt generation per timer

## Technical Specifications

### Hardware Requirements

| Aspect | Specification |
|--------|---------------|
| Language | VHDL (2008 or later) |
| Target | FPGA/ASIC |
| Clock Frequency | [e.g., 50 MHz] |
| Tool | [e.g., Vivado, Quartus, GHDL] |
| Area | [e.g., 2-5K LUTs] |
| Power | [TBD or estimated] |

### Interface Signals

#### Clock & Reset
- `clk`: System clock input
- `rst_n`: Active-low asynchronous reset

#### [Interface Name] Signals
- `signal_name`: Direction, width, purpose
- `signal_name_n`: Active-low signal

### Configuration Parameters

```vhdl
PARAMETER_NAME : integer := default_value;  -- Description
WIDTH          : integer := 8;              -- Data width
DEPTH          : integer := 256;            -- Memory depth
```

## Functional Requirements

### FR1: [Feature Name]
- Requirement 1
- Requirement 2
- Requirement 3

### FR2: [Feature Name]
- Requirement 1
- Requirement 2

## Non-Functional Requirements

### NFR1: Performance
- Timing requirement (e.g., max frequency, latency)
- Throughput requirement
- Propagation delay

### NFR2: Resource Usage
- LUT budget
- Flip-flop budget
- BRAM usage (if applicable)

### NFR3: Reliability
- Timing closure requirement
- No metastability issues
- Clock domain crossing safety

### NFR4: Code Quality
- >80% code coverage in simulation
- No synthesis warnings
- Adherence to VHDL style guide

## Architecture Overview

```
┌─────────────────────────────┐
│   Module Name               │
│  ┌───────────────────────┐  │
│  │  Submodule A          │  │
│  └───────────────────────┘  │
│  ┌───────────────────────┐  │
│  │  Submodule B          │  │
│  └───────────────────────┘  │
└─────────────────────────────┘
```

## Module Specifications

### Entity: module_name

**Purpose:** Brief description

**Generics:**
| Name | Type | Default | Description |
|------|------|---------|-------------|
| WIDTH | integer | 8 | Data width |
| DEPTH | integer | 256 | Memory depth |

**Ports:**
| Name | Direction | Width | Description |
|------|-----------|-------|-------------|
| clk | in | 1 | System clock |
| rst_n | in | 1 | Active-low reset |
| data_in | in | WIDTH | Input data |
| data_out | out | WIDTH | Output data |

**Behavior:**
- Describe what the module does
- Timing relationships
- State transitions (if applicable)

## Success Criteria

- [ ] All functional requirements met
- [ ] Simulation passes with >80% coverage
- [ ] Synthesis completes without errors
- [ ] Timing closure met at target frequency
- [ ] No inferred latches or combinatorial loops
- [ ] Code follows VHDL style guide
- [ ] All ports and generics documented
- [ ] Testbenches cover all major scenarios

## Testing Strategy

### Unit Tests
- Test individual modules in isolation
- Verify all states and transitions
- Test edge cases and error conditions

### Integration Tests
- Test module interactions
- Verify data flow between modules
- Check timing between clock domains

### Simulation
- Behavioral simulation with test vectors
- Timing simulation (post-synthesis)
- Clock domain crossing verification

### Synthesis Validation
- Verify no synthesis errors/warnings
- Check resource utilization
- Verify timing closure

## Constraints & Assumptions

- System clock is stable and synchronous
- [Other assumptions specific to project]
- Maximum [N] instances of module
- [Tool/version requirements]

## Deliverables

1. **VHDL Source Code**
   - `module_name.vhd` — Main module
   - `submodule_a.vhd` — Submodule (if applicable)
   - `submodule_b.vhd` — Submodule (if applicable)

2. **Testbenches**
   - `tb_module_name.vhd` — Main testbench
   - `tb_submodule_a.vhd` — Submodule testbench

3. **Documentation**
   - `.claude/PRD.md` — This document (always in .claude directory)
   - Module interface specifications
   - Timing diagrams
   - Architecture description
   - Integration guide

4. **Synthesis Reports**
   - Resource utilization
   - Timing analysis
   - Power estimates (if applicable)

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | [Date] | - | Initial PRD |

---

**Document Status**: Draft  
**Last Updated**: [Current Date]  
**Owner**: [Your Name/Team]
