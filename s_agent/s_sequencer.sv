`ifdef SEQUENCER_S
`define SEQUENCER_S

`include "uvm_macros.svh"
`include "s_seq_item.sv"
`include "s_sequence.sv"
//Import the UVM package
import uvm_pkg::*;
class s_sequencer extends uvm_sequencer#(s_seq_item);
   `uvm_component_utils(s_sequencer)
   //Constructor
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction
endclass
`endif
