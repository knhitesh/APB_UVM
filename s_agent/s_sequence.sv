`ifdef SEQ_S
`define SEQ_S

`include "uvm_macros.svh"
`include "s_seq_item.sv"
//Import the UVM package
import uvm_pkg::*;
class s_sequence extends uvm_sequence#(s_seq_item);
   `uvm_sequence_utils(s_sequence,s_sequencer)
   //Constructor
   function new(string name = "s_sequence");
      super.new(name);
   endfunction
   //Method call for handshake between sequence, sequencer and driver
   virtual task body();
      reqs = s_seq_item::type_id::create("reqs");
      wait_for_grant();
      reqs.randomize();
      send_request(reqs);
      wait_for_item_done();
   endtask
endclass

//Write Sequence
class s_wr_sequence extends uvm_sequence#(s_seq_item);
   `uvm_object_utils(s_wr_sequence)
   //Constructor
   function new(string name = "s_wr_sequence");
      super.new(name);
   endfunction
   
   virtual task body();
      `uvm_do_with(reqs,{reqs.pwrite == 1;})
   endtask
endclass

//Read Sequence
class s_rd_sequence extends uvm_sequence#(s_seq_item);
   `uvm_object_utils(s_rd_sequence)
   //Constructor
   function new(string new = "s_rd_sequence");
      super.new(name);
   endfunction

   virtual task body();
      `uvm_do_with(reqs,{reqs.pwrite == 0;})
   endtask
endclass
`endif
