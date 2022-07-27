`ifdef SEQUENCER
`define SEQUENCER

`include "uvm_macros.svh"
`include "m_seq_item.sv"
`include "m_sequence.sv"
//Import the UVM package
import uvm_pkg::*;
class m_sequencer extends uvm_sequencer#(m_seq_item);
   `uvm_component_utils(m_sequencer)
   //Constructor
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction
endclass
`endif
