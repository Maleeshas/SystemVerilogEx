`include "fifo_ifp.sv";
`include "ram_ifp.sv";

module fifo_tb;

logic clk_tb;
logic clk_tb2;
bit rst_tb;
localparam REPETITONS = 10000; // no of repitions to test

localparam CLK_PERIOD = 10;  //normal clock
initial begin
clk_tb= 0;
forever #(CLK_PERIOD/2) clk_tb <= ~clk_tb;
end

initial begin  //clock to delay 2 cycles to check memory read operation
clk_tb2= 0;
forever #(2*CLK_PERIOD) clk_tb2 <= ~clk_tb2;
end


sdpram_if ifp();
fifo_if ifp_ff_tb();

fifo dutfifo(.clk(clk_tb),
                .rst(rst_tb),
                .ifp_ff(ifp_ff_tb));

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



initial begin
@(posedge (clk_tb));
ifp_ff_tb.empty <= 1'b1 ;
ifp_ff_tb.full <= 1'b0 ;
ifp_ff_tb.wdata <= 32'd39;
ifp_ff_tb.wen <= 1'b1;
//$display("full%brmpty%b",ifp_ff_tb.full,ifp_ff_tb.empty);


@(posedge clk_tb);
ifp_ff_tb.wdata <= 32'd55;
ifp_ff_tb.wen<=1'b1;
//$display("full%brmpty%b",ifp_ff_tb.full,ifp_ff_tb.empty);



@(posedge clk_tb);
ifp_ff_tb.wdata <= 32'd12;
ifp_ff_tb.wen<=1'b1;
//$display("full%brmpty%b",ifp_ff_tb.full,ifp_ff_tb.empty);
end



endmodule
