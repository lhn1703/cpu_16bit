`include "macro_defines.v"
`define output_group {reg_dst, branch, beq, mem_to_reg, mem_read, mem_write, alu_src, reg_write, alu_op}
module controls (
	output reg reg_dst, branch, beq, mem_to_reg,
	mem_read, mem_write, alu_src, reg_write, [3:0] alu_op,
	input [3:0] opcode
	);
	always @ (opcode) begin
		case (opcode)
			`add: `output_group = 11'b1000_0001_0000;
			`addi: `output_group = 11'b0000_0011_0000;
			`sub: `output_group = 11'b1000_0001_0001;
			`and: `output_group = 11'b1000_0001_0010;
			`or: `output_group = 11'b1000_0001_0100;
			`xor: `output_group = 11'b1000_0001_0110;
			`not: `output_group = 11'b1000_0001_1110;
			`slt: `output_group = 11'b1000_0001_0111;
			`lsl: `output_group = 11'b1000_0001_1100;
			`lsr: `output_group = 11'b1000_0001_1000;
			`ldr: `output_group = 11'b1000_0001_0000;
			`str: `output_group = 11'b1000_0001_0000;
			`b: `output_group = 11'b0000_0000_0000;
			`bl: `output_group = 11'b1000_0001_0000;
			`br: `output_group = 11'b1000_0001_0000;
			`beq: `output_group = 11'b1000_0001_0001;
		endcase
	end
endmodule
	