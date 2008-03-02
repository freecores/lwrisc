		  

`timescale 10ns / 10ns
		

module test;
	
	reg clk;
	reg  rst;
	
	initial	begin 
	#10 clk = 0;   
	#10 rst = 0;
	#10 rst = 1; 
	#10 rst = 0;
	end
	
	always #5 clk=~clk ; 
		
ClaiRISC_core I_ClaiRISC_core
(
.clk(clk),
.pdata_we(0),
.rst(rst)

/*
.exp_din,
.pdata_in,
.pdata_wraddr,
.exp_wren,
.exp_dout,
.exp_rd_addr,
.exp_wr_addr	
*/

) ;

endmodule