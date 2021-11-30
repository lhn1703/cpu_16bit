module fpga_cpu_16bit (
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
    input KEY, clk //whenever KEY[0] is pushed, the cpu will reset
    );

    wire [15;0] result_reg;
    wire negative;
    wire [3:0] bcd_digit0, bcd_digit1, bcd_digit2, bcd_digit3, bcd_digit4;

    cpu_16bit u0000(result_reg, clk, KEY);
    bin16_to_bcd u0001(
        negative, 
        bcd_digit0, bcd_digit1, bcd_digit2, bcd_digit3, bcd_digit4, 
        result_reg
    );
    bcd_to_7seg u0002(
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
        negative,
        bcd_digit0, bcd_digit1, bcd_digit2, bcd_digit3, bcd_digit4
    );

endmodule
