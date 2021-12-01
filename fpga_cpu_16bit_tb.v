
module fpga_cpu_16bit_tb;

	wire [6:0] HEX0, HEX1, HEX2, HEX3;
	reg [3:0] KEY = 1, clk = 0;
	wire [6:0] HEX0n, HEX1n, HEX2n, HEX3n;

	assign {HEX0n, HEX1n, HEX2n, HEX3n} = ~{HEX0, HEX1, HEX2, HEX3};
	fpga_cpu_16bit cpu (HEX0, HEX1, HEX2, HEX3, KEY, clk);
	
	always clk = #5 ~clk;
	
	initial begin
		#20;
		KEY = 0;
	end
endmodule