module hex_decoder (output [6:0] hex_output, input [3:0] bin_digit);
	reg [6:0] invertedHex;
	assign hex_output = ~invertedHex; //FPGA hex LEDs are enable LOW
	
	always @ (*) begin 
		case(bin_digit) 
			0:invertedHex = 7'h7E;	
			1:invertedHex = 7'h06;
			2:invertedHex = 7'h5B;
			3:invertedHex = 7'h4F;
			4:invertedHex = 7'h66;
			5:invertedHex = 7'h6D;
			6:invertedHex = 7'h7D;
			7:invertedHex = 7'h07;
			8:invertedHex = 7'h7F;
			9:invertedHex = 7'h67;
			10:invertedHex = 7'h77;
			11:invertedHex = 7'h7C;
			12:invertedHex = 7'h39;
			13:invertedHex = 7'h5E;
			14:invertedHex = 7'h79;
			15:invertedHex = 7'h71;
		endcase
end 
endmodule