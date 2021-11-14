
module add_2_tb;
	reg [15:0] in;
	wire [15:0] out;
	add_2 uut(.out, .in);
	integer i;
	initial begin
		for(i=0; i<65536; i=i+1) begin
			in = i;
			#5;
		end
	end
endmodule