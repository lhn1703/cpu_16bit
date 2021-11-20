
module add_1(output [15:0] out, input [15:0] in);
	wire [15:0] c_in;
	assign c_in[0] = 1'b1;
	assign c_in[15:1] = in[14:0] & c_in[14:0];
	assign out[15:0] = in[15:0] ^ c_in[15:0];
endmodule