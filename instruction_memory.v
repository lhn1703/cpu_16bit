`include "macro_defines.v"
module instruction_memory
	(
	output reg [15:0] instruction_out,
	input [15:0] address_out,
	input [15:0] instruction_in,
	input [15:0] address_in,
	input write,
	input clk
	);

	reg [15:0] ram [0:`data_size];

	initial begin
		$readmemb("assembler/output.txt", ram);
	end

	always @ (negedge clk) begin
		if (write)
			ram[address_in] <= instruction_in;
		else
			instruction_out <= ram[address_out];
	end
endmodule
