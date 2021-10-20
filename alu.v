
`include "macro_defines.v"

module alu(output reg [15:0] out, output zero, input [15:0] a, b, input [3:0] op);
	assign zero = (out == 16'b0) ? 1'b1 : 1'b0;
	always @(*) begin
		case(op)
			`add: out = a + b;
			`addi: out = a + b;
			`sub: out = a - b;
			`and: out = a & b;
			`or: out = a | b;
			`xor: out = a ^ b;
			`not: out = ~a;
			`slt: out = (a < b) ? 16'b1 : 16'b0;
			`lsl: out = a << b;
			`lsr: out = a >> b;
			`ldr: out = a + b;
			`str: out = a + b;
			`beq: out = a - b;
		endcase
	end
endmodule
