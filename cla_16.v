
module cla_16(output [15:0] s, input c_in, [15:0] a, [15:0] b);
	wire [3:0] c;
	cla_4 g0(.c_out(c[0]), .s(s[3:0]), .a(a[3:0]), .b(b[3:0]), .c_in);
	cla_4 g1(.c_out(c[1]), .s(s[7:4]), .a(a[7:4]), .b(b[7:4]), .c_in(c[0]));
	cla_4 g2(.c_out(c[2]), .s(s[11:8]), .a(a[11:8]), .b(b[11:8]), .c_in(c[1]));
	cla_4 g3(.c_out(c[3]), .s(s[15:12]), .a(a[15:12]), .b(b[15:12]), .c_in(c[2]));
endmodule