
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE2_115_BluetoothSPP_Slave(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK_50,

	//////////// LED //////////
	output	reg     [9:0]		LEDR,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// SW //////////
	input 		    [9:0]		SW,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,


	//////////// GPIO, GPIO connect to RFS - RF and Sensor //////////
	inout 		     [35:0]		GPIO_1
);




//=======================================================
//  REG/WIRE declarations
//=======================================================

assign  GPIO_1[19] = txd;
assign  rxd  = GPIO_1[18];

wire 				rts; // request to send		  
wire 				cts; // clear to send
wire 				rxd;
wire 				txd;
wire	 [7:0]   uart_data;
wire	         rdempty;
wire	         write;
reg	     	   read;
reg	         cnt;
//=======================================================
//  Structural coding
//=======================================================

// UART Controller
uart_control UART0(

	.clk(CLOCK_50),
	.reset_n(KEY[0]),
	// tx
	.write(write),
	.writedata(uart_data),

	// rx
	.read(read),
	.readdata(uart_data),
	.rdempty(rdempty),
	//
	.uart_clk_25m(cnt),
	.uart_tx(txd),
	.uart_rx(rxd)
	
);	

//read
always@(posedge CLOCK_50)
begin
  if (~rdempty)
		read <= 1;
  else
		read <= 0;
end
assign  write = ( read & (~rdempty) );

always@(posedge CLOCK_50 or negedge KEY[0])
begin
  if(!KEY[0])
    LEDR <= 0;
  else if(KEY[0] & write)
  begin
    case(uart_data)
	 10'h30:LEDR <= LEDR | 8'd1;
	 10'h31:LEDR <= LEDR | 8'd2;
	 10'h32:LEDR <= LEDR | 8'd4;
	 10'h33:LEDR <= LEDR | 8'd8;
	 10'h34:LEDR <= LEDR & 8'he;
	 10'h35:LEDR <= LEDR & 8'hd;
	 10'h36:LEDR <= LEDR & 8'hb;
	 10'h37:LEDR <= LEDR & 8'h7;
	 10'h38:LEDR <= LEDR | 8'hf;
	 10'h39:LEDR <= LEDR & 8'h0;
	 default : LEDR <= LEDR;
	 endcase
  end
  else
    LEDR <= LEDR;
end

always@(posedge CLOCK_50)
	cnt <= cnt + 1;

endmodule
