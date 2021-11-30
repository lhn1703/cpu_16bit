`include "macro_defines.v"
module data_memory
	(
	output reg [15:0] read_data,
	input [15:0] address,
	input [15:0] write_data,
	input mem_read, mem_write, clk
	);
	
	reg [15:0] mem [0:`data_size];

	always @ (negedge clk) begin
		if (mem_read)
			read_data <= mem[address];
	end

	always @ (posedge clk) begin
		if (mem_write)
			mem[address] <= write_data;		
	end
endmodule