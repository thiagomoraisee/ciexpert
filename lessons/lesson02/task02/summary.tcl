# ====================================================================================== #
# CI EXPERT - UFCG/CEEI                                                                  #
# -------------------------------------------------------------------------------------- #
# Script: summary.tcl                                                  Date: 2026.03.27  #
# Author: Thiago M. de Oliveira <thiago.oliveira@embedded.ufcg.edu.br>                   #
# Description: Summarizes all reports generation into a complete reports generator.      #
# ====================================================================================== #

source ../../lesson01/task01/report_cells.tcl
source ../../lesson01/task02/report_hierarchy.tcl
source ../../lesson01/task03/report_connections.tcl

proc run_task {task_name function_call report_file netlist} {
  puts "Running $task_name ... "

  set fd [open $report_file w]
  puts $fd "*--------------------------------------"
  puts $fd "* Title: $task_name"
  puts $fd "* Generated at: [clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}]"
  puts $fd "* Netlist file: $netlist"
  puts $fd "*--------------------------------------"
  $function_call $netlist $fd
  close $fd
}

set netlist src/netlist.v
run_task "Cell Report" report_cells "cells.rpt" $netlist
run_task "Hierarchy Report" report_hierarchy "hierarchy.rpt" $netlist
run_task "Connections Report" report_connections "connections.rpt" $netlist
