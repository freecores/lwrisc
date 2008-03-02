`include "clairisc_def.h"	  
	
module pram (
        clk,
        rd_addr,
        wr_addr,
        we,
        din,
        dout
    );
    input		clk;
    input [10:0]	rd_addr;
    input [10:0]	wr_addr;
    input		we;
    input [11:0]	din;
    output [11:0]	dout;
	
	/*
`ifndef SIM
            alt_ram i_alt_ram (
                .data(din),
                .wren(we),
                .wraddress(wr_addr),
                .rdaddress(rd_addr),
                .clock(clk),
                .q(dout)
            );
`else 
	*/
    sim_rom i_sim_ram(
                .address(rd_addr),
                .clock(clk),
                .q(dout)
            );
			
//`endif 				   

endmodule

module sim_reg_file (
        data,
        wren,
        wraddress,
        rdaddress,
        clock,
        q);

    input	[7:0]  data;
    input	  wren;
    input	[6:0]  wraddress;
    input	[6:0]  rdaddress;
    input	  clock;
    output	[7:0]  q;

    reg [7:0] membank[0:127];

    reg r_we;
    reg [6:0] r_rd_addr;
    reg [6:0] r_wr_addr;
    reg [6:0] r_data;

    always @ (posedge clock)
    begin

        r_rd_addr<=rdaddress;
        r_wr_addr<=wraddress;
        r_data<=data;
        r_we<=wren;
    end

    always  @(posedge clock)
        if (r_we)
            membank[r_wr_addr]<=r_data;

    assign q=((r_rd_addr==r_wr_addr)&&(r_we))?r_data:membank[r_rd_addr] ;

endmodule

