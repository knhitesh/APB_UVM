`ifdef ENVIRONMENT
`define ENVIRONMENT
`include "uvm_macros.svh"
`include "m_agent.sv"
//`include "s_agent.sv"
`include "apb_scoreboard.sv"
//Importing the UVM package
import uvm_pkg::*;
import master_pkg::*;
class apb_environment extends uvm_env;
   `uvm_component_utils(apb_environment);
   m_agent agtm;
   //s_agent agts;
   apb_scoreboard scb;

   //Virtual Interface
   virtual intf vif;

   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction

   //Build phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agtm = m_agent::type_id::create("agtm",this);
      //agts = s_agent::type_id::create("agts",this);
      scb = apb_scoreboard::type_id::create("scb",this);
      if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))
      begin
	 `uvm_fatal("build phase","No virtual interface specified for this environment")
      end
      uvm_config_db#(virtual intf)::set(this,"","vif",vif);
   endfunction

   //Connect phase
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      agtm.driver.drv2scb.connect(scb.drv_scb);      
      agtm.monitor.item_collected_port.connect(scb.mon_scb);
      //agts.monitor.item_collected_port.connect(scb.s_trans);
   endfunction

   //Run phase
   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
   endtask
endclass
`endif
