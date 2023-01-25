// Testbench
module test #(
  parameter DATA_WIDTH = 32,

  parameter MEM_DEPTH  = 1024,      

  parameter BYTE_WRITE = 0);

localparam ADDR_WIDTH = $clog2(MEM_DEPTH);

localparam STRB_WIDTH = BYTE_WRITE ? (DATA_WIDTH/8) : 1;
  
  
  logic clk ;
  bit rst;
  
  logic [ADDR_WIDTH-1:0]  addra;   

  logic [STRB_WIDTH-1:0]   wena;

  logic [DATA_WIDTH-1:0]  dina;  

 

    logic [ADDR_WIDTH-1:0]  addrb;   

    logic                                      renb;

    logic [DATA_WIDTH-1:0]  doutb;

    logic                                     dvalb;;

logic  [DATA_WIDTH-1:0] temp_read;
localparam CLK_PERIOD = 10;
initial begin
clk = 0;
forever #(CLK_PERIOD/2) clk <= ~clk;
end
  
  simple_dual_port_ram #(32, 1024, 0) RAM(.clk(clk),
                                          .rst(rst),
                                          .addra(addra),.
                                          wena(wena),
                                          .dina(dina),
                                          .addrb(addrb),
                                          .doutb(doutb),
                                          .renb(renb),
                                          .dvalb(dvalb));
  

  initial begin
  
  #(CLK_PERIOD / 2);
  wena = 1'b1;
  addra = 10'd5;
  dina= 32'd350;
  
  #(CLK_PERIOD * 2);
  wena = 1'b1;
  addra = 10'd7;
  dina= 32'd670;
  
  #(CLK_PERIOD * 2);
   wena = 1'b0;
   renb= 1'b1;
   addrb = 10'd5;
   
   #(CLK_PERIOD);
    renb= 1'b1;
    addrb = 10'd7;
       
   #(CLK_PERIOD *3);
     wena = 1'b1;
     addra = 10'd5;
     dina= 32'd961;
     renb= 1'b1;
     addrb = 10'd5;
     
    #(CLK_PERIOD *3);
    wena = 1'b0;
    rst =1;
    renb= 1'b1;
    addrb = 10'd5;
    
    #(CLK_PERIOD *3);
    
    renb= 1'b1;
    addrb = 10'd5;
    #(CLK_PERIOD *2);
    
    
    
 
  

  end
    

endmodule