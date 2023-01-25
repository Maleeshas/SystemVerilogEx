// Code your design here
`timescale 1ns / 1ps


module simple_dual_port_ram #(

        parameter DATA_WIDTH = 32,

        parameter MEM_DEPTH  = 1024,      

        parameter BYTE_WRITE = 0

) ( clk,rst,addra,wena,dina,addrb,doutb,renb,dvalb);

 
localparam ADDR_WIDTH = $clog2(MEM_DEPTH);

localparam STRB_WIDTH = BYTE_WRITE ? (DATA_WIDTH/8) : 1;

              

                          

    input logic [ADDR_WIDTH-1:0]  addra;   

    input logic [STRB_WIDTH-1:0]   wena;

    input logic [DATA_WIDTH-1:0]  dina;  

 

    input logic [ADDR_WIDTH-1:0]  addrb;   

    input logic     renb;

    output logic [DATA_WIDTH-1:0]  doutb;

    output logic     dvalb;
    
    logic [DATA_WIDTH-1:0] temp_read = 0; //registers to get 2 cycle delay for reading memory

     logic [DATA_WIDTH-1:0] temp_read2 = 0;
 

//---------------------------------------------------------------------------------------------------------------------

// I/O signals

//---------------------------------------------------------------------------------------------------------------------

    input           clk;

    input           rst;       


       

 

//---------------------------------------------------------------------------------------------------------------------

// Implementation

//---------------------------------------------------------------------------------------------------------------------
//Memory unpacked array
  logic [DATA_WIDTH-1:0] mem [MEM_DEPTH];


//Reset
always @(posedge rst)
  for(int i=0;i<MEM_DEPTH;i++)begin
mem[i]=32'h0;
end

//write data from memory
always @(posedge clk)
if (wena) mem[addra] <= dina;
  
  
//read data from memory
always @(posedge clk)
  if (renb) 
  begin
  temp_read  <= mem[addrb];   // 2cycle to read from memory
  temp_read2 <= temp_read;
  doutb <= temp_read2;
  if (mem[addrb] == temp_read) dvalb <= 1;
  else dvalb <= 0;
  end
  

endmodule
