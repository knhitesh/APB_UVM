`ifdef SLAVE_PACKAGE
`define SLAVE_PACKAGE
package slave_pkg;
   `include "uvm_macros.svh"
   import uvm_pkg::*;
   `include "s_seq_item.sv"
   `include "s_sequence.sv"
   `include "s_sequencer.sv"
   `include "s_driver.sv"
   `include "s_monitor.sv"
   `include "s_agent.sv"
endpackage
`endif
