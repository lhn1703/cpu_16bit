module pc (
	output reg [15:0] pc_address,
	input [15:0] new_adddress,
	input clk
	);
	always @ (posedge clk)
		pc_address <= new_adddress;
endmodule
	