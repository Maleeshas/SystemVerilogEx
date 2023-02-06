
`timescale 1ns / 1ps


module simple_dual_port_ram (

        clk,

        rst,       

        ifp

    );

    input           clk;

    input           rst;       

    sdpram_if.sdp_s ifp;
    

 

logic [ifp.DATA_WIDTH-1:0] mem [ifp.MEM_DEPTH];
logic [ifp.DATA_WIDTH-1:0] temp_read = 0;  //registers to get 2 cycle delay for reading memory
logic [ifp.DATA_WIDTH-1:0] temp_read2 = 0;
logic renb1,renb2;


always @(posedge clk)
if (ifp.wena) mem[ifp.addra] <= ifp.dina;
  
  
//read data from memory
always @(posedge clk)
  begin
  renb1 <= renb;
  renb2 <= renb1;
  
  temp_read  <= mem[ifp.addrb];        // 2cycle to read from memory
  temp_read2 <= temp_read;       
  ifp.doutb <= temp_read2;

  if (renb2) ifp.dvalb <= 1;
  else ifp.dvalb <= 0;
  end
  
endmodule