`include "macro_defines.v"
module instruction_memory
	(
	output reg [15:0] instruction_out,
	input [15:0] address, 
	input [15:0] instruction_in,
	input instruction_write, clk 
	);
	
	reg [15:0] mem [0:`data_size];

	always @ (*) begin
		instruction_out = mem[address];
	end

	always @ (posedge clk) begin
		if (instruction_write)
			mem[address] <= instruction_in;		
	end	
endmodule