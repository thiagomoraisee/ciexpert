# ============================================================
# Script de Síntese
# ============================================================

# ------------------------------------------------------------
# Carregar configuração
# ------------------------------------------------------------

source synth/.synopsys_dc.setup

# ------------------------------------------------------------
# Ler RTL
# ------------------------------------------------------------

analyze -format sverilog rtl/accumulator_pkg.sv
analyze -format sverilog rtl/accumulator.sv

# ------------------------------------------------------------
# Elaborar
# ------------------------------------------------------------

elaborate accumulator

link

# ------------------------------------------------------------
# Constraints
# ------------------------------------------------------------

source synth/constraints.sdc
# ------------------------------------------------------------
# Verificação do design
# ------------------------------------------------------------

puts "\n=================================================="
puts "CHECK DESIGN"
puts "=================================================="

check_design

# ------------------------------------------------------------
# Relatórios pré-síntese
# ------------------------------------------------------------

redirect synth/area_pre.rpt {
report_area -hierarchy
}

redirect synth/timing_pre.rpt {
report_timing -max_paths 10
}

# ------------------------------------------------------------
# Síntese
# ------------------------------------------------------------

puts "\n=================================================="
puts "INICIANDO SÍNTESE"
puts "=================================================="

compile_ultra -no_autoungroup

# ------------------------------------------------------------
# Relatórios pós-síntese
# ------------------------------------------------------------

redirect synth/area_pos.rpt {
report_area -hierarchy
}

redirect synth/timing_relatorio.rpt {
report_timing -max_paths 10
}

redirect synth/power.rpt {
report_power
}

redirect synth/setup_violations.rpt {
report_constraint -all_violators
}

# ------------------------------------------------------------
# Exportar netlist
# ------------------------------------------------------------

write -format verilog -hierarchy -output synth/accumulator_syn.v

write -format ddc -hierarchy -output synth/accumulator_syn.ddc

# ------------------------------------------------------------
# Salvar sessão do DC
# ------------------------------------------------------------

write_file -format ddc -hierarchy -output synth/accumulator.ddc

puts "\n=================================================="
puts "SÍNTESE CONCLUÍDA"
puts "=================================================="
puts "Arquivos gerados:"
puts "  synth/area_pos.rpt"
puts "  synth/timing_relatorio.rpt"
puts "  synth/power.rpt"
puts "  synth/setup_violations.rpt"
puts "  synth/accumulator_syn.v"
puts "  synth/accumulator_syn.ddc"
puts "=================================================="
