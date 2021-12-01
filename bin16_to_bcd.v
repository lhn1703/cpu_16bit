module bin16_to_bcd (
    output negative, 
    output [3:0] bcd_digit0, bcd_digit1, bcd_digit2, bcd_digit3, bcd_digit4, 
    input [15:0] bin
    );
	wire [15:0] bin_n;
    wire [3:0], x0, x1, x2, x3, x4;
	wire [3:0], x0_c, x1_c, x2_c, x3_c, x4_c;
    wire [3:0] s0, s1, s2, s3, s4;
	wire [4:1] c0;
    wire [4:0] c1;
	reg [3:0] excess;
    //make sure the output negative is 1 if input is negative and vice versa
	add_1 bin_comp (bin_n, ~bin);
	assign negative = bin[15];
    assign {x3, x2, x1, x0} = (negative == 1'b1) ? bin_n : bin;
    
	cla_4 u10 (c0[1], x1_c, excess[0], x1, 4'd0);
    cla_4 u20 (c0[2], x2_c, excess[1], x2, 4'd0);
    cla_4 u30 (c0[3], x3_c, excess[2], x3, 4'd0);
    cla_4 u40 (c0[4], x4_c, excess[3], x4, 4'd0);
	
    cla_4 u0 (c1[0], s0, 1'b0, x0, 4'd6);
    cla_4 u11 (c1[1], s1, 1'b0, x1_c, 4'd6);
    cla_4 u21 (c1[2], s2, 1'b0, x2_c, 4'd6);
    cla_4 u31 (c1[3], s3, 1'b0, x3_c, 4'd6);
    cla_4 u41 (c1[4], s4, 1'b0, x4_c, 4'd6);

    bcd_digit0 = (x0 < 4'd10) ? x0:s0;
	bcd_digit1 = (x1_c < 4'd10) ? x0:s0;
	bcd_digit2 = (x2_c < 4'd10) ? x0:s0;
	bcd_digit3 = (x3_c < 4'd10) ? x0:s0;
	bcd_digit4 = (x4_c < 4'd10) ? x0:s0;
	
    always @ (*) begin
		excess[0] = (x0 < 4'd10);
		
		if (x1_c == 4'd0)
			excess[1] = c0[1];
		else if (x1_c < 4'd10)
			excess[1] = 1'b1;
		else
			excess[1] = 1'b0;
		
		if (x2_c == 4'd0)
			excess[2] = c0[2];
		else if (x2_c < 4'd10)
			excess[2] = 1'b1;
		else
			excess[2] = 1'b0;
		
		if (x3_c == 4'd0)
			excess[3] = c0[3];
		else if (x3_c < 4'd10)
			excess[3] = 1'b1;
		else
			excess[3] = 1'b0;
		
		if (x4_c == 4'd0)
			excess[4] = c0[4];
		else if (x4_c < 4'd10)
			excess[4] = 1'b1;
		else
			excess[4] = 1'b0;
    end
endmodule
