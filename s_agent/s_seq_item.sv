`ifdef SEQ_ITEM_S
`define SEQ_ITEM_S
//Adding the UVM macros
`include "uvm_macros.svh"
//Importing the UVM package
import uvm_pkg::*;
class s_seq_item extends uvm_sequence_item;
   //variable declaration
   bit [31:0] paddr;
   rand bit [2:0] pprot;
   bit pselx;
   rand bit penable;
   bit pwrite;
   bit [31:0] pwdata;
   bit [3:0] pstrb;
   bit pready;
   rand bit [31:0] prdata;
   rand bit pslverr;

   //Utility macros
   `uvm_object_utils_begin(m_seq_item)
      `uvm_field_int(paddr,UVM_ALL_ON)	
      `uvm_field_int(pprot,UVM_ALL_ON)	
      `uvm_field_int(pselx,UVM_ALL_ONcons)	
      `uvm_field_int(penable,UVM_ALL_ON)	
      `uvm_field_int(pwrite,UVM_ALL_ON)	
      `uvm_field_int(pwdata,UVM_ALL_ON)	
      `uvm_field_int(pstrb,UVM_ALL_ON)	
      `uvm_field_int(pready,UVM_ALL_ON)	
      `uvm_field_int(prdata,UVM_ALL_ON)	
      `uvm_field_int(pslverr,UVM_ALL_ON)
   `uvm_object_utils_end

   //Constructor
   function new(string name = "s_seq_item");
      super.new(name);
   endfunction
endclass
`endif
