// Code your testbench here
// or browse Examples
`include "interface.sv";

module sdpr_tb;

logic clk;
bit rst;


localparam CLK_PERIOD = 10;
initial begin
clk = 0;
forever #(CLK_PERIOD/2) clk <= ~clk;
end



sdpram_if ifp();

simple_dual_port_ram DUT(

        .clk(clk),

        .rst(rst),       

        .ifp(ifp)

    );

  initial begin
    
/*  $dumpfile("dump.vcd"); $dumpvars;*/
     #(CLK_PERIOD * 2);
ifp.wena = 1'b1;
  ifp.addra = 10'd5;
  ifp.dina= 32'd350;
  
  #(CLK_PERIOD * 2);
  ifp.wena = 1'b1;
  ifp.addra = 10'd7;
  ifp.dina= 32'd670;
  
  #(CLK_PERIOD * 2);
   ifp.wena = 1'b0;
   ifp.renb= 1'b1;
   ifp.addrb = 10'd5;
   
   #(CLK_PERIOD);
    ifp.renb= 1'b1;
    ifp.addrb = 10'd7;
       
   #(CLK_PERIOD *3);
     ifp.wena = 1'b1;
     ifp.addra = 10'd5;
     ifp.dina= 32'd961;
     ifp.renb= 1'b1;
     ifp.addrb = 10'd5;
     
       #(CLK_PERIOD *3);
     
   
   end

endmodule
