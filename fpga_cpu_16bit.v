// DE2-115 Top Module
module fpga_cpu_16bit (
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX5, HEX4,
    output [15:0] LEDR,
    input [3:0] KEY, 
    input [15:0] SW,
    input clk //whenever KEY[0] is pushed, the cpu will reset
    );
    wire [15:0] result_reg;//, debug;
	wire [23:0] debug;
    wire [15:0] initial_input;
    assign LEDR = SW;
    assign initial_input = SW; //9 bit 2s complement sign extended value

    //cpu_16bit u0000(result_reg, initial_input, clk, ~KEY[0]); // Button is logic LOW when pressed
	cpu_16bit u0000(debug, result_reg, initial_input, ~KEY[3], ~KEY[0]);
    hex_decoder u0 (HEX4, debug[3:0]);
    hex_decoder u1 (HEX5, debug[7:4]);
	hex_display u0002(
        HEX0, HEX1, HEX2, HEX3,
        debug[23:8]
    );
    /*hex_display u0002(
        HEX0, HEX1, HEX2, HEX3,
        result_reg
    );*/

endmodule
