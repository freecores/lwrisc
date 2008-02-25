`define MUXA_W      0
`define MUXA_BD     1
`define MUXB_K      0
`define MUXB_F      1

`define BRC_NOP     0 								
`define BRC_ZERO    1
`define BRC_NZERO   2	

`define BG_ZERO  1
`define BG_NZERO 2
`define BG_IGN 0
`define BG_NOP 0	

`define PC_NOP      0  	
`define PC_BRC 	    1 
`define PC_GOTO	    2
`define PC_CALL	    3
`define PC_RET      4				

`define R1_LEN 		1
`define R2_LEN 		2
`define R3_LEN 		3 
`define R4_LEN 		4
`define R5_LEN 		5 
`define R8_LEN 		8
`define R12_LEN 	12

`define  ALU_ADD   1
`define  ALU_SUB   2
`define  ALU_AND   3
`define  ALU_OR    4
`define  ALU_XOR   5
`define  ALU_COM   6
`define  ALU_ROR   7
`define  ALU_ROL   8
`define  ALU_SWAP  9
`define  ALU_BSF   10
`define  ALU_BCF   11
`define  ALU_ZERO  12
`define  ALU_DEC   13
`define  ALU_INC   14
`define  ALU_PB    15
`define  ALU_PA    16
module ttoe(
        input [2:0] din,
        output reg [7:0] dout
    );

    always @ (*)
    case (din)
        0:dout=1<<0;
        1:dout=1<<1;
        2:dout=1<<2;
        3:dout=1<<3;
        4:dout=1<<4;
        5:dout=1<<5;
        6:dout=1<<6;
        7:dout=1<<7;
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
        if (ctl==`MUXB_K)
            alu_b=k[7:0];
        else alu_b=f;

endmodule		   


module w_reg(input [7:0]d,input clk,output reg [7:0] q,input w_wr_en)		 ;
always @(posedge clk)	if (w_wr_en) q<=d;
endmodule

