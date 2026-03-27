# ====================================================================================== #
# CI EXPERT - UFCG/CEEI                                                                  #
# -------------------------------------------------------------------------------------- #
# Script: connection_statistics.tcl                                    Date: 2026.03.27  #
# Author: Thiago M. de Oliveira <thiago.oliveira@embedded.ufcg.edu.br>                   #
# Description: Identify design nets and calculate the fanout.                            #
# ====================================================================================== #

set netlist ../netlist.v

proc count_fanout {start end file_name} {
  array set fanout {}

  # Open the file in read mode
  if {[catch {open $file_name r} fileId]} {
      puts "ERRO: Arquivo não encontrado: $fileId"
      return
  }

  set line_counter 1
  while {[gets $fileId line] >= 0} {
    if {$line_counter >= $start && $line_counter <= $end} {
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
  puts $max_val
  puts $max_pos

  lappend max_fanout [lindex $fanout_list [expr {2 * $max_pos }]]
  lappend max_fanout [lindex $fanout_list [expr {2 * $max_pos +1}]]

  set fanout_list [lreplace $fanout_list [expr {2 * $max_pos}] [expr {2 * $max_pos + 1}] ]

  return $max_fanout
}






# Print Report
puts "\n=== TOP 10 NETS POR FANOUT ==="
puts "\n=== NETS COM FANOUT ZERO ==="

set f [count_fanout 0 16 $netlist]
puts $f
puts [get_max_fanout $f ]
puts $f

                  
