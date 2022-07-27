`ifdef MON
`define MON
//Importing the UVM package
import uvm_pkg::*;

`include "uvm_macros.svh"
class s_monitor extends uvm_monitor;
   //Virtual Interface
   virtual intf vif;
   //Sequence item handle
   s_seq_item trans;

   `uvm_component_utils(s_monitor)
    uvm_analysis_port#(s_seq_item) item_collected_port;

   //Constructor
   function new(string name,uvm_componet parent);
      super.new(name,parent);
      item_collected_port = new("item_collected_port",this);
   endfunction

   //Build phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
         if(!uvm_config_db #(virtual intf)::get(this,"","vif",vif))
	    uvm_fatal("NO_VIF",{"Virtual interface must be set for: ",get_full_name(),".vif"});
   endfunction

   //Run phase
   virtual task run_phase(uvm_phase phase);
      forever
      begin
	 @(posedge vif.MONITOR.pclk);
	 wait(vif.mon_cb.pwrite);
	 trans.paddr = vif.mon_cb.paddr;
	 if(vif.mon_cb.pwrite == 1)
	 begin
	    trans.pwrite = 1;
	    trans.pwdata = vif.mon_cb.pwdata;
	    @(posedge vif.MONITOR.pclk);
	 end
	 if(vif.mon_cb.pwrite == 0)
	 begin
	    trans.pwrite = vif.mon_cb.pwrite;
	    trans.pwrite = 0;
	    @(posedge vif.MONITOR.pclk);
	    @(posedge vif.MONITOR.pclk);
 	    trans.prdata = vif.mon_cb.prdata;
	 end
	 item_collected_port.write(trans);
      end
   endtask
endclass	
`endif    
