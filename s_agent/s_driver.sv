`ifdef DRV
`define DRV

`include "uvm_macros.svh"
`include "s_seq_item.sv"
`include "s_sequencer.sv"
//Importing the UVM package
import uvm_pkg::*;
`define DRV_IF vif.DRIVER.drv_cb
class s_driver extends uvm_driver #(s_seq_item);
   //Declaring the virtual interface
   virtual intf vif;
   `uvm_component_utils(s_driver)
   
   //Constructor
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction
   
   //Build phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
         if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))
	    `uvm_fatal("NO_VIF",{"Virtual interface must be set for:",get_full_name,".vif"});
   endfunction

   //Run phase
   virtual task run_phase(uvm_phase phase);
      forever 
      begin
         seq_item_port.get_next_item(reqs);         
         drive();
 	 seq_item_port.item_done();
      end
   endtask

   //Drive
   virtual task drive();
      reqs.print();
	 `DRV_IF.pwrite <= 0;
	 @(posedge vif.DRIVER.pclk);
	 `DRV_IF.addr <= reqs.addr;
      if(reqs.pwrite == 1)
      begin
         `DRV_IF.pwrite <= reqs.pwrite;
	 reqs.pwdata <= `DRV_IF.pwdata;
         @(posedge vif.DRIVER.pclk);
      end
      if(reqs.pwrite == 0)
      begin
 	 `DRV_IF.pwrite <= reqs.pwrite;
	 @(posedge vif.DRIVER.pclk);
	 `DRV_IF.prdata = reqs.prdata;
      end
   endtask
endclass
`endif
