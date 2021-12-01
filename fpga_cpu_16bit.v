module fpga_cpu_16bit (
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
    input KEY, clk //whenever KEY[0] is pushed, the cpu will reset
    );

    wire [15:0] result_reg;
    wire negative;
    wire [3:0] digit0, digit1, digit2, digit3, digit4;

    cpu_16bit u0000(result_reg, clk, KEY);
    bin16_to_hex u0001(
        negative, 
        digit0, digit1, digit2, digit3, digit4, 
        result_reg
    );
    hex_display u0002(
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
        negative,
        digit0, digit1, digit2, digit3, digit4
    );

endmodule
