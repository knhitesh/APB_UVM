`ifdef SEQ
`define SEQ

`include "uvm_macros.svh"
`include "m_seq_item.sv"
//Import the UVM package
import uvm_pkg::*;
class m_sequence extends uvm_sequence#(m_seq_item);
   `uvm_sequence_utils(m_sequence,m_sequencer)
   //Constructor
   function new(string name = "m_sequence");
      super.new(name);
   endfunction
   //Method call for handshake between sequence, sequencer and driver
   virtual task body();
      req = m_seq_item::type_id::create("req");
      wait_for_grant();
      req.randomize();
      send_request(req);
      wait_for_item_done();
   endtask
endclass

//Write Sequence
class m_wr_sequence extends m_sequence#(m_seq_item);
   `uvm_object_utils(m_wr_sequence)
   //Constructor
   function new(string name = "m_wr_sequence");
      super.new(name);
   endfunction
   
   virtual task body();
      `uvm_do_with(req,{req.pwrite == 1;})
   endtask
endclass

//Read Sequence
class m_rd_sequence extends m_sequence#(m_seq_item);
   `uvm_object_utils(m_rd_sequence)
   //Constructor
   function new(string new = "m_rd_sequence");
      super.new(name);
   endfunction

   virtual task body();
      `uvm_do_with(req,{req.pwrite == 0;})
   endtask
endclass
`endif
