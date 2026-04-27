### This project extends the 3-stage pipelined processor design to a 4-stage pipelined processor by introducing an additional pipeline stage for improved modularity and timing performance.

## Pipeline Architecture
The CPU is divided into four stages:

### IF (Instruction Fetch)
  - Program Counter updates instruction address.
  - Instruction memory fetches instructions.
### ID (Instruction Decode)
  - Control signals generated from opcode.
  - Register file reads operands.
  - Immediate values prepared.
### EX (Execute)
  - ALU performs computation.
  - Intermediate results generated.
  - WB (Write Back).
  - ALU result written back to register file.
  - Final output propagated.
  
## Modules Implemented
- PC.v : Program Counter (from 3-stage pipelined CPU)
- memory.v : Instruction Memory
- control.v : Control Unit
- regfile.v: Register File
- ID_EXstage.v: ID to EX pipeline register (from 3-stage pipelined CPU)
- EXE_WBstage.v : EX to WB pipeline register
- alu.v : ALU
- pipelined_4stage.v : Top module (updated pipeline)
- define.v : Shared macros and parameters

## Key Enhancements from 3-stage pipelined CPU
- Added Write Back (WB) stage
- Improved pipeline separation
- Better timing characteristics
- Cleaner data flow between stages

## Simulation
- Testbench: testbench_4stage.v
- Clock-driven execution
- Verified pipeline progression using waveforms

## Synthesis & Implementation
Implemented on *Spartan-7 FPGA (xc7s6cpg196-1)*

### Obtained:
-LUT, FF, Slice utilization
-Timing metrics (WNS, TNS)

## Limitations
- No hazard detection or forwarding
- No branch handling
- Basic instruction set
- Focused on structural pipeline extension

## Objective
Extend a 3-stage pipeline into a 4-stage design.
Understand pipeline scalability
Analyze improvements in timing and structure
Reinforce modular CPU design principles
