
module cla_4_tb;
	reg [3:0] a, b;
	reg c_in;
	wire [3:0] s, b_n;
	wire c_out;
	integer i, f;
	
	cla_4 uut(.s, .a, .b, .c_in);
	assign b_n = ~b;
	
	initial begin
		f = $fopen("cla_4_tb.csv","w");
		for(i=0; i<9'h1ff; i=i+1) begin
			{c_in, a, b} = i;
			#1;
			$fwrite(f,"%b,%d,%d,%d\n", c_in, a, b, s);
		end
		$fclose(f);
	end
endmodule