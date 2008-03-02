`include "clairisc_def.h"

module decoder(
        input [11:0]inst,
        output reg [2:0]pc_ctl,
        output reg [1:0]stack_op,
        output reg alu_muxa,
        output reg alu_muxb,
        output reg [4:0]alu_op,
        output reg men_wr,
        output reg w_wr,
        output reg c_wr,
        output reg z_wr,
        output reg [1:0]bg_op
    );
    always @(inst) begin
        casex (inst) //synopsys parallel_case
            12'b0000_0000_0000:
                //REPLACE ID = NOP
                //REPLACE ID = NOP
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_IGN;
                alu_op = `ALU_NOP;
                men_wr = `DIS;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of NOP ;
            /**/

            12'b0000_001X_XXXX:
                //REPLACE ID = MOVWF
                //REPLACE ID = MOVWF
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_IGN;
                alu_op = `ALU_PA;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of MOVWF ;

            12'b0000_0100_0000:
                //REPLACE ID = CLRW
                //REPLACE ID = CLRW
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_IGN;
                alu_op = `ALU_ZERO;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of CLRW ;

            12'b0000_011X_XXXX:
                //REPLACE ID = CLRF
                //REPLACE ID = CLRF
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_IGN;
                alu_op = `ALU_ZERO;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of CLRF ;

            12'b0000_100X_XXXX:
                //REPLACE ID = SUBWF_W
                //REPLACE ID = SUBWF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_SUB;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `EN;
                bg_op = `BG_NOP;
            end //end of SUBWF_W ;

            12'b0000_101X_XXXX:
                //REPLACE ID = SUBWF_F
                //REPLACE ID = SUBWF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_SUB;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `EN;
                c_wr = `EN;
                bg_op = `BG_NOP;
            end //end of SUBWF_F ;

            12'b0000_110X_XXXX:
                //REPLACE ID = DECF_W
                //REPLACE ID = DECF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_DEC;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of DECF_W ;


            12'b0000_111X_XXXX:
                //REPLACE ID = DECF_F
                //REPLACE ID = DECF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_DEC;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of DECF_F ;

            12'b0001_000X_XXXX:
                //REPLACE ID = IORWF_W
                //REPLACE ID = IORWF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_EK;
                alu_op = `ALU_OR;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of IORWF_W ;



            12'b0001_001X_XXXX:
                //REPLACE ID = IORWF_F
                //REPLACE ID = IORWF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_EK;
                alu_op = `ALU_OR;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of IORWF_F ;

            12'b0001_010X_XXXX:
                //REPLACE ID = ANDWF_W
                //REPLACE ID = ANDWF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_EK;
                alu_op = `ALU_AND;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of ANDWF_W ;

            12'b0001_011X_XXXX:
                //REPLACE ID = ANDWF_F
                //REPLACE ID = ANDWF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_EK;
                alu_op = `ALU_AND;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of ANDWF_F ;

            12'b0001_100X_XXXX:
                //REPLACE ID = XORWF_W
                //REPLACE ID = XORWF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_XOR;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of XORWF_W ;

            12'b0001_101X_XXXX:
                //REPLACE ID = XORWF_F
                //REPLACE ID = XORWF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_XOR;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of XORWF_F ;

            12'b0001_110X_XXXX:
                //REPLACE ID = ADDWF_W
                //REPLACE ID = ADDWF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_ADD;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `EN;
                bg_op = `BG_NOP;
            end //end of ADDWF_W ;

            12'b0001_111X_XXXX:
                //REPLACE ID = ADDWF_F
                //REPLACE ID = ADDWF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_ADD;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `EN;
                c_wr = `EN;
                bg_op = `BG_NOP;
            end //end of ADDWF_F ;

            12'b0010_000X_XXXX:
                //REPLACE ID = MOVF_W
                //REPLACE ID = MOVF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_PB;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of MOVF_W ;


            12'b0010_001X_XXXX:
                //REPLACE ID = MOVF_F
                //REPLACE ID = MOVF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_PB;
                men_wr = `DIS;//Also can be set as EN
                w_wr = `DIS;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of MOVF_F ;

            12'b0010_010X_XXXX:
                //REPLACE ID = COMF_W
                //REPLACE ID = COMF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_COM;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of COMF_W ;

            12'b0010_011X_XXXX:
                //REPLACE ID = COMF_F
                //REPLACE ID = COMF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_COM;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of COMF_F ;

            12'b0010_100X_XXXX:
                //REPLACE ID = INCF_W
                //REPLACE ID = INCF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_INC;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of INCF_W ;

            12'b0010_101X_XXXX:
                //REPLACE ID = INCF_F
                //REPLACE ID = INCF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_INC;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of INCF_F ;

            12'b0010_110X_XXXX:
                //REPLACE ID = DECFSZ_W
                //REPLACE ID = DECFSZ_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_DEC;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_ZERO;		 //if the result is 0 then the next instrction will be discarded
            end //end of DECFSZ_W ;

            12'b0010_111X_XXXX:
                //REPLACE ID = DECFSZ_F
                //REPLACE ID = DECFSZ_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_DEC;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_ZERO;		  //if the result is 0 then the next instrction will be discarded
            end //end of DECFSZ_F ;
            //checked

            12'b0011_000X_XXXX:
                //REPLACE ID = RRF_W
                //REPLACE ID = RRF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_ROR;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `DIS;
                c_wr = `EN;
                bg_op = `BG_NOP;
            end //end of RRF_W ;
            //checked

            12'b0011_001X_XXXX:
                //REPLACE ID = RRF_F
                //REPLACE ID = RRF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_ROR;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `EN;
                bg_op = `BG_NOP;
            end //end of RRF_F ;

            //
            12'b0011_010X_XXXX:
                //REPLACE ID = RLF_W
                //REPLACE ID = RLF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_ROL;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `DIS;
                c_wr = `EN;
                bg_op = `BG_NOP;
            end //end of RLF_W ;

            12'b0011_011X_XXXX:
                //REPLACE ID = RLF_F
                //REPLACE ID = RLF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_ROL;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `EN;
                bg_op = `BG_NOP;
            end //end of RLF_F ;

            12'b0011_100X_XXXX:
                //REPLACE ID = SWAPF_W
                //REPLACE ID = SWAPF_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_SWAP;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of SWAPF_F ;

            12'b0011_101X_XXXX:
                //REPLACE ID = SWAPF_F
                //REPLACE ID = SWAPF_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_SWAP;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of SWAPF_F ;

            12'b0011_110X_XXXX:
                //REPLACE ID = INCFSZ_W
                //REPLACE ID = INCFSZ_W
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_INC;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of INCFSZ_W ;

            12'b0011_111X_XXXX:
                //REPLACE ID = INCFSZ_F
                //REPLACE ID = INCFSZ_F
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_INC;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of INCFSZ_F ;

            12'b0100_XXXX_XXXX:
                //REPLACE ID = BCF
                //REPLACE ID = BCF
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_NOP;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of BCF ;

            12'b0101_XXXX_XXXX:
                //REPLACE ID = BSF
                //REPLACE ID = BSF
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_NOP;
                men_wr = `EN;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of BSF ;
            /**/

            12'b0110_XXXX_XXXX:
                //REPLACE ID = BTFSC
                //REPLACE ID = BTFSC
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_NOP;
                men_wr = `DIS;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_ZERO;
            end //end of BTFSC ;

            12'b0111_XXXX_XXXX:
                //REPLACE ID = BTFSS
                //REPLACE ID = BTFSS
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_NOP;
                men_wr = `DIS;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NZERO;
            end //end of BTFSS ;

            12'b1000_XXXX_XXXX:
                //REPLACE ID = RETLW
                //REPLACE ID = RETLW
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_POP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_REG;
                alu_op = `ALU_NOP;
                men_wr = `DIS;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of RETLW ;

            12'b1001_XXXX_XXXX:
                //REPLACE ID = CALL
                //REPLACE ID = CALL
            begin
                pc_ctl = `PC_GOTO;
                stack_op = `STK_PSH;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_IGN;
                alu_op = `ALU_NOP;
                men_wr = `DIS;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of CALL ;

            12'b101X_XXXX_XXXX:
                //REPLACE ID = GOTO
                //REPLACE ID = GOTO
            begin
                pc_ctl = `PC_GOTO;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_IGN;
                alu_op = `ALU_NOP;
                men_wr = `DIS;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of GOTO ;

            12'b1100_XXXX_XXXX:
                //REPLACE ID = MOVLW
                //REPLACE ID = MOVLW
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_EK;
                alu_op = `ALU_PB;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of MOVLW ;

            12'b1101_XXXX_XXXX:
                //REPLACE ID = IORLW
                //REPLACE ID = IORLW
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_EK;
                alu_op = `ALU_OR;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of IORLW ;

            12'b1110_XXXX_XXXX:
                //REPLACE ID = ANDLW
                //REPLACE ID = ANDLW
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_EK;
                alu_op = `ALU_AND;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of ANDLW ;

            12'b1111_XXXX_XXXX:
                //REPLACE ID = XORLW
                //REPLACE ID = XORLW
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_W;
                alu_muxb = `MUXB_EK;
                alu_op = `ALU_XOR;
                men_wr = `DIS;
                w_wr = `EN;
                z_wr = `EN;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of XORLW ;


            default:
                //REPLACE ID = NOP
            begin
                pc_ctl = `PC_NEXT;
                stack_op = `STK_NOP;
                alu_muxa = `MUXA_IGN;
                alu_muxb = `MUXB_IGN;
                alu_op = `ALU_NOP;
                men_wr = `DIS;
                w_wr = `DIS;
                z_wr = `DIS;
                c_wr = `DIS;
                bg_op = `BG_NOP;
            end //end of NOP ;
        endcase
    end
endmodule
