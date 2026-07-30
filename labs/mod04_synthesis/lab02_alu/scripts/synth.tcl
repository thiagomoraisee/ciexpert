# ============================================================
# Script de Síntese - SAED32_EDK
# Suporte a SystemVerilog (.sv)
# ============================================================

# 1. CARREGAR CONFIGURAÇÃO
source ./scripts/.synopsys_dc.setup

# 2. LEAR O ARQUIVO RTL (SYSTEMVERILOG)
analyze -format sverilog ./rtl/alu_pkg.sv
analyze -format sverilog ./rtl/alu.sv

# 3. ELABORAR O DESIGN
elaborate alu

# 4. LINKAR O DESIGN
# O comando 'link' é necessário para resolver todas as referências
# e preparar o design para a síntese
# Pode ser suprimido para designs muito pequenoas, mas é recomendado para designs maiores
# Não é uma boa prática retirar o comando
link

if {![file exists ./reports]} {
   file mkdir ./reports
   puts "INFO: ./reports directory sucessfully created"
}

if {![file exists ./netlist]} {
   file mkdir ./netlist
   puts "INFO: ./netlist directory sucessfully created"
}

# 5. Gerar o arquivo de netlist não mapeado
# (opcional, mas útil para depuração)
write_file -format verilog -hier -out ./netlist/alu_nao_mapeada.v

# 6. CARREGAR CONSTRAINTS
read_sdc ./scripts/constraints.sdc

# 7. SÍNTESE (compile_ultra é mais agressivo que compile)
puts "\n============================================================"
puts "INICIANDO SÍNTESE (SystemVerilog)..."
puts "============================================================"
compile_ultra

# 8. RELATÓRIOS PÓS-SÍNTESE
puts "\n============================================================"
puts "RELATÓRIOS PÓS-SÍNTESE"
puts "============================================================"

# Relatório de área
report_area -hierarchy > ./reports/area_pos.rpt
puts "\n\[Área\] Relatório salvo em: area_pos.rpt"

# Relatório de timing (setup)
report_timing > ./reports/timing_relatorio.rpt
puts "\[Timing\] Relatório salvo em: timing_relatorio.rpt"

# Relatório de power
report_power > ./reports/power.rpt
puts "\[Power\] Relatório salvo em: power.rpt"

# Relatório de violações de setup
#report_constraint -all_violators -check_type setup -nosplit > setup_violations.rpt
report_constraint -all_violators -max_delay > ./reports/setup_violations.rpt
puts "\[Setup Violations\] Relatório salvo em: setup_violations.rpt"

# Relatório de violações de hold
#report_constraint -all_violators -check_type hold -nosplit > hold_violations.rpt
report_constraint -all_violators -min_delay > ./reports/hold_violations.rpt
puts "\[Hold Violations\] Relatório salvo em: hold_violations.rpt"

# 8. EXPORTAR NETLIST
# Formato Verilog (para simulação)
write -format verilog -hierarchy -output ./netlist/alu_mapeada.v
puts "\n\[Netlist\] SystemVerilog salvo em: alu_mapeada.sv"

# Formato DDC (binário Synopsys, mais rápido para ICC2)
write -format ddc -hierarchy -output ./netlist/alu_mapeada.ddc
puts "\[Netlist\] DDC salvo em: alu_mapeada.ddc"

## 9. SALVAR DESIGN EM MEMORY
#save_designs -force alu.db
#write -format db -hierarchy -output alu.db
#puts "\[Design\] Salvo em: alu.db"

# 10. FINALIZAR
puts "\n============================================================"
puts "SÍNTESE CONCLUÍDA COM SUCESSO (SystemVerilog)!"
puts "============================================================"
puts "Arquivos gerados:"
puts "  - netlist/alu_mapeada.sv (netlist SystemVerilog)"
puts "  - netlist/alu_mapeada.ddc (netlist DDC)"
puts "  - reports/area_pos.rpt (área)"
puts "  - reports/timing_relatorio.rpt (timing)"
puts "  - reports/power.rpt (potência)"
puts "============================================================"

#start_gui
