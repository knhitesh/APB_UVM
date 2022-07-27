`ifdef SEQ_ITEM
`define SEQ_ITEM
//Adding the UVM macros
`include "uvm_macros.svh"
//Importing the UVM package
import uvm_pkg::*;
class m_seq_item extends uvm_sequence_item;
   //variable declaration
   rand bit [7:0] paddr;
   rand bit psel;
   rand bit pen;
   rand bit pwrite;
   rand bit [7:0] pwdata;
   bit pready;
   bit [7:0] prdata;

   //Utility macros
   `uvm_object_utils_begin(m_seq_item)
      `uvm_field_int(paddr,UVM_ALL_ON)	
      `uvm_field_int(psel,UVM_ALL_ON)	
      `uvm_field_int(pen,UVM_ALL_ON)	
      `uvm_field_int(pwrite,UVM_ALL_ON)	
      `uvm_field_int(pwdata,UVM_ALL_ON)	
      `uvm_field_int(pready,UVM_ALL_ON)	
      `uvm_field_int(prdata,UVM_ALL_ON)
   `uvm_object_utils_end

   //Constructor
   function new(string name = "m_seq_item");
      super.new(name);
   endfunction
endclass
`endif
