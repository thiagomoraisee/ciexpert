# P01 - Sequential Accumulator in SystemVerilog

This project covers the design and analysis of a sequential accumulator circuit in SystemVerilog, based on the activity "Projeto de um Acumulador Sequencial em SystemVerilog".

## Behavioral Description

The target circuit is a sequential accumulator featuring a parameterized data width (`WIDTH`) storage register. On each positive clock edge, the accumulator value updates according to the control opcodes below:

| Operation | Code  | Description                                            |
| :-------: | :---: | :----------------------------------------------------: |
|   HOLD    | 2'b00 | Keeps the current accumulator value                    | 
|   LOAD    | 2'b01 | Loads `data_in` into the accumulator                   | 
|   ADD     | 2'b10 | Adds `data_in` to the current accumulator value        | 
|   SUB     | 2'b11 | Subtracts `data_in` from the current accumulator value | 

In addition to the opcode logic, the circuit includes:
- Synchronous reset (`rst`) signal to initialize the accumulator output (`acc`) to zero;
- Clock enable (`enable`) signal that allows updates in the storage register;
- Accumulator data (`acc`) that outputs the register value.

> **Note:** A standard cell lib is required for this project and must be added (via copy or simbolic link) to this folder.

The complete report containing the responses to the exercise tasks is located in the `docs/` directory.
