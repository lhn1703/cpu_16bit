`include "macro_defines.v"

module registers(
	output reg [15:0] read_data1, read_data2,
	input [3:0] read_reg1, read_reg2, write_reg,
	input [15:0] write_data,
	input reg_write, clk
	);		
	
	reg [15:0] register_mem [0:15];	
	always @ (posedge clk) begin
        register_mem[`r_zero] <= 0;
		if (reg_write && write_reg != `r_zero)
			register_mem[write_reg] <= write_data;
		read_data1 <= register_mem[read_reg1];
		read_data2 <= register_mem[read_reg2];
	end
	
endmodule
