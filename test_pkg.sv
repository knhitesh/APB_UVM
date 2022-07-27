`ifdef TEST_PACKAGE
`define TEST_PACKAGE
package test_pkg;
   `include "uvm_macros.svh"
   import uvm_pkg::*;
   `include "defines.sv"
   import master_pkg::*;
   `include "apb_scoreboard.sv"
   `include "apb_environment.sv"
   `include "apb_test.sv"
endpackage
`endif
