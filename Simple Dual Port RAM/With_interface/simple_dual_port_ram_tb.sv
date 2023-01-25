module sdpr_tb;

logic clk;
bit rst;


localparam CLK_PERIOD = 10;
initial begin
clk = 0;
forever #(CLK_PERIOD/2) clk <= ~clk;
end



sdpram_if.sdp_s ifp;

simple_dual_port_ram DUT(

        .clk(clk),

        .rst(rst),       

        .ifp(ifp)

    );

  initial begin
  
  #(CLK_PERIOD / 2);
inf.wena = 1'b1;
  inf.addra = 10'd5;
  inf.dina= 32'd350;
  
  #(CLK_PERIOD * 2);
  inf.wena = 1'b1;
  inf.addra = 10'd7;
  inf.dina= 32'd670;
  
  #(CLK_PERIOD * 2);
   inf.wena = 1'b0;
   inf.renb= 1'b1;
   inf.addrb = 10'd5;
   
   #(CLK_PERIOD);
    inf.renb= 1'b1;
    inf.addrb = 10'd7;
       
   #(CLK_PERIOD *3);
     inf.wena = 1'b1;
     inf.addra = 10'd5;
     inf.dina= 32'd961;
     inf.renb= 1'b1;
     inf.addrb = 10'd5;
     
       #(CLK_PERIOD *3);
     
   
   end

endmodule
