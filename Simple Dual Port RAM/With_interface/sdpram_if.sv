`timescale 1ns / 1ps



interface sdpram_if#(

        parameter DATA_WIDTH = 32,

        parameter MEM_DEPTH  = 1024,      

        parameter BYTE_WRITE = 0

);

    localparam ADDR_WIDTH = $clog2(MEM_DEPTH);

    localparam STRB_WIDTH = BYTE_WRITE ? (DATA_WIDTH/8) : 1;

              

                          

    logic [ADDR_WIDTH-1:0]  addra;   

    logic [STRB_WIDTH-1:0]   wena;

    logic [DATA_WIDTH-1:0]  dina;  

 

    logic [ADDR_WIDTH-1:0]  addrb;   

    logic                                      renb;

    logic [DATA_WIDTH-1:0]  doutb;

    logic                                     dvalb;

    

    modport sdp_m(      /*Simple dual port master */

        output addra,

        output wena,

        output dina,

 

        output addrb,

        output renb,

        input  doutb,

        input  dvalb

    );

 

    modport sdp_s(      /*Simple dual port salve */
      input addra,

        input wena,

        input dina,

 

        input addrb,

        input renb,

        output  doutb,

        output  dvalb

        //fill this

    );

   

    

endinterface
