# ====================================================================================== #
# CI EXPERT - UFCG/CEEI                                                                  #
# -------------------------------------------------------------------------------------- #
# Script: connection_statistics.tcl                                    Date: 2026.03.27  #
# Author: Thiago M. de Oliveira <thiago.oliveira@embedded.ufcg.edu.br>                   #
# Description: Identify design nets and calculate the fanout.                            #
# ====================================================================================== #

set netlist ../netlist.v

proc count_fanout {file_name {start 0} {end 0}} {
  array set fanout {}

  # Open the file in read mode
  if {[catch {open $file_name r} fileId]} {
      puts "ERRO: Arquivo não encontrado: $fileId"
      return
  }

  set line_counter 1
  while {[gets $fileId line] >= 0} {
    if {$line_counter >= $start && $line_counter <= $end || $start + $end == 0} {
      set pattern {\.\w+\(([^)]+)\)}
      set matches [regexp -all -inline $pattern $line]

      foreach {full_match wire} $matches {
        set wire [string trim $wire]

        if {[regexp {\d'b[01zZ]} $wire]} {
          continue
        }

        if {[info exists fanout($wire)]} {
          incr fanout($wire)
        } else {
          set fanout($wire) 1
        }
      }
    }
    incr line_counter
  }
  close $fileId
  return [array get fanout]
}

proc get_max_fanout {fanout_list} {
  set max_fanout {}
  set max_pos 0
  set max_val 0
  set position 0
  foreach {wire fanout} $fanout_list {
    if {$fanout > $max_val} {
      set max_val $fanout
      set max_pos $position
    }
    incr position
  }
  lappend max_fanout [lindex $fanout_list [expr {2 * $max_pos }]]
  lappend max_fanout [lindex $fanout_list [expr {2 * $max_pos +1}]]

  set fanout_list [lreplace $fanout_list [expr {2 * $max_pos}] [expr {2 * $max_pos + 1}] ]

  return [list $max_fanout $fanout_list]
}

## Main Application
proc report_connections {netlist {chan stdout}} {

  set max_fanout_vals {}
  set max_fanout_nets {}
  set zero_fanout_nets {}

  set fanout_list [count_fanout $netlist]
  while {[llength $fanout_list] > 0} {
    set max_fanout [get_max_fanout $fanout_list]
    set max_tuple [lindex $max_fanout 0]
    set fanout_list [lindex $max_fanout 1]

    set fanout_key [lindex $max_tuple 0]
    set fanout_val [lindex $max_tuple 1]

    if {$fanout_val <= 1} {
      lappend zero_fanout_nets $fanout_key
    } else {
      lappend max_fanout_nets $fanout_key
      lappend max_fanout_vals $fanout_val
    }
  }

  puts $chan "\n=== TOP 10 NETS POR FANOUT ==="
  for {set i 0} {$i<10} {incr i} {
    set key [lindex $max_fanout_nets $i]
    set val [lindex $max_fanout_vals $i]
    puts $chan "$key: fanout = $val"
  }
  puts $chan "\n=== NETS COM FANOUT ZERO (POSSÍVEIS ERROS) ==="
  foreach net $zero_fanout_nets {
    puts $chan "$net"
  }
}
