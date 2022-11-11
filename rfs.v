
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module rfs (

		output reg [15:0] data_in,
		output reg byte_cnt,
		output reg data_in_ld,
		
		input [7:0] write_data,
		input write,
		

		//////////// CLOCK //////////
		input clk,

		//////////// RESET //////////
		input reset,

		//////////// GPIO, GPIO connect to RFS - RF and Sensor //////////
		inout [35:0] gpio
	);




	//=======================================================
	//  REG/WIRE declarations
	//=======================================================

	assign gpio[19] = txd;
	assign rxd = gpio[18];

	wire rts; // request to send		  
	wire cts; // clear to send
	wire rxd;
	wire txd;
	wire [7:0] read_data;
	wire rdempty;
	wire read_byte;
	reg read;
	reg cnt;
	
	reg [15:0] buffered_read_data;
	//=======================================================
	//  Structural coding
	//=======================================================

	// UART Controller
	uart_control UART0(

		.clk(clk),
		.reset_n(~reset),
		// tx
		.write(write),
		.writedata(write_data),

		// rx
		.read(read),
		.readdata(read_data),
		.rdempty(rdempty),
		//
		.uart_clk_25m(cnt),
		.uart_tx(txd),
		.uart_rx(rxd)
		
	);

	//read
	always @(posedge clk) begin
		if (~rdempty)
			read <= 1;
		else
			read <= 0;
	end
	
	assign read_byte = ( read & (~rdempty) );

	always @(posedge clk or posedge reset) begin
		data_in_ld <= read_byte;
		if (reset) begin
			buffered_read_data <= 0;
			byte_cnt <= 0;
		end
		else if (~reset & read_byte) begin
			buffered_read_data <= {buffered_read_data[7:0], read_data};
			byte_cnt <= ~byte_cnt;
		end
	end
	
	always @(negedge byte_cnt)
		data_in = buffered_read_data;

	always @(posedge clk)
		cnt <= cnt + 1;

endmodule
