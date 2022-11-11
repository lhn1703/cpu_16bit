`include "macro_defines.v"
module data_memory
	(
	output [15:0] read_data,
	output reg [15:0] mmio_write_data,
	input [15:0] address,
	input [15:0] write_data,
	input mem_read, mem_write, clk
	);
	
	reg [15:0] mem [0:`data_size];

	//always @ (negedge clk) begin
	//	if (mem_read)
	//		read_data <= mem[address];
	//end
	assign read_data = mem[address];
	
	always @ (negedge clk) begin
		if (mem_write) begin
			mem[address] <= write_data;
			if (address == `mmio_addr)
				mmio_write_data <= write_data;
			else
				mmio_write_data <= 16'h2;
		end	
	end
endmodule