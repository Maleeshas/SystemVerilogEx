
module sdpr_tb;

logic clk_tb;
logic clk_tb2;
bit rst_tb;
localparam REPETITONS = 10000; // no of repitions to test

localparam CLK_PERIOD = 10;
initial begin
clk_tb= 0;
forever #(CLK_PERIOD/2) clk_tb <= ~clk_tb;
end

initial begin
clk_tb2= 0;
forever #(CLK_PERIOD) clk_tb2 <= ~clk_tb2;
end


sdpram_if ifp();

simple_dual_port_ram DUT(

        .clk(clk_tb),

        .rst(rst_tb),       

        .ifp(ifp)

    );
    
 // defined to imitate memory behavior   
logic [ifp.DATA_WIDTH-1:0] mem_chk [ifp.MEM_DEPTH];// local memory created in testbench
logic [ifp.ADDR_WIDTH-1:0]  addra;   
logic  wena;
logic [ifp.DATA_WIDTH-1:0]  dina;  
logic [ifp.ADDR_WIDTH-1:0]  addrb;   
logic   renb;

initial repeat(REPETITONS ) begin // random number writing to memory while writing same in the local memory created
addra = $random ;
dina = $random;
wena = $random;


ifp.wena <= wena;
ifp.addra <= addra;
ifp.dina <= dina;
@(posedge clk_tb);
if (wena)
mem_chk[addra] <= dina;  // writing to local memory

end

initial repeat(REPETITONS ) begin  //reading random addresses from memory and comparing it with the data in local memory 
addrb = $random ;
renb = $random ;
@(posedge  (clk_tb2));
ifp.renb <= renb;
ifp.addrb <= addrb;

if (renb)begin
@(posedge  (clk_tb2));
a1 :assert (mem_chk[addrb]===ifp.doutb ) $display("[PASS] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",addrb,mem_chk[addrb],ifp.doutb);  //assertion to check whether read data is correct
else $error("[FAIL] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",addrb,mem_chk[addrb],ifp.doutb);
   
end
end

  initial begin
    	#60000
     	$finish; 
   end


endmodule
