`timescale 1ns / 1ps


interface fifo_if#(
        parameter DATA_WIDTH = 32
  
    );
    
    logic [DATA_WIDTH-1:0]  wdata;
    logic                   wen;
    logic                   full;
    logic                   almost_full;
        
    logic [DATA_WIDTH-1:0]  rdata;
    logic                   rvalid;
    logic                   ren;
    logic                   empty;
    logic                   almost_empty;

    
    modport master(     
        output wdata,
        output wen,
        input  full,
        input  almost_full,

        input  rdata,
        input  rvalid,
        output ren,
        input  empty,
        input  almost_empty
    );         

    modport slave(      /* salve (for fifo)*/
        input  wdata,
        input  wen,
        output full,
        output almost_full,

        output rdata,
        output rvalid,
        input  ren,
        output empty,
        output almost_empty
    );
        
endinterface 
