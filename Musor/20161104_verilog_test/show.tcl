do compile.tcl

vsim -novopt tb.tb
add wave -position instertpoint \
    sim:/tb/clk \
    sim:/tb/resetn \
    sim:/tb/cnt \
    sim:/tb/out \
    sim:/tb/adder/sum
run 300ns
