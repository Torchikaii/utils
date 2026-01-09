# VHDL Validation Guide

## Validation Process

### Step 1: Behavioral Simulation

Run testbenches to verify functional correctness:

```bash
ghdl -a --std=2008 src/*.vhd
ghdl -a --std=2008 tb/*.vhd
ghdl -e --std=2008 tb_module_name
ghdl -r --std=2008 tb_module_name --vcd=sim/waveform.vcd
```

**Checks:**
- All assertions pass
- No runtime errors
- Output matches expected behavior
- Edge cases handled correctly

### Step 2: Waveform Analysis

Open waveforms in GTKWave:

```bash
gtkwave sim/waveform.vcd
```

**Verify:**
- Clock edges are clean
- Reset assertion/deassertion correct
- Data propagates as expected
- Timing relationships correct (setup/hold)
- No glitches or unexpected transitions

### Step 3: Code Coverage

Measure testbench coverage:

```bash
ghdl -r --std=2008 tb_module_name --vcd=sim/waveform.vcd --coverage
```

**Target:** >80% line coverage

**If coverage low:**
- Add test cases for uncovered branches
- Verify all states/transitions exercised
- Test error conditions

### Step 4: Synthesis

Compile for target FPGA/ASIC:

**Xilinx Vivado:**
```bash
vivado -mode batch -source synth.tcl
```

**Intel Quartus:**
```bash
quartus_sh -t synth.tcl
```

**GHDL (generic):**
```bash
ghdl -s --std=2008 src/module_name.vhd
```

**Checks:**
- No synthesis errors
- No critical warnings
- Resource utilization acceptable (LUTs, FFs, BRAMs)
- No inferred latches
- No combinatorial loops

### Step 5: Timing Analysis

Verify timing closure:

```bash
# After synthesis, run timing analysis
# Xilinx: report_timing
# Quartus: report_timing
```

**Checks:**
- Setup slack > 0 (timing met)
- Hold slack > 0 (timing met)
- Critical path identified
- Frequency meets requirements
- Clock domain crossings properly synchronized

### Step 6: Linting & Style

Check code quality:

```bash
# VHDL linter (if available)
vhdl-linter src/*.vhd
```

**Checks:**
- Naming conventions followed
- Line length < 100 characters
- Indentation consistent
- No unused signals/variables
- Comments present for complex logic

### Step 7: Post-Synthesis Simulation (Optional)

Simulate with actual delays:

```bash
ghdl -r --std=2008 tb_module_name --vcd=sim/post_synth.vcd \
  --sdf=synth/module_name.sdf
```

**Checks:**
- Behavior unchanged with real delays
- No timing violations
- Setup/hold times met

---

## Validation Checklist

### Functional Validation
- [ ] All testbenches pass
- [ ] All assertions pass
- [ ] Edge cases tested
- [ ] Error conditions handled
- [ ] Code coverage >80%

### Synthesis Validation
- [ ] No synthesis errors
- [ ] No critical warnings
- [ ] No inferred latches
- [ ] No combinatorial loops
- [ ] Resource usage acceptable

### Timing Validation
- [ ] Setup slack > 0
- [ ] Hold slack > 0
- [ ] Frequency meets requirements
- [ ] CDC synchronizers in place
- [ ] Critical path identified

### Code Quality
- [ ] Naming conventions followed
- [ ] Line length < 100 characters
- [ ] Comments explain complex logic
- [ ] No unused signals
- [ ] Consistent indentation

### Documentation
- [ ] Port descriptions complete
- [ ] Generics documented
- [ ] Timing diagrams provided
- [ ] Architecture explained
- [ ] Known limitations noted

---

## Validation Report Template

```
Module: module_name
Date: YYYY-MM-DD
Status: PASS / FAIL

Functional Testing:
  - Testbenches: PASS (X/X tests passed)
  - Code Coverage: 85% (target: >80%)
  - Assertions: All passed

Synthesis:
  - Tool: Vivado 2023.2
  - Errors: 0
  - Warnings: 2 (non-critical)
  - LUTs: 150 / 53200
  - FFs: 64 / 106400

Timing:
  - Target Frequency: 100 MHz
  - Achieved Frequency: 105 MHz
  - Setup Slack: +0.5 ns
  - Hold Slack: +0.2 ns
  - Status: MET

Code Quality:
  - Style: PASS
  - Linting: PASS
  - Coverage: PASS

Issues Found: None
Recommendations: None
```

---

## Common Validation Issues & Fixes

| Issue | Cause | Fix |
|-------|-------|-----|
| Assertion fails | Logic error | Debug waveform, check logic |
| Synthesis error | Invalid VHDL | Check syntax, use supported constructs |
| Timing violation | Critical path too long | Optimize logic, add pipeline stages |
| Inferred latch | Incomplete if/case | Add else clause, complete assignments |
| Low coverage | Missing test cases | Add tests for uncovered branches |
| CDC metastability | No synchronizer | Add 2-stage synchronizer |

---

**Last Updated:** [Current Date]
