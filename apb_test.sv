`ifdef TEST
`define TEST
`include "uvm_macros.sv"
`include "apb_environment.sv"
//Importing the UVM package
import uvm_pkg::*;
class apb_test extends uvm_test;
   `uvm_component_utils(apb_test)
   apb_environment env;
   m_sequence mseq;
   //s_sequence sseq;

   //Constructor
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction

   //Build phase
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = apb_environment::type_id::create("env",this);
      mseq = m_sequence::type_id::cretae("mseq");
      //sseq = s_sequence::type_id::cretae("sseq");
      if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))
      begin
         uvm_fatal("build_phase", "No virtual interface in the test")
      end
      uvm_config_db#(virtual intf)::set(this,"","vif",vif);
   endfunction

   //Connect phase
   virtual function void connect_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction

   //Run phase
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      mseq.start(env.agtm.sequencer);
      //sseq.start(env.agts.sequencer);
      phase.drop_objection(this);
   endtask

   //Write test case
   task wr_test(input [7:0] paddr,input [7:0] pwdata);
      m_wr_sequence wr_seq; //Creating the write task handle
      //Create sequence
      wr_seq = m_wr_sequence::type_id::create("wr_seq",this);
      //Configure sequence
      wr_seq.paddr = paddr;
      wr_seq.pwdata = pwdata;
      //Start sequence
      wr_seq.start(env.agtm.sequencer);
   endtask

   //Read test case
   task rd_test(input [7:0] paddr);
      m_rd_sequence rd_seq; //Creating the write task handle
      //Create sequence
      rd_seq = m_rd_sequence::type_id::create("rd_seq",this);
      //Configure sequence
      rd_seq.paddr = paddr;
      //Start sequence
      rd_seq.start(env.agtm.sequencer);
   endtask
endclass
`endif
