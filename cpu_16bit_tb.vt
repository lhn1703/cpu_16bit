
module cpu_16bit_tb();
	reg pc_reset = 1, clk = 0;
	wire [15:0] result_reg;
	always clk = #5 ~clk;
	
	cpu_16bit u_cpu(result_reg, clk, pc_reset);

	integer file;
	integer i = 0;
	
	initial begin
		#10;
		pc_reset = 0;
	end
endmodule
