`include "macro_defines.v"
//256 sized
module instruction_memory
	(
	output reg [15:0] instruction,
	input [7:0] address,
	input clk
	);
	
	reg [15:0] mem [0:7];
	always @ (posedge clk)
		instruction <= mem[address];
endmodule