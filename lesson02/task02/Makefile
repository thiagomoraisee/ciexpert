run:
	bash ./organize.sh

rpt: run
	tclsh scripts/design_hierarchy.tcl > report_hierarchy.rpt

revert:
	mv docs/* .
	mv include/* .
	mv scripts/* .
	mv src/* .
	mv tb/* .
	rm -r docs include scripts src tb

clean:
	rm *.rpt *.log
