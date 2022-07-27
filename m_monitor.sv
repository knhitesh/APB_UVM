`ifdef MON
`define MON
//Importing the UVM package
import uvm_pkg::*;
`include "uvm_macros.svh"
class m_monitor extends uvm_monitor;
   //Virtual Interface
   virtual intf vif;
   //Sequence item handle
   m_seq_item trans;

   `uvm_component_utils(m_monitor)
    //Analysis port to connect monitor and scoreboard
    uvm_analysis_port#(m_seq_item) item_collected_port;

   //Constructor
   function new(string name,uvm_componet parent);
      super.new(name,parent);
      item_collected_port = new("item_collected_port",this);
   endfunction

   //Build phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
         if(!uvm_config_db #(virtual intf)::get(this,"","vif",vif))
	    uvm_fatal("NO_VIF",{"Virtual interface must be set for: ",get_full_name(),".vif"});
   endfunction

   //Run phase
   /*virtual task run_phase(uvm_phase phase);
      forever
      begin
	 @(posedge vif.MONITOR.pclk);
	 wait(vif.mon_cb.pwrite);
	 trans.paddr = vif.moni_cb.paddr;
	 if(vif.mon_cb.pwrite == 1)
	 begin
	    trans.pwrite = 1;
	    trans.pwdata = vif.mon_cb.pwdata;
	    @(posedge vif.MONITOR.pclk);
	 end
	 if(vif.mon_cb.pwrite == 0)
	 begin
	    trans.pwrite = vif.mon_cb.pwrite;
	    trans.pwrite = 0;
	    @(posedge vif.MONITOR.pclk);
	    @(posedge vif.MONITOR.pclk);
 	    trans.prdata = vif.mon_cb.prdata;
	 end
	 item_collected_port.write(trans);
      end
   endtask*/
    
   virtual task run_phase(uvm_phase phase);
       super.run_phase(phase);
        
       forever 
       begin
         if(vif.prst ==0) begin
           if(vif.psel) begin
               while(vif.pen) begin
                   // create seq_item
                   trans = m_seq_item::type_id::create("trans");
                    
                   wait(vif.pready ==1);
                   if(vif.pwrite == 1) begin
                       if(vif.pslverr) begin
                               `uvm_info("DUT_ERROR_TEST", $sformatf("DUT has successfully detected ADDRESS OUT OF BOUND Error and Error response is triggered"), UVM_NONE)
                               @(vif.drv_cb);                            
                           else begin
                               `uvm_error("DUT_OP_ERROR", $sformatf("DUT has report an error during write operation using PSLVERR signal."))
                               @(vif.drv_cb);
                           end
                       end
                       else begin
                           trans.paddr = vif.paddr;
                           trans.pwdata = vif.pwdata;
                           @(vif.drv_cb);
                       end    
                   end
                   else if(vif.pwrite == 0) begin
                       if(vif.pslverr) begin
                               `uvm_info("DUT_ERROR_TEST", $sformatf("DUT has successfully detected ADDRESS OUT OF BOUND Error and Error response is triggered"), UVM_NONE)
                               @(vif.drv_cb);
                           else begin
                               `uvm_error("DUT_OP_ERROR", $sformatf("DUT has report an error during read operation using PSLVERR signal."))
                               @(vif.drv_cb);
                           end
                       end
                       else begin
                           trans.paddr = vif.paddr;
                           trans.prdata = vif.prdata;
                           @(vif.drv_cb);
                           @(vif.mon_cb);
                           // send the item to scoreboard for checking
                           item_collected_port.write(trans);
                       end
                   end
               end
           end
           @(vif.mon_cb);
         end
         else begin
              trans.paddr = 0;
              trans.pwrite = 0;
              trans.pwdata = 0;
              trans.psel = 0;
              trans.pen = 0;
              trans.rwdata = 0;
              trans.pready = 0;
              trans.pslverr = 0;
         end
       end 
   endtask
endclass	
`endif    
