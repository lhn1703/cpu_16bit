
`include "macro_defines.v"

module alu(output reg [15:0] out, input [15:0] a, b, input [3:0] op);
	wire [15:0] sum, b_sel;
	//wire [15:0] sum;
	wire c_in;
	assign c_in = op[0];
	//cla_16 adder(sum, c_in, a, b);
	
	assign b_sel = b ^ {16{c_in}};
	cla_16 adder(sum, c_in, a, b_sel);
	
	
	wire [15:0] shifted;
	wire left;
	assign left = (op == 4'd12);
	barrel_shift shifter(shifted, left, a, b);
	
	always @(*) begin
		case(op)
			4'd0: out = sum;
			4'd1: out = sum;
			4'd2: out = a & b;
			4'd4: out = a | b;
			4'd6: out = a ^ b;
			4'd7: out = (sum[15]) ? 16'b1 : 16'b0;
			4'd8: out = shifted;
			4'd12: out = shifted;
			4'd14: out = ~a;
			default: out = sum;
		endcase
	end
endmodule
