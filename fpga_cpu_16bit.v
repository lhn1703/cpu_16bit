// DE2-115 Top Module
module hex_debugger(
        output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
        input [127:0] debug,
        input [1:0] KEY
    );

    reg [31:0] state_value;
    always @ (*) begin
        case(KEY)
            2'b00: state_value = debug[31:0];
            2'b01: state_value = debug[63:32];
            2'b10: state_value = debug[95:64];
            2'b11: state_value = debug[127:96];
            default: state_value = 32'hFFFFFFFF;
        endcase
    end

    hex_decoder u0 (HEX0, state_value[3:0]);
    hex_decoder u1 (HEX1, state_value[7:4]);
    hex_decoder u2 (HEX2, state_value[11:8]);
    hex_decoder u3 (HEX3, state_value[15:12]);
    hex_decoder u4 (HEX4, state_value[19:16]);
    hex_decoder u5 (HEX5, state_value[23:20]);

endmodule

module fpga_cpu_16bit (
		output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
		output [9:0] LEDR,
		input [3:0] KEY, //whenever KEY[0] is pushed, the cpu will reset
		input [9:0] SW,
		input clk,
		inout [35:0] GPIO_1
    );
	wire [127:0] debug;
    wire [15:0] initial_input;
	reg [15:0] bluetooth_addr;
	wire [15:0] bluetooth_data;
	wire byte_cnt;
	wire prog_ld;
	
    assign LEDR = bluetooth_data[9:0];
    assign initial_input = {6'b0, SW}; //9 bit 2s complement sign extended value

    cpu_16bit u0000(debug, initial_input, bluetooth_addr, bluetooth_data, prog_ld, clk, ~KEY[2]);
    hex_debugger(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, debug, ~(KEY[1:0]));
	rfs rfs0(bluetooth_data, byte_cnt, prog_ld, clk, ~KEY[2], GPIO_1);
	
	always @(posedge prog_ld or negedge KEY[2]) begin
		if (~KEY[2])
			bluetooth_addr = -1;
		else if (byte_cnt & prog_ld)
			bluetooth_addr = bluetooth_addr + 1;
	end

endmodule
