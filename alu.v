
`include "macro_defines.v"

module alu(output zero, reg [15:0] out, input [15:0] a, [15:0] b, [3:0] op);
	assign zero = (out == 16'b0) ? 1'b1 : 1'b0;
	
	wire [15:0] sum, b_sel;
	wire c_in;
	assign c_in = op[0];
	assign b_sel = b ^ {16{c_in}};
	cla_16 adder(.s(sum), .c_in, .a, .b(b_sel));
	
	wire [15:0] shifted;
	reg left;
	barrel_shift shifter(.out(shifted), .a, .b, .left);
	
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
