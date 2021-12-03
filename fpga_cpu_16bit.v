module fpga_cpu_16bit (
    output [6:0] HEX0, HEX1, HEX2, HEX3, LEDR,
    input [3:0] KEY, 
    input clk //whenever KEY[0] is pushed, the cpu will reset
    );
    wire [15:0] result_reg;
    wire [3:0] digit0, digit1, digit2, digit3;
    assign LEDR[0] = ~KEY[0];

    cpu_16bit u0000(result_reg, clk, KEY[0]);
    hex_display u0002(
        HEX0, HEX1, HEX2, HEX3,
        result_reg
    );

endmodule
