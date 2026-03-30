# ====================================================================================== #
# CI EXPERT - UFCG/CEEI                                                      2026.03.25  #
# -------------------------------------------------------------------------------------- #
# Author: Thiago M. de Oliveira <ciexpert.aluno101@embedded.ufcg.edu.br>                 #
# Description: Contagem de inst6ancias de cada tipo de célula no arquivo de netlist.     #
# ====================================================================================== #

proc count_cells {netlist {chan stdout}} {

  array set cells {}
  if {[catch {open $netlist r} fd]} {
      puts "ERRO: Arquivo não encontrado: $fd"
      return
  }

  while {[gets $fd line] >= 0} {
    set line [string trim $line]
    # Pass blank lines, comments and modules declarations
    if {$line eq "" || [string match "//*" $line] 
        || [string match "/*" $line] 
        || [string match "module*" $line]} {
      continue
    }

    # Search for REGEX pattern "CELL Name (":
    # ^(\w+): First word in line is the CELL name
    # \s    : A space after CELL name
    # \w    : A word (name of instance after the cell)
    # \s(   : A space followed by a "(" indicates the port list

    if {[regexp {^(\w+)\s+\w+\s*\(}  $line match cell_type]} {
      if {[info exists cells($cell_type)]} {
        incr cells($cell_type)
      } else {
        set cells($cell_type) 1
      }
    }
  }
  close $fd
  return [array get cells]
}

proc report_cells {netlist {chan stdout}} {
  set total 0
  array set cells [count_cells $netlist]

  puts $chan "=== RELATÓIRO DE CÉLULAS ==="
  foreach cell [lsort [array names cells]] {
    puts $chan [format "%s: %s instâncias" $cell $cells($cell)]
    set total [expr {$total + $cells($cell)}]
  }
  puts $chan "TOTAL: $total instâncias"
}
