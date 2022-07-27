`ifdef AGENTS
`define AGENTS
class s_agent extends uvm_agent;
   s_sequencer sequencer;
   s_driver driver;
   s_monitor monitor;

   //UVM Macros
   'uvm_component_utils(s_agent)
   
   //constructor
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction

   //Build Phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(get_is_active() == UVM_ACTIVE)
      begin
         sequencer = s_sequencer::type_id::create("sequencer",this);
         driver = s_driver::type_id::create("driver",this);
         end
	 monitor = s_monitor::type_id::create("monitor",this);
   endfunction

   //Connect Phase
   function void connect_phase(uvm_phase phase);
      if(get_is_active() == UVM_ACTIVE)
      begin
	 driver.seq_item_port.connect(sequencer.seq_item_export);
      end
   endfunction
endclass
`endif
