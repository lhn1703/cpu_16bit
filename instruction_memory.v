`include "macro_defines.v"
// module instruction_memory
// 	(
// 	output reg [15:0] instruction_out,
// 	input [15:0] address,
// 	input [15:0] instruction_in,
// 	input [15:0] load_address,
// 	input instruction_write, clk 
// 	);
	
// 	reg [15:0] mem [0:`data_size];

// 	always @ (*) begin
// 		if (instruction_write == 1'b0)
// 			instruction_out = mem[address];
// 	end

// 	always @ (posedge clk) begin
// 		if (instruction_write)
// 			mem[load_address] <= instruction_in;		
// 	end	
// endmodule

// Quartus Prime Verilog Template
// Single Port ROM

module instruction_memory
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=16)
(
	output reg [15:0] instruction_out,
	input [15:0] address,
	input [15:0] instruction_in,
	input [15:0] load_address,
	input instruction_write, clk 
);

	// Declare the ROM variable
	//reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];
	reg [15:0] mem [0:2**16];

	initial
	begin
		$readmemb("assembler/output.txt", rom);
	end

	always @ (posedge clk)
	begin
		q <= rom[addr];
	end

endmodule