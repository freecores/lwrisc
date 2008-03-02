`include "clairisc_def.h"

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
            `STK_PSH	:// PUSH stack
            begin
                stack4 <= stack3;
                stack3 <= stack2;
                stack2 <= stack1;
                stack1 <= din;
            end
            `STK_POP	:// POP stack
            begin
                stack1 <= stack2;
                stack2 <= stack3;
                stack3 <= stack4;
            end
            //  default ://do nothing
        endcase
    end
endmodule
