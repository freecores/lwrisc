
`include "clairisc_def.h"

module ins2wb_addr(
        input [11:0] ins,
        output [4:0] wb_addr //wirte back addr
    );
    assign  wb_addr = ins[4:0];
endmodule

module mem_addr(
        input [1:0] bank,
        input [4:0]addr,
        output [6:0] file_addr
    );
    assign file_addr = {bank[1:0],addr[4:0]};
endmodule


module ins2bd(
        input [11:0] ins,
        output reg [7:0] bd
    );
    always @ (*)
    case (ins[8:6])
        0:bd=1<<0;
        1:bd=1<<1;
        2:bd=1<<2;
        3:bd=1<<3;
        4:bd=1<<4;
        5:bd=1<<5;
        6:bd=1<<6;
        7:bd=1<<7;
    endcase
endmodule

module alu_muxa(
        input ctl,
        output reg [7:0]alu_a,
        input [7:0]w,
        input [7:0]bd
    );
    always@(*)
        if (ctl==`MUXA_W)
            alu_a=w;
        else
            alu_a=bd;
endmodule

module alu_muxb(
        input ctl,
        output reg [7:0] alu_b,
        input [8:0] k,
        input [7:0] f
    );
    always@(*)
        if (ctl==`MUXB_EK)
            alu_b=k[7:0];
        else alu_b=f;
endmodule


module pc_gen(
        input [10:0]pc_i,
        output reg [10:0] pc_o,
        input [11:0] ins,
        input [8:0] ek,
        input [10:0] stack_pc,
        input [2:0]ctl,
        input brc,		  
		input rst,
        input [7:0]status
    );
    always @ (*)  
		if (rst)
			pc_o ='h1ff;		  //THE RST ENTRY 
			else
        if (brc)
        begin
            pc_o = pc_i+1;
        end
        else
        begin
            case(ctl)
              //  `PC_NOP :pc_o = pc_i+1;
            //    `PC_BRC :	  if(brc)pc_o = {status[7:6],ek[8:0]};	//jmp_addr means K
                `PC_GOTO,
                `PC_CALL: 	  pc_o = {status[7:6],ins[8:0]};
                `PC_RET:	  pc_o = stack_pc;
                default
                pc_o = pc_i+1;
            endcase
        end
endmodule


module bg(
        input z ,
        input [1:0]ctl,
        output reg branch);
    always @(*)
    case (ctl)
        `BG_ZERO :branch =  ~z;	    //if the ALU result is 0 then the next instrction will be discarded
        `BG_NZERO :branch = z;	 //if the ALU result is not zero ,then skip the next instruction
        default branch = 0;
    endcase
endmodule
