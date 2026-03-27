# ====================================================================================== #
# CI EXPERT - UFCG/CEEI                                                                  #
# -------------------------------------------------------------------------------------- #
# Script: design_hierarchy.tcl                                         Date: 2026.03.27  #
# Author: Thiago M. de Oliveira <thiago.oliveira@embedded.ufcg.edu.br>                   #
# Description: Netlist hierarchical tree generation.                                     #
# ====================================================================================== #

set netlist ../netlist.v
set total 0

proc search {start end file_name} {
  array set instances {}
  # Open the file in read mode
  if {[catch {open $file_name r} fileId]} {
      puts "ERRO: Arquivo não encontrado: $fileId"
      return
  }
  set line_counter 1
  while {[gets $fileId line] >= 0} {

    set line [string trim $line]
    if {$line_counter > $start && $line_counter < $end} {
      # Look for submodules and/or primitives
      set pattern {^(\w+)\s+\w+\s*\(}
      if {[regexp $pattern $line match instance]} {
        if {[info exists instances($instance)]} {
          incr instances($instance)
        } else {
          set instances($instance) 1
        }
      }
    }

    if {$line_counter > $end} {
      break
    }
    incr line_counter
  }
  # Close the file
  close $fileId
  return [array get instances]
}

proc find_modules {file_name} {
  set modules {}
  # Open the file in read mode
  if {[catch {open $file_name r} fileId]} {
      puts "ERRO: Arquivo não encontrado: $fileId"
      return
  }
  # Look for "module"<space>module_name<space>( pattern
  set pattern {module\s+(\w+)\s*\(}
  while {[gets $fileId line] >= 0} {
    if {[regexp $pattern $line match module_name]} {
      lappend modules $module_name
    }
  }
  # Close the file
  close $fileId 
  return $modules
}

proc find_limits {module_name file_name} {
  set limits {}
  # Open the file in read mode
  if {[catch {open $file_name r} fileId]} {
      puts "ERRO: Arquivo não encontrado: $fileId"
      return
  }
  # Look for "module"<space>module_name<space>( pattern
  set pattern "module\\s+(${module_name})\\s*\\("
  set line_counter 1
  set module_found 0
  while {[gets $fileId line] >= 0} {
    if {[regexp $pattern $line]} {
      lappend limits $line_counter
      set module_found 1
    } elseif {[regexp {endmodule} $line] && $module_found eq 1} {
      lappend limits $line_counter
      break
    }
    incr line_counter
  }

  # Close the file
  close $fileId 
  return $limits
}

# Print Report
puts "\n=== HIERARQUIA DO DESIGN ==="
set modules [find_modules $netlist]

foreach module $modules {
  puts "$module"

  set limits [find_limits $module $netlist]
  set begin [lindex $limits 0]
  set end [lindex $limits 1]
  set submodules [search $begin $end $netlist]

  if {$submodules eq ""} {
    puts "  └─ (módulo primitivo - sem submódulos)\n"
  } else {
    foreach submodule $submodules {
      if {[lsearch $modules $submodule] != -1} {
        set index [lsearch $submodules $submodule]
        puts "  ├─ $submodule ([lindex $submodules $index+1] instâncias)"
      }
    }
    puts "  └─ (apenas células primitivas)\n"
  }
}
