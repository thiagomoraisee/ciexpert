source report_cells.tcl

if {$argc == 1} {
  set file_name [lindex $argv 0]
  set fd [open $file_name w]
  report_cells ../netlist.v $fd
  close $fd
} elseif {$argc == 0} {
  report_cells ../netlist.v
} else {
  puts "ERROR: Too much arguments!"
  puts "Usage: tclsh main.tcl <file_name>"
}

