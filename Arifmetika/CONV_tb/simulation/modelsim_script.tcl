# create modelsim working library
vlib work

# compile all the Verilog sources
vlog  ../CONV_tb.v ../../conv.v 

# open the testbench module for simulation
vsim work.CONV_tb -novopt

# add all testbench signals to time diagram
add wave sim:/CONV_tb/*

# run the simulation
run -all

# expand the signals time diagram
wave zoom full
