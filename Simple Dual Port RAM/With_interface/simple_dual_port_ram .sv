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
logic [ifp.DATA_WIDTH-1:0] temp_read = 0;
logic [ifp.DATA_WIDTH-1:0] temp_read2 = 0;


///Reset
always @(posedge rst)
  for(int i=0;i<ifp.MEM_DEPTH;i++)begin
mem[i]=32'hFFFFFFFF;
end

always @(posedge clk)
if (ifp.wena) mem[ifp.addra] <= ifp.dina;
  
  
//read data from memory
always @(posedge clk)
  if (ifp.renb) 
  begin
  temp_read  <= mem[ifp.addrb];
  temp_read2 <= temp_read;
  ifp.doutb <= temp_read2;
  if (mem[ifp.addrb] == temp_read) ifp.dvalb <= 1;
  else ifp.dvalb <= 0;
  end
  
endmodule