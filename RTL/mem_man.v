`include "clairisc_def.h"
			  
`define ADDR_FSR                   4
`define ADDR_STATUS                3	   
`define ADDR_IN0               5	 
`define ADDR_IN1               1
`define ADDR_OUT0                6	 	
`define ADDR_OUT1                7				  

module wb_mem_man(
        input wr_en,
        input clk,
        input rst,
        input ci,
        input zi,
        input z_wr,
        input c_wr,
        output reg [7:0] dout,
        output co,
        output [1:0] bank,
        input [7:0] din	   ,
        output reg [7:0]status     ,

        input  [6:0] rd_addr,
        input  [6:0] wr_addr ,

        input  [7:0] in0,
        input  [7:0] in1,
        output reg [7:0] out0,
        output reg [7:0] out1
    );
    reg wr_en_r;
    reg [6:0] din_r, wr_addr_r;
    reg [6:0] rd_addr_r;

    always @(posedge clk)
    begin  //used to bypass the data
        //which wrote anf then be read in the followwing period
        wr_addr_r<=wr_addr;
        rd_addr_r<=rd_addr;
        wr_en_r<=wr_en;
        din_r<=din;
    end

    wire [7:0] ram_q ;
    wire [7:0] alt_ram_q;

    `ifdef SIM

    sim_reg_file i_reg_file(
                     .data(din),
                     .wren(wr_en),
                     .wraddress(wr_addr),
                     .rdaddress(rd_addr),
                     .clock(clk),
                     .q(alt_ram_q));
    `else
    ram128x8 i_reg_file(
                 .data(din),
                 .wren(wr_en),
                 .wraddress(wr_addr),
                 .rdaddress(rd_addr),
                 .clock(clk),
                 .q(alt_ram_q)
             );
    `endif

    assign ram_q = ((wr_addr_r==rd_addr_r)&&(wr_en_r))?din_r:alt_ram_q;

    /*status register*/
    wire write_status = wr_addr[4:0] ==`ADDR_STATUS && wr_en;
    always@(posedge clk)
    begin
        if (rst)status<=8'h3f;//default value
        else
            if (write_status)status<=din;
            else
            begin
                if (c_wr)status[0]<=ci;
                if (z_wr)status[2]<=zi;
            end
    end

    assign co = status[0];

    `ifdef SIM 	   
    
    wire write_disp = wr_addr == 'h1f && wr_en;
    always@(posedge clk)
    begin
        if (write_disp)
            $display("hex=>%x< char=>%c<",din,din);
    end
    `endif 	

    /*fsr register*/
    reg [7:0] fsr;
    assign bank = fsr[6:5];
    wire write_fsr = wr_addr[4:0] == `ADDR_FSR &&wr_en ;
    always@(posedge clk)
    begin
        if (rst)fsr<=0;
        else  if(write_fsr) fsr<=din[7:0];
    end

    /*latch the input data*/
    reg [7:0]	 reg_in1,reg_in0;
    always@(posedge clk) reg_in0<=in0;
    always@(posedge clk) reg_in1<=in1;

    /*data output latch */
    wire write_out0 = wr_addr[4:0] == `ADDR_OUT0 &&wr_en ;
    always@(posedge clk)
    begin
        if (rst)out0<=0;
        else  if(write_out0)out0<=din[7:0];
    end

    /*data output latch */
    wire write_out1 = wr_addr[4:0] == `ADDR_OUT1 &&wr_en ;
    always@(posedge clk)
    begin
        if (rst)out1<=0;
        else  if(write_out1)out1<=din[7:0];
    end

    /*data bus output select logic*/
    always@(*)//select status,fsr,wb_data,ram,wb_din
    case(rd_addr_r[4:0])
        `ADDR_FSR:dout    = fsr;
        `ADDR_STATUS:dout = status;
        `ADDR_IN0:dout    = reg_in0;
        `ADDR_IN1:dout    = reg_in1;
        default dout = ram_q ;
    endcase
endmodule



