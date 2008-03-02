`include "clairisc_def.h"

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
            `ALU_BTFSC,//:  {addercout,  y}  = {1'b0, a & b };
            `ALU_BTFSS:  {addercout,  y}  = {1'b0, a & b };			  //if the 'b' bit is 1 ,skip nxt instruction
            `ALU_DEC:                y   =  b - 1;
            `ALU_INC:                y   =  1 + b;
            `ALU_PA :   {addercout,  y}  = {1'b0, a};
            `ALU_PB :   {addercout,  y}  = {1'b0, b};
            `ALU_BSF :  {addercout,  y}  = {1'B0,a | b};
            `ALU_BCF :  {addercout,  y}  = {1'b0,~a & b};
            `ALU_ZERO:  {addercout,  y}  = {1'b0, 8'h00};
            default:     {addercout, y}  = {1'b0, 8'h00};
        endcase
    end
    assign  zout = (y == 8'h00);
    assign  cout =  (op == `ALU_SUB) ?  ~addercout : addercout;
endmodule
