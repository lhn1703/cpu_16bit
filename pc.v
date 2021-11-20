module pc (
	output reg [15:0] pc_address,
	input [15:0] new_adddress,
	input clk, reset
	);
	always @ (posedge clk)
		if (reset)
			pc_address <= 0;
		else
			pc_address <= new_adddress;
endmodule
	