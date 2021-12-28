module cpu_16bit (output [15:0] result_reg, input [15:0] initial_input, input clk, pc_reset);
    
	//Pipelining
	reg [31:0] IF_ID_pipe;
	reg [105:0] ID_EX_pipe;
	reg [86:0] EX_MEM_pipe;
	wire IF_ID_write, IF_ID_async_nop
	
	always @(posedge IF_ID_AsyncNOP) begin
			IF_ID_pipe <= 0;
	end
	
	always @(posedge clk) begin
		if (IF_ID_write & ~IF_ID_async_nop)
			IF_ID_pipe <= {IF_pc_plus_1, IF_instruction};
		ID_EX_pipe <= {ID_WB_control, ID_MEM_control, ID_EX_control
	end


endmodule