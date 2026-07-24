set TB_TOP [lindex $argv 0]
set FPGA_VARIANT xc7a100tcsg324-1

# Create project
create_project -force sim_project ./sim_project -part $FPGA_VARIANT

# Add sources
#add_files {../ip/wishbone/wishbone_slave.sv ../ip/swap/swap.v ../ip/nexus/nexus.v}
add_files -fileset sim_1 [glob ../rtl/src/*.sv]
add_files -fileset sim_1 [glob ../rtl/tb/*.sv]

# Set testbench as top
set_property top $TB_TOP [get_filesets sim_1]

set_msg_config -id {USF-XSim-96} -suppress
set_msg_config -id {USF-XSim-97} -suppress
set_msg_config -id {Simulation 116-44} -suppress

# Waveform
#add_files -fileset sim_1 -norecurse waves/tb_behav.wcfg
#set_property xsim.view waves/tb_behav.wcfg [get_filesets sim_1]

# Launch simulation (behavioral)
launch_simulation -verbose
run 2000ms