module pc_gen(
	
	input [10:0]pc_i,
	output reg [10:0] pc_o,
	input [7:0] jmp_addr,
	input [10:0] stack_pc,
	input [4:0]ctl,
	input brc,
	input [7:0]status  
	
	);				 																 											   
	
	always @ (*)
		case(ctl)	
			`PC_NOP :pc_o = pc_i+1;
			`PC_BRC :	  if(brc)pc_o = {status[7:6],jmp_addr[7:0]};	//jmp_addr means K
			`PC_GOTO,
			`PC_CALL: 	  pc_o = {status[7:6],jmp_addr[7:0]};
			`PC_RET:	  pc_o = stack_pc;
			default	
					pc_o = pc_i+1;
			endcase 	
endmodule 			
 

module bg(
	input z ,
	input [1:0]ctl,
	output reg branch);
	always @(*)
		case (ctl)
			`BG_ZERO :branch =  z;
			`BG_NZERO :branch = ~z;
			default branch = 0;
		endcase
	endmodule 
	
`if 0
module decoder(
	input [11:0]inst,
	output reg [2:0]pc_ctl,
	output reg [1:0]stack_op,
	output reg alu_muxa,
	output reg alu_muxb,
	output reg [3:0]alu_op,
	output reg men_wr,
	output reg w_wr,
	output reg c_wr,
	output reg z_wr,
	output reg [1:0]bg_op	   
	);
	always @(inst) begin
	casex (inst) //synopsys parallel_case
		12'b0000_0000_0000:	//REPLACE ID = NOP 
		 
		12'b0000_001X_XXXX: //REPLACE ID = MOVWF
		 
		12'b0000_0100_0000: //REPLACE ID = CLRW
		 
		12'b0000_011X_XXXX: //REPLACE ID = CLRF
		 
		12'b0000_100X_XXXX: //REPLACE ID = SUBWF_W
		 
		12'b0000_101X_XXXX: //REPLACE ID = SUBWF_F
		 
		12'b0000_110X_XXXX: //REPLACE ID = DECF_W
		 
		12'b0000_111X_XXXX: //REPLACE ID = DECF_F
		 
		12'b0001_000X_XXXX: //REPLACE ID = IORWF _W
		 
		12'b0001_001X_XXXX: //REPLACE ID = IORWF_F
		 
		12'b0001_010X_XXXX: //REPLACE ID = ANDWF_W
		 
		12'b0001_011X_XXXX: //REPLACE ID = ANDWF_F
		 
		12'b0001_100X_XXXX: //REPLACE ID = XORWF_W
		 
		12'b0001_101X_XXXX: //REPLACE ID = XORWF_F
		 
		12'b0001_110X_XXXX: //REPLACE ID = ADDWF_W
		 
		12'b0001_111X_XXXX: //REPLACE ID = ADDWF_F
		 
		12'b0010_000X_XXXX: //REPLACE ID = MOVF_W
		 
		12'b0010_001X_XXXX: //REPLACE ID = MOVF_F
		 
		12'b0010_010X_XXXX: //REPLACE ID = COMF_W
		 
		12'b0010_011X_XXXX: //REPLACE ID = COMF_F
		 
		12'b0010_100X_XXXX: //REPLACE ID = INCF_W
		 
		12'b0010_101X_XXXX: //REPLACE ID = INCF_F
		  
		12'b0010_110X_XXXX: //REPLACE ID = DECFSZ_W
		 
		12'b0010_111X_XXXX: //REPLACE ID = DECFSZ_F
		 
		12'b0011_000X_XXXX: //REPLACE ID = RRF_W
		 
		12'b0011_001X_XXXX: //REPLACE ID = RRF_F
		 
		12'b0011_010X_XXXX: //REPLACE ID = RLF_W
		 
		12'b0011_011X_XXXX: //REPLACE ID = RLF_F
		  
		12'b0011_100X_XXXX: //REPLACE ID = SWAPF_W
		 
		12'b0011_101X_XXXX: //REPLACE ID = SWAPF_F
		 
		12'b0011_110X_XXXX: //REPLACE ID = INCFSZ_W
		 
		12'b0011_111X_XXXX: //REPLACE ID = INCFSZ_F
		                                                 
		12'b0100_XXXX_XXXX: //REPLACE ID = BCF
		 
		12'b0101_XXXX_XXXX: //REPLACE ID = BSF
		 
		12'b0110_XXXX_XXXX: //REPLACE ID = BTFSC
		 
		12'b0111_XXXX_XXXX: //REPLACE ID = BTFSS
		                            
		12'b0000_0000_0010: //REPLACE ID = OPTION
		 
		12'b0000_0000_0011: //REPLACE ID = SLEEP
		 
		12'b0000_0000_0100: //REPLACE ID = CLRWDT
		 
		12'b0000_0000_0101: //REPLACE ID = TRIS 5
		 
		12'b0000_0000_0110: //REPLACE ID = TRIS 6
		 
		12'b0000_0000_0111: //REPLACE ID = TRIS 7
		                                        
		12'b1000_XXXX_XXXX: //REPLACE ID = RETLW
		 
		12'b1001_XXXX_XXXX: //REPLACE ID = CALL
		 
		12'b101X_XXXX_XXXX: //REPLACE ID = GOTO
		 
		12'b1100_XXXX_XXXX: //REPLACE ID = MOVLW
		 
		12'b1101_XXXX_XXXX: //REPLACE ID = IORLW
		 
		12'b1110_XXXX_XXXX: //REPLACE ID = ANDLW
		 
		12'b1111_XXXX_XXXX: //REPLACE ID = XORLW			

		default:
			 
	endcase
	end
