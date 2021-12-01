
module fpga_cpu_16bit_tb;

	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	reg KEY = 1, clk = 0;

	fpga_cpu_16bit cpu (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, clk);
	
	always clk = #5 ~clk;
	
	initial begin
		#20;
		KEY = 0;
	end
endmodule