
module cla_4(output c_out, output [3:0] s, input c_in, input [3:0] a, b);
	wire [3:0] c, p, g;
	assign c[0] = c_in;
	assign c[1] = g[0] | p[0]&c_in;
	assign c[2] = (g[1] | g[0]&p[1]) | (p[1]&p[0]&c_in);
	assign c[3] = (g[2] | g[1]&p[2]) | (g[0]&p[2]&p[1] | (p[2]&p[1])&(p[0]&c_in));
	assign c_out = (g[3] | g[2]&p[3]) | (g[1]&p[3]&p[2] | (g[0]&p[3])&(p[2]&p[1])) | (p[3]&p[2])&(p[1]&p[0])&c_in;
	genvar i;
	generate
		for (i=0; i<4; i=i+1) begin : gen_fa
			cla_fa fa(.p(p[i]), .g(g[i]), .s(s[i]), .a(a[i]), .b(b[i]), .c_in(c[i]));
		end
	endgenerate
endmodule