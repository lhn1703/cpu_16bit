module data_memory_tb();
	wire [15:0] read_data;
	reg [15:0] address;
	reg [15:0] write_data;
	reg mem_read, mem_write, clk;

	data_memory u1(.read_data, .address, .write_data, .mem_read, .mem_write, .clk);
	
	integer i;
	initial begin
		clk = 0;
		mem_read = 0;
		#10;
		mem_write = 1;
		for (i=0; i<30; i=i+1) begin
			address = i;
			write_data = i;
			#10;
		end

		mem_write = 0;
		mem_read = 1;

		for (i=0; i<30; i=i+1) begin
			address = i;
			#5;
		end

		$stop;
	end
	always clk = #5 ~clk;

endmodule
