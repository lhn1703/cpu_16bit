`include "macro_defines.v"

module registers(
	output [15:0] read_data1, read_data2, result_reg, //r0 is always result register
	input [3:0] read_reg1, read_reg2, write_reg,
	input [15:0] write_data,
	input reg_write, clk, reset
	);		
	
	reg [15:0] register_mem [0:15];
	
	assign read_data1 = register_mem[read_reg1];
	assign read_data2 = register_mem[read_reg2];
	assign result_reg = register_mem[`r0];

	always @ (negedge clk or posedge reset) begin
		if (reset) begin
			register_mem[`sp] <= `sp_initial_address;
			register_mem[`r_zero] <= 0;
		end
		else if (reg_write && (write_reg != `r_zero))
			register_mem[write_reg] <= write_data;
	end
	
endmodule
