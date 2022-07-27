`ifdef DRV
`define DRV

`include "uvm_macros.svh"
`include "m_seq_item.sv"
`include "m_sequencer.sv"
//Importing the UVM package
import uvm_pkg::*;
`define DRV_IF vif.DRIVER.drv_cb
class m_driver extends uvm_driver #(m_seq_item);
   //Declaring the virtual interface
   virtual intf vif;
   `uvm_component_utils(m_driver)
   uvm_analysis_port#(m_seq_item) drv2scb;
   
   //Constructor
   function new(string name,uvm_component parent);
      super.new(name,parent);
      drv2scb = new("drv2scb",this);
   endfunction
   
   //Build phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
         if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))
	    `uvm_fatal("NO_VIF",{"Virtual interface must be set for:",get_full_name,".vif"});
   endfunction

   //Run phase
   virtual task run_phase(uvm_phase phase);
      m_seq_item req;
      forever 
      begin
         seq_item_port.get_next_item(req);         
         if(req.pwrite == 1)
         begin
             wr_data(req);
         end
         else
         begin
             rd_data(req);
         end
 	 seq_item_port.item_done();
      end
   endtask

   //Task for Write data
   task wr_data(input m_seq_item req);
       vif.drv_cb.psel <= 1;
       vif.drv_cb.pwrite <= 1;
       vif.drv_cb.paddr <= req.addr;
       vif.drv_cb.pwdata <= req.pwdata;
       vif.drv_cb.pwdata <= 0;
       @(vif.drv_cb);
       vif.drv_cb.pen <= 1;
       @(vif.drv_cb);
       wait(vif.drv_cb.pen == 1);
       vif.drv_cb.pen <= 0;
       vif.drv_cb.psel <= 0;
       @(vif.drv_cb);
   endtask:

   //Task for Read data
    task rd_data(input m_seq_item req);
        vif.drv_cb.psel <= 1;
        vif.drv_cb.pwrite <= 0;
        vif.drv_cb.paddr <= req.paddr;
        vif.drv_cb.pen <= 0;
        @(vif.drv_cb);
        vif.drv_cb.pen <= 1;
        wait(vif.mon_cb.pready == 1);
        vif.drv_cb.pen <= 0;
        vif.drv_cb.psel <= 0;
    endtask:
endclass
`endif
