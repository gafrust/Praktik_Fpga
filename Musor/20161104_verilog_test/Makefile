INC=inc
SRC=test.v my_adder.v

.PHONY: compile

all: show

show: compile
	vsim -do show.tcl

batch: compile
	vsim -c -do batch.tcl

compile: tb
	if [ -f vlog.opt ]; then rm vlog.opt; fi
	for i in $(INC); do \
		echo "+incdir+$$i" >> vlog.opt; \
	done

	if [ -f compile.tcl ]; then rm -f compile.tcl; fi
	for i in $(SRC); do \
		echo "vlog -reportprogress 300 -work tb $$i" >> compile.tcl; \
	done

tb:
	if [ ! -d tb ]; then \
	    vsim -c -do lib.tcl; \
	fi

clean:
	rm -Rf *.txt transcript vsim.wlf tb vlog.opt
