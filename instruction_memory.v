`include "macro_defines.v"
module instruction_memory
	(
	output reg [15:0] instruction_out,
	input [15:0] address,
	input clk, reset 
	);

	//reg delayed_reset;
	reg [15:0] rom [0:`data_size];

	initial begin
		$readmemb("assembler/output.txt", rom);
	end

	always @ (posedge clk) begin
		if (reset)
			instruction_out <= rom[0];
		//	delayed_reset <= 1;
		//else if (delayed_reset) begin
		//	instruction_out <= rom[0];
		//	delayed_reset <= 0;
		//end
		else
			instruction_out <= rom[address];
	end
endmodule
