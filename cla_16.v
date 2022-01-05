
module cla_16(output [15:0] s, input c_in, input [15:0] a, b);
	//assign s = c_in ? a-b : a+b;
	
	wire [3:0] c, p, g;
	assign c[0] = c_in;
	assign c[1] = g[0] | p[0]&c_in;
	assign c[2] = g[1] | g[0]&p[1] | p[1]&p[0]&c_in;
	assign c[3] = g[2] | g[1]&p[2] | g[0]&p[2]&p[1] | p[2]&p[1]&p[0]&c_in;

	cla_4 g0(p[0], g[0], s[3:0], c[0], a[3:0], b[3:0]);
	cla_4 g1(p[1], g[1], s[7:4], c[1], a[7:4], b[7:4]);
	cla_4 g2(p[2], g[2], s[11:8], c[2], a[11:8], b[11:8]);
	cla_4 g3(p[3], g[3], s[15:12], c[3], a[15:12], b[15:12]);
	
endmodule