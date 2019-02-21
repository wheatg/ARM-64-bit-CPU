# ARM-64-bit-CPU

I designed a 64-bit five-stage pipeline CPU based on a selection of the ARM instruction set using structural modeled SystemVerilog (expect for the control logic which was built from case statements).

The ARM instruction set this CPU is based on are:
* ADDI
* ADDS
* AND
* B
* B.LT
* CBZ
* EOR
* LDUR
* LSR
* STUR
* SUBS

The five-stage pipeline consists of:
```
Instruction Fetch -> Register Fetch -> Execute -> Data Memory -> Writeback
```
The only modules provided were the instruction storage and data memory storage modules.
