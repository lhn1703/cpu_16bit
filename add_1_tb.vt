
module add_1_tb;
	reg [15:0] in;
	wire [15:0] out;
	add_1 uut(.out, .in);
	integer i;
	initial begin
		for(i=0; i<65536; i=i+1) begin
			in = i;
			#5;
		end
	end
endmodule