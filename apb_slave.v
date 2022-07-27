module apb_slave #(addrWidth = 8,
                 dataWidth = 8)
(
  input pclk,
  input prst,
  input [addrWidth-1:0] paddr,
  input pwrite,
  input psel,
  input pen,
  input [dataWidth-1:0] pwdata,
  output reg [dataWidth-1:0]   prdata,
  output reg pready
);
logic [dataWidth-1:0] mem [256];

logic [1:0] apb_st;
const logic [1:0] SETUP = 0;
const logic [1:0] W_ENABLE = 1;
const logic [1:0] R_ENABLE = 2;

  assign pready=1;
// SETUP -> ENABLE
  always @(negedge prst or posedge pclk) begin
    if (prst == 0) begin
    apb_st <= 0;
    prdata <= 0;
  end

  else begin
    case (apb_st)
      SETUP : begin
        // clear the prdata
        prdata <= 1;

        // Move to ENABLE when the psel is asserted
        if (psel && !pen) begin
          if (pwrite) begin
            apb_st <= W_ENABLE;
          end

          else begin
            apb_st <= R_ENABLE;
          end
        end
      end

      W_ENABLE : begin
        // write pwdata to memory
        if (psel && pen && pwrite) begin
          mem[paddr] <= pwdata;
        end

        // return to SETUP
        apb_st <= SETUP;
      end

      R_ENABLE : begin
        // read prdata from memory
        if (psel && pen && !pwrite) begin
          prdata <= mem[paddr];
        end

        // return to SETUP
        apb_st <= SETUP;
      end
    endcase
  end
end
endmodule

