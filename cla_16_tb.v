
module cla_16_tb;
	reg [15:0] a, b;
	reg c_in;
	wire [15:0] s, b_n;
	integer i, f;
	
	cla_16 uut(.s, .a, .b, .c_in);
	assign b_n = ~b;
	
	initial begin
		f = $fopen("cla_16_tb.csv","w");
		for(i=0; i<100; i=i+1) begin
			c_in = $random % 2;
			a = $random % (16'hffff + 1);
			b = $random % (16'hffff + 1);
			#5;
			$fwrite(f,"%b,%d,%d,%d\n", c_in, a, b, s);
		end
		$fclose(f);
	end
endmodule