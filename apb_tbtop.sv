`timescale 1ns/1ps
`include "defines.sv"  
`include "uvm_macros.svh"
`include "intf.sv"
`include "apb_slave.v"
`include "apb_test.sv"
//Importing UVM package
import uvm_pkg::*;
module apb_tbtop(); 
   //Clock and reset signal declaration
   bit pclk;
   bit prst;
   //Interface instance
   intf vif(pclk,prst);
   //Clock generation
   initial
   begin
      forever #10 pclk = ~pclk;
   end
   //reset generation
   initial
   begin
      prst = 1;
      #10 prst = 0;
   end
   //DUT instance
   apb_slave #(.addrWidth(`addrWidth),
               .dataWidth(`dataWidth)
              )dut(.pclk(vif.pclk),
                   .prst(vif.prst),
                   .paddr(vif.paddr),
                   .pwrite(vif.pwrite),
                   .psel(vif.psel),
                   .pen(vif.pen),
                   .pwdata(vif.pwdata),
                   .prdata(vif.prdata),
                   .pready(vif.pready)
                   );
   initial 
   begin
      uvm_config_db #(virtual intf)::set(uvm_root::get(),"*","vif",vif);
      run_test("apb_test");
   end
   initial 
   begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
   end
endmodule
