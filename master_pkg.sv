`ifdef MASTER_PACKAGE
`define MASTER_PACKAGE
package master_pkg;
   `include "uvm_macros.svh"
   import uvm_pkg::*;
   `include "m_seq_item.sv"
   `include "m_sequence.sv"
   `include "m_sequencer.sv"
   `include "m_driver.sv"
   `include "m_monitor.sv"
   `include "m_agent.sv"
endpackage
`endif
