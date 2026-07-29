# M04L01 - Logic Synthesis of an AND Gate

In this lab, we will use *Synopsys Design Compiler* (DC) to synthesize the simple AND gate designed in M03L01. We will analyze the resulting timing, power, and area reports, and inspect the generated netlist using both the *Design Vision GUI* and the output Verilog (.v) file.

> **Note:** A standard cell lib is required for this lab and must be added (via copy or simbolic link) to this folder.
> **Note:** This lab is intentionally minimal, providing only the essential files needed for a simple circuit. It is useful for quick experimentation without navigating complex folder structures. For more complex and professional designs, using a structured reference flow is recommended.

1. Create a local copy or symbolic link to the PDK library
```
ln -s /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/db_nldm/saed32rvt_tt1p05v25c.db
```

2. Run logic synthesis
```
make synth
```
The `synth.tcl` script executes the synthesis flow, generating the reports and netlist. Once complete, the interactive `dc_shell` prompt will open.

3. Launch **Design Vision** GUI from `dc_shell`
```
start_gui
```

4. Right click on `and_gate` module and select `Schematic View`

Double-clicking the block reveals the internal structure, displaying the specific standard cell mapped during logic synthesis.