endmodule	
`endif

module r1_reg_clr_cls(input[`R1_LEN-1:0] r1_i,output reg[`R1_LEN-1:0] r1_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r1_o<=0;else if(cls)r1_o<=r1_o;else r1_o<=r1_i;endmodule
module r2_reg_clr_cls(input[`R2_LEN-1:0] r2_i,output reg[`R2_LEN-1:0] r2_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r2_o<=0;else if(cls)r2_o<=r2_o;else r2_o<=r2_i;endmodule
module r3_reg_clr_cls(input[`R3_LEN-1:0] r3_i,output reg[`R3_LEN-1:0] r3_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r3_o<=0;else if(cls)r3_o<=r3_o;else r3_o<=r3_i;endmodule
module r4_reg_clr_cls(input[`R4_LEN-1:0] r4_i,output reg[`R4_LEN-1:0] r4_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r4_o<=0;else if(cls)r4_o<=r4_o;else r4_o<=r4_i;endmodule
module r5_reg_clr_cls(input[`R5_LEN-1:0] r5_i,output reg[`R5_LEN-1:0] r5_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r5_o<=0;else if(cls)r5_o<=r5_o;else r5_o<=r5_i;endmodule
module r8_reg_clr_cls(input[`R8_LEN-1:0] r8_i,output reg[`R8_LEN-1:0] r8_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r8_o<=0;else if(cls)r8_o<=r8_o;else r8_o<=r8_i;endmodule
module r12_reg_clr_cls(input[`R12_LEN-1:0] r12_i,output reg[`R12_LEN-1:0] r12_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r12_o<=0;else if(cls)r12_o<=r12_o;else r12_o<=r12_i;endmodule 
	
`define PUSH 2'B01
`define POP  2'B10
`define NOP  2'B00

// A Basic Synchrounous FIFO (4 entries deep)
module sfifo4x11(clk, ctl,din, dout);
    input		clk;
    input		[1:0] ctl;
    input	[10:0]	din;
    output	[10:0]	dout;
    reg	[10:0]	stack1, stack2, stack3, stack4;
    assign dout = stack1;
    always @(posedge clk)
    begin
        case (ctl)
            `PUSH	:// PUSH stack
            begin
                stack4 <= stack3;
                stack3 <= stack2;
                stack2 <= stack1;
                stack1 <= din;
            end
            `POP	:// POP stack
            begin
                stack1 <= stack2;
                stack2 <= stack3;
                stack3 <= stack4;
            end
            //  default ://do nothing
        endcase
    end
endmodule



module alu(op,a,b,y,cin,cout,zout);
    input  [4:0]	op;	// ALU Operation
    input  [7:0]	a;	// 8-bit Input a
    input  [7:0]	b;	// 8-bit Input b
    output [7:0]	y;	// 8-bit Output
    input		cin;
    output		cout;
    output		zout;
    // Reg declarations for outputs
    reg [7:0]	y;
    // Internal declarations
    reg		addercout; // Carry out straight from the adder itself.
    always @(*) begin
        case (op) // synsys parallel_case
            `ALU_ADD:  {addercout,  y}  = a + b;
            `ALU_SUB:  {addercout,  y}  = b - a; // Carry out is really "borrow"
            `ALU_AND:  {addercout,  y}  = {1'b0, a & b};
            `ALU_ROR:  {addercout,  y}  = {b[0], cin, b[7:1]};
            `ALU_ROL:  {addercout,  y}  = {b[7], b[6:0], cin};
            `ALU_OR:   {addercout,  y}  = {1'b0, a | b};
            `ALU_XOR:  {addercout,  y}  = {1'b0, a ^ b};
            `ALU_COM:  {addercout,  y}  = {1'b0, ~b};
            `ALU_SWAP: {addercout,  y}  = {1'b0, b[3:0], b[7:4]};
            /*below added by liwei*/
            `ALU_BTFSC  {addercout,  y}  = {1'b0, a & b };
            `ALU_BTFSS  {addercout,  y}  = {1'b0, ~a | b };
            `ALU_DEC:                y   =  b - 1;
            `ALU_INC:                y   =  1 + b;
            `ALU_PA :   {addercout,  y}  = {1'b0, a};
            `ALU_PB :   {addercout,  y}  = {1'b0, b};
            `ALU_BSF :  {addercout,  y}  = {1b'0,a | b};
            `ALU_BCF :  {addercout,  y}  = {1'b0,~a & b};
            `ALU_ZERO:  {addercout,  y}  = {1'b0, 8'h00};
            default:     {addercout, y}  = {1'b0, 8'h00};
        endcase
    end

    assign  zout = (y == 8'h00);
    assign  cout =  (op == `ALUOP_SUB) ?  ~addercout : addercout;
    
endmodule

