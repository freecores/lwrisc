`include "clairisc_def.h"

module w_reg(input [7:0]d,input clk,output reg [7:0] q,input w_wr_en);always @(posedge clk)if (w_wr_en) q<=d;endmodule
module r1_reg_clr_cls(input[`R1_LEN-1:0] r1_i,output reg[`R1_LEN-1:0] r1_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r1_o<=0;else if(cls)r1_o<=r1_o;else r1_o<=r1_i;endmodule
module r2_reg_clr_cls(input[`R2_LEN-1:0] r2_i,output reg[`R2_LEN-1:0] r2_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r2_o<=0;else if(cls)r2_o<=r2_o;else r2_o<=r2_i;endmodule
module r3_reg_clr_cls(input[`R3_LEN-1:0] r3_i,output reg[`R3_LEN-1:0] r3_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r3_o<=0;else if(cls)r3_o<=r3_o;else r3_o<=r3_i;endmodule
module r4_reg_clr_cls(input[`R4_LEN-1:0] r4_i,output reg[`R4_LEN-1:0] r4_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r4_o<=0;else if(cls)r4_o<=r4_o;else r4_o<=r4_i;endmodule
module r5_reg_clr_cls(input[`R5_LEN-1:0] r5_i,output reg[`R5_LEN-1:0] r5_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r5_o<=0;else if(cls)r5_o<=r5_o;else r5_o<=r5_i;endmodule
module r8_reg_clr_cls(input[`R8_LEN-1:0] r8_i,output reg[`R8_LEN-1:0] r8_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r8_o<=0;else if(cls)r8_o<=r8_o;else r8_o<=r8_i;endmodule
module r12_reg_clr_cls(input[`R12_LEN-1:0] r12_i,output reg[`R12_LEN-1:0] r12_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r12_o<=0;else if(cls)r12_o<=r12_o;else r12_o<=r12_i;endmodule
module r11_reg_clr_cls(input[`R11_LEN-1:0] r11_i,output reg[`R11_LEN-1:0] r11_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r11_o<=0;else if(cls)r11_o<=r11_o;else r11_o<=r11_i;endmodule
module ek_reg_clr_cls(input[11:0] ins,output reg[`R9_LEN-1:0] r9_o,input clk,input clr,input cls); wire [8:0] r9_i =ins[8:0];always@(posedge clk)if(clr) r9_o<=0;else if(cls)r9_o<=r9_o;else r9_o<=r9_i;endmodule
