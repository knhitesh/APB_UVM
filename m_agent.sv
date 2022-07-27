`ifdef AGENTM
`define AGENTM
`include "m_sequencer.sv"
`include "m_driver.sv"
`include "m_monitor.sv"
class m_agent extends uvm_agent;
   m_sequencer sequencer;
   m_driver driver;
   m_monitor monitor;

   //UVM Macros
   'uvm_component_utils(m_agent)
   
   //constructor
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction

   //Build Phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(get_is_active() == UVM_ACTIVE)
      begin
         sequencer = m_sequencer::type_id::create("sequencer",this);
         driver = m_driver::type_id::create("driver",this);
         end
	 monitor = m_monitor::type_id::create("monitor",this);
   endfunction:build_phase

   //Connect Phase
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(get_is_active() == UVM_ACTIVE)
      begin
	 driver.seq_item_port.connect(sequencer.seq_item_export);
      end
   endfunction:connect_phase
endclass
`endif
