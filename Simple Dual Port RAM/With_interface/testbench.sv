// Code your testbench here
// or browse Examples
`include "interface.sv";

module sdpr_tb;

logic clk;
bit rst;
localparam REPETITONS = 10000; // no of repitions to test

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
    
 // defined to imitate memory behavior   
logic [ifp.DATA_WIDTH-1:0] mem_chk [ifp.MEM_DEPTH];// local memory created in testbench
bit [ifp.ADDR_WIDTH-1:0]  addra;   
bit [ifp.STRB_WIDTH-1:0]   wena;
bit [ifp.DATA_WIDTH-1:0]  dina;  
bit [ifp.ADDR_WIDTH-1:0]  addrb;   
bit   renb;
bit [ifp.DATA_WIDTH-1:0]  doutb;
bit    dvalb;

initial repeat(REPETITONS ) begin // random number writing to memory while writing same in the local memory created
addra = $random ;
dina = $random;
#(CLK_PERIOD * 2);
ifp.wena = 1'b1;
ifp.addra = addra;
ifp.dina= dina;
mem_chk[addra] = dina;  // writing to local memory

end

initial repeat(REPETITONS ) begin  //reading random addresses from memory and comparing it with the data in local memory 
addrb = $random ;
ifp.renb = 1;
ifp.addrb = addrb;
@(posedge clk);
# (CLK_PERIOD * 2.5);
a1 :assert (mem_chk[addrb]===ifp.doutb ) $display("[PASS] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",addrb,mem_chk[addrb],ifp.doutb);  //assertion to check whether read data is correct
else $error("[FAIL] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",addrb,mem_chk[addrb],ifp.doutb);
   

end


endmodule
