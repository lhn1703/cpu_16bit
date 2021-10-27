`include "macro_defines.v"
//256 sized
module data_memory
	(
	output reg [15:0] read_data,
	input [7:0] address,
	input [15:0] write_data,
	input mem_read, mem_write, clk
	);
	
	reg [15:0] mem [0:7];
	always @ (posedge clk) begin
		if (mem_read)
			read_data <= mem[address];
		else if (mem_write)
			mem[address] <= write_data;
			
	end		
endmodule