
`include "macro_defines.v"

module alu(output reg [15:0] out, output zero, input [15:0] a, b, input [3:0] op);
	assign zero = (out == 16'b0) ? 1'b1 : 1'b0;
	
	wire [15:0] sum;
	reg c_in;
	assign b_sel = b ^ c_in;
	cla_16 adder(.s(sum), .c_in, .a, .b(b_sel));
	
	reg left;
	barrel_shift shifter(.out(shift), .a, .b, left);
	
	always begin
		case(op)
			`add: begin
				c_in = 0;
				out = sum;
			end
			`addi: begin
				c_in = 0;
				out = sum;
			end
			`sub: begin
				c_in = 1;
				out = sum;
			end
			`and: out = a & b;
			`or: out = a | b;
			`xor: out = a ^ b;
			`not: out = ~a;
			`slt: begin
				c_in = 1;
				out = (sum[15]) ? 16'b1 : 16'b0;
			end
			`lsl: begin
				left = 1;
				out = shifted;
			end
			`lsr: begin
				left = 0;
				out = shifted;
			end
			`ldr: begin
				c_in = 0;
				out = sum;
			end
			`str: begin
				c_in = 0;
				out = sum;
			end
			`beq: begin
				c_in = 1;
				out = sum;
			end
		endcase
	end
endmodule
