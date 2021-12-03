module fpga_cpu_16bit (
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX5,
    output [9:0] LEDR,
    input [3:0] KEY, 
    input [9:0] SW,
    input clk //whenever KEY[0] is pushed, the cpu will reset
    );
    wire [15:0] result_reg;
    wire [3:0] digit0, digit1, digit2, digit3;
    wire [15:0] initial_input;
    assign LEDR = SW;
    assign HEX5 = KEY;
    assign initial_input = {{6{SW[9]}}, SW}; //9 bit 2s complement sign extended value

    cpu_16bit u0000(result_reg, initial_input, clk, KEY[0]);
    hex_display u0002(
        HEX0, HEX1, HEX2, HEX3,
        result_reg
    );

endmodule
