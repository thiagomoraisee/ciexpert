BLOCK_NAME ?= and_gate
RTL_FILES = $(BLOCK_NAME).sv
TB_FILES = $(BLOCK_NAME)_tb.sv

syntax:
	vlogan -full64 -sverilog -kdb +lint=all $(RTL_FILES) $(TB_FILES)

compile: syntax
	vcs -full64 -debug_access+all -kdb -timescale=1ns/1ps $(BLOCK_NAME)_tb

run: compile
	./simv

waves:
	verdi -ssf waves.fsdb &

clean:
	rm -rf csrc simv* *.daidir novas* AN.DB ucli.key verdi* DVEfiles .vlogan* *.fsdb *.log work.lib++
