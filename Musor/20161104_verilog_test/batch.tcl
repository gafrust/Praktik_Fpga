do compile.tcl

vsim -novopt tb.tb
run 300ns
quit -f
