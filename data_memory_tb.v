module data_memory _tb();
	wire [15:0] read_data;
	reg [7:0] address;
	reg [15:0] write_data;
	reg mem_read, mem_write, clk;

	always clk = #5 clk;

	data_memory  u1(.read_data, .address, .write_data, .mem_read, .mem_write, .clk);

	initial begin
		clk = 0;
		
	end

endmodule
