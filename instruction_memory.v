`include "macro_defines.v"
module instruction_memory
	(
	output reg [15:0] instruction_out,
	input [15:0] address,
	input clk 
	);

	reg [15:0] rom [0:`data_size];

	initial begin
		$readmemb("assembler/output.txt", rom);
	end

	always @ (negedge clk) begin
		instruction_out <= rom[address];
	end
endmodule
