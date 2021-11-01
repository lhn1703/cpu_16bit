
module cla_fa(output p, g, s, input a, b, c_in);
	assign s = a^b^c_in;
	assign p = a | b;
	assign g = a & b;
endmodule