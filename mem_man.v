`include "clairisc_def.h"

module mem_man(
        input wr_en,
        input clk,
        input rst,
        output reg [7:0] dout,
        output co,
        output [1:0] bank,
        input  [6:0] rd_addr,
        input  [6:0] wr_addr,
        output [6:0] exp_wr_addr,
        output [6:0] exp_rd_addr,
        output [7:0] exp_dout,
        input ci,
        input zi,
        input z_wr,
        input c_wr,
        input [7:0] exp_din	 ,
        input [7:0] din	   ,
        output reg [7:0]status
    );

    reg wr_en_r;
    reg [6:0] din_r, wr_addr_r;
    reg [6:0] rd_addr_r;

    always @(posedge clk)
    begin
        wr_addr_r<=wr_addr;
        rd_addr_r<=rd_addr;
        wr_en_r<=wr_en;
        din_r<=din;
    end

    wire [7:0] ram_q ; 
	wire [7:0] alt_ram_q;
	
/*`ifdef SIM		  
    reg_file i_reg_file(
                     .data(din),
                     .wren(wr_en),
                     .wraddress(wr_addr),
                     .rdaddress(rd_addr),
                     .clock(clk),
                     .q(alt_ram_q)
					 );
`else
	*/
    sim_reg_file i_reg_file(
                 .data(din),
                 .wren(wr_en),
                 .wraddress(wr_addr),
                 .rdaddress(rd_addr),
                 .clock(clk),
                 .q(alt_ram_q));
//`endif

    assign ram_q = ((wr_addr_r==rd_addr_r)&&(wr_en_r))?din_r:alt_ram_q;

    /*status register*/
    wire write_status = wr_addr == `ADDR_STATUS && wr_en ;
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
    assign zo = status[2];

    /*fsr register*/
    reg [6:0] fsr;
    wire write_fsr = wr_addr == `ADDR_FSR &&wr_en ;
    always@(posedge clk)
    begin
        if (rst)fsr<=0;
        else  if(write_fsr) fsr<=din[6:0];
    end						
	
    //reg [7:0] status;
    assign bank = fsr[6:5];

    /*data bus output logic*/
    always@(*)//select status,fsr,ram,exp_din
    casex(rd_addr_r)
        `ADDR_FSR:dout = fsr;
        `ADDR_STATUS:dout = status;
        7'b00_01XXX,7'b01_01XXX,7'b10_01XXX,7'b11_01XXX,7'b00_10XXX,7'b00_11XXX,
        7'b01_10XXX,7'b01_11XXX,7'b10_10XXX,7'b10_11XXX,7'b11_10XXX,7'b11_11XXX:
            dout = ram_q ;
        default dout = exp_din;
    endcase

    /*exp device bus logic*/
    assign exp_rd_addr = rd_addr;
    assign exp_wr_addr = wr_addr;
    assign exp_dout =din;

endmodule
