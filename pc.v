module pc (
	output reg [15:0] pc_address,
	input [15:0] new_address,
	input clk, reset
	);
	always @ (posedge clk or posedge reset)
		if (reset)
			pc_address <= 0;
		else
			pc_address <= new_address;
endmodule
	