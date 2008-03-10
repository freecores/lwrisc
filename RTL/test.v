`timescale 10ns / 10ns

module test;

    reg clk;
    reg  rst;

    initial	begin
        #1 clk = 0;
        #10 rst = 0;
        #10 rst = 1;
        #10 rst = 0;
    end

    always #1 clk=~clk ;

    ClaiRISC_core I_ClaiRISC_core
                    (
                        .clk(clk),
                        .rst(rst)
                    ) ;

endmodule
