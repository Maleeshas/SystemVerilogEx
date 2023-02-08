`timescale 1ns / 1ps

module fifo(clk,rst,ifp_ff);

input clk;
input rst;
fifo_if.slave ifp_ff;
sdpram_if ifp_ram();
simple_dual_port_ram ram(.clk(clk),.rst(rst),.ifp(ifp_ram));

logic [(ifp_ram.ADDR_WIDTH)-1:0] wrt_pt = 0 ; //write pointer
logic [(ifp_ram.ADDR_WIDTH)-1:0] rd_pt = 0;  //read pointer
logic [ifp_ram.ADDR_WIDTH:0] fifo_cnt = 0; //vary from 0-1024


always @(fifo_cnt) begin
    ifp_ff.empty = (fifo_cnt==0);
    ifp_ff.full = (fifo_cnt==1024);
    ifp_ff.almost_empty = (fifo_cnt==4);
    ifp_ff.almost_full = (fifo_cnt==1020);
end

always @(posedge clk)begin
    if ((!ifp_ff.full && ifp_ff.wen) && (ifp_ff.empty && ifp_ff.ren))begin
        fifo_cnt<=fifo_cnt;
    end
    else if (!ifp_ff.full && ifp_ff.wen)begin
        fifo_cnt<=fifo_cnt+1;
      
    end
    else if(!ifp_ff.empty && ifp_ff.ren)begin
        fifo_cnt<=fifo_cnt-1;
    end
    else fifo_cnt<=fifo_cnt;
    
    
end
   



always @(posedge clk)begin
    if (ifp_ff.ren && !ifp_ff.empty)begin
        ifp_ram.addrb <= rd_pt;
        ifp_ram.renb <= 1'b1;
        if (ifp_ram.dvalb)begin
            ifp_ff.rdata <= ifp_ram.doutb;  //need to add 2 clock cycle delay
        end
    end
    else ifp_ff.rdata <= ifp_ram.doutb;


end
     
always @(posedge clk)begin

    if (ifp_ff.wen && !ifp_ff.full)begin
        ifp_ram.addra <= wrt_pt;
        ifp_ram.dina <= ifp_ff.wdata;
        ifp_ram.wena <= 1'b1;

        end
    end

always @(posedge clk)begin
    if (!ifp_ff.full && ifp_ff.wen) wrt_pt <= wrt_pt+1;
    else wrt_pt <= wrt_pt;

    if (!ifp_ff.empty && ifp_ff.ren) rd_pt <= rd_pt+1;
    else rd_pt <= rd_pt;
end



endmodule
