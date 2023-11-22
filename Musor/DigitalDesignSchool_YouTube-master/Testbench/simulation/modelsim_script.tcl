# create modelsim working library
vlib work

# compile all the Verilog sources
vlog  ../testbench.v ../../top.v 

# open the testbench module for simulation
#vsim work.testbench
vsim work.testbench -novopt
# add all testbench signals to time diagram
add wave sim:/testbench/*

# run the simulation
run -all

# expand the signals time diagram
wave zoom full
