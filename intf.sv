interface intf(input bit pclk,input bit prst);
   logic [7:0] paddr;
   logic pwrite;
   logic psel;
   logic pen;
   logic [7:0] pwdata;
   logic [7:0] prdata;
   logic pready;

   //Cloking block for driver
   clocking drv_cb@(posedge pclk);
      //Default input and output declaration
      default input #0 output #0;
      output paddr;
      output pwrite;
      output psel;
      output pen;
      output pwdata;
   endclocking

   //Clocking block for monitor
   clocking mon_cb@(posedge pclk);
      //Default input and output declaration
      default input #0 output #0;
      input pready;
      input prdata;
   endclocking

   //Modport declarations
   modport DRIVER(clocking drv_cb,input pclk);
   modport MONITOR(clocking mon_cb,input pclk);
endinterface

