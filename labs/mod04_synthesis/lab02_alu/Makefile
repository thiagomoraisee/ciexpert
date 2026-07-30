BLOCK_NAME = alu

RTL_DIR = rtl
TB_DIR = tb
SCRIPTS_DIR = scripts

RTL_FILES = $(RTL_DIR)/$(BLOCK_NAME)_pkg.sv \
				$(RTL_DIR)/$(BLOCK_NAME).sv
TB_FILES = $(TB_DIR)/$(BLOCK_NAME)_tb.sv

syntax:
	vlogan -full64 -sverilog -kdb +lint=all $(RTL_FILES) $(TB_FILES)

compile: syntax
	vcs -full64 -debug_access+all -kdb -timescale=1ns/1ps $(BLOCK_NAME)_tb

run: compile
	./simv

waves:
	verdi -ssf waves.fsdb &

synth:
	dc_shell -f $(SCRIPTS_DIR)/synth.tcl

clean:
	rm -rf csrc simv* *.daidir novas* AN.DB ucli.key verdi* DVEfiles .vlogan* *.fsdb *.log *.rpt work.lib++ alib-52 *.ddc *.svf *_mapeada.v work reports netlist
