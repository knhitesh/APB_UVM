`ifdef SCOREBOARD
`define SCOREBOARD
`include "uvm_macros.svh"
`include "m_agent.sv"
//`include "s_agent.sv"
//Importing the UVM package
import uvm_pkg::*;
import master_pkg::*;
class apb_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(apb_scoreboard)
   m_seq_item req; //Driver data
   m_seq_item trans;  //Monitor data
   uvm_analysis_imp#(m_seq_item,apb_scoreboard) drv_scb;
   uvm_analysis_imp#(m_seq_item,apb_scoreboard) mon_scb;

   //Constructor
   function new(string name,uvm_component parent);
      super.new(new,parent);
      drv_scb = new("drv_scb",this);
      mon_scb = new("mon_scb",this);
   endfunction

   //Build phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction

   //Connect Phase
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction

   //Writing the data from driver
   virtual function void write(m_seq_item req);
      `uvm_info("SCB",$sformatf("driver_data received:",UVM_HIGH)
      req.print();
   endfunction

   //Writing the data from monitor
   virtual function void write(m_seq_item trans);
      `uvm_info("SCB",$sformatf("monitor_data received:",UVM_HIGH)
      trans.print();
   endfunction

   //Run phase
   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
   endtask

   //Check phase
   function void check_phase(uvm_phase phase);
      super.check_phase(phase);
      `uvm_info(get_type_name(),$sformatf("\n-------------------SCOREBOARD CHECK PHASE-------------------"),UVM_HIGH);
      `uvm_info(get_type_name(),$sformatf("Scoreboard check phase is starting"),UVM_HIGH);
   endfunction

   //Report phase
   function void report_phase(uvm_phase phase);
      super.report_phase(phase);
      `uvm_info("scoreboard",$sformatf("\n-------------------SCOREBOARD REPORT PHASE-------------------"),UVM_HIGH);
      `uvm_info(get_type_name(),$sformatf("Scoreboard report phase is starting"),UVM_HIGH);
   endfunction
endclass
`endif

