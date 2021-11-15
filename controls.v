`include "macro_defines.v"
`define output_group {reg_dst, branch, beq, mem_to_reg, mem_read, mem_write, alu_src, reg_write}
//aluOP can be fed directly to the alu, no need here
module controls (
	output reg reg_dst, branch, beq, mem_to_reg,
	mem_read, mem_write, alu_src, reg_write,
	input [3:0] opcode
	);
	always @ (opcode) begin
		case (opcode)
			`add: `output_group = 8'b1000_0001;
			`addi: 
		endcase
	end
endmodule
	