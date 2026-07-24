source report_connections.tcl

if {$argc == 1} {
  set file_name [lindex $argv 0]
  set fd [open $file_name w]
  report_connections ../netlist.v $fd
  close $fd
} elseif {$argc == 0} {
  report_connections ../netlist.v
} else {
  puts "ERROR: Too much arguments!"
  puts "Usage: tclsh main.tcl <file_name>"
}
