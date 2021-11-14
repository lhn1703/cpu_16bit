
module add_2(output [15:0] out, input [15:0] in);
	wire [15:1] c_in;
	assign c_in[1] = 1'b1;
	assign c_in[15:2] = in[14:1] & c_in[14:1];
	assign out[0] = in[0];
	assign out[15:1] = in[15:1] ^ c_in[15:1];
endmodule