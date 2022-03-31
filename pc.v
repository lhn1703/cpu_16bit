module pc (
	output reg [15:0] pc_address,
	input [15:0] new_address,
	input clk, reset, pc_write
	);
	always @ (posedge clk or posedge reset)
		if (reset)
			pc_address <= 0;
		else if (pc_write & ~reset)
			pc_address <= new_address;
		else if (~pc_write & ~reset)
			pc_address <= pc_address;
endmodule
	