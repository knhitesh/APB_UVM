all:
	make clean; make sim; make clean;

VCS_CMD_RAND = vcs -V -R  -full64 -sverilog +v2k -debug_access+all -ntb_opts uvm-1.2 -debug_pp +ntb_random_seed_automatic -override_timescale=1ns/1ps -gui -kdb
 
sim:
	${VCS_CMD_RAND} \
        +incdir+./ \
        ./apb_tbtop.sv \
        #./intf.sv \
	#./apb_test.sv \
	#./apb_slave.v \
	+UVM_VERBOSITY=MEDIUM \
	+plusarg_ignore \
	-l transcript_vcs.log

	#+incdir+/projects/UVM/uvm-1.2/src \
	#/projects/UVM/uvm-1.2/src/uvm_pkg.sv \

	#vsim -novopt work.hvl_top work.hdl_top -c -do "log -r /*; add wave -r /*; run -all;" \
	#-wlf waveform.wlf
	# To open the waveform use the below command 
	# vsim -view waveform.wlf &

clean:
	rm -rf work/ transcript waveform.wlf
