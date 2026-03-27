# ====================================================================================== #
# CI EXPERT - UFCG/CEEI                                                      2026.03.25  #
# -------------------------------------------------------------------------------------- #
# Author: Thiago M. de Oliveira <ciexpert.aluno101@embedded.ufcg.edu.br>                 #
# Description: Contagem de inst6ancias de cada tipo de célula no arquivo de netlist.     #
# ====================================================================================== #

set filename contador_netlist.tcl 

array set cells {}
set total 0

if {[catch {open $filename r} fileId]} {
    puts "ERRO: Arquivo não encontrado: $fileId"
    return
}

while {[gets $fileId line] >= 0} {
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

close $fileId

# Print Report
puts "=== RELATÓIRO DE CÉLULAS ==="
foreach cell [lsort [array names cells]] {
  puts [format "%s: %s instâncias" $cell $cells($cell)]
  set total [expr {$total + $cells($cell)}]
}
puts "TOTAL: $total instâncias"
