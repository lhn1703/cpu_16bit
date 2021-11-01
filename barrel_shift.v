
module barrel_shift(output reg [15:0] out, input left, [15:0] a, [15:0] b);
	always begin
		case(b)
			0: out = a;
			1: out = ((left) ? {a[14:0], 1'b0} : {1'b0, a[15:1]});
			2: out = ((left) ? {a[13:0], 2'b0} : {2'b0, a[15:2]});
			3: out = ((left) ? {a[12:0], 3'b0} : {3'b0, a[15:3]});
			4: out = ((left) ? {a[11:0], 4'b0} : {4'b0, a[15:4]});
			5: out = ((left) ? {a[10:0], 5'b0} : {5'b0, a[15:5]});
			6: out = ((left) ? {a[9:0], 6'b0} : {6'b0, a[15:6]});
			7: out = ((left) ? {a[8:0], 7'b0} : {7'b0, a[15:7]});
			8: out = ((left) ? {a[7:0], 8'b0} : {8'b0, a[15:8]});
			9: out = ((left) ? {a[6:0], 9'b0} : {9'b0, a[15:9]});
			10: out = ((left) ? {a[5:0], 10'b0} : {10'b0, a[15:10]});
			11: out = ((left) ? {a[4:0], 11'b0} : {11'b0, a[15:11]});
			12: out = ((left) ? {a[3:0], 12'b0} : {12'b0, a[15:12]});
			13: out = ((left) ? {a[2:0], 13'b0} : {13'b0, a[15:13]});
			14: out = ((left) ? {a[1:0], 14'b0} : {14'b0, a[15:14]});
			15: out = ((left) ? {a[0], 15'b0} : {15'b0, a[15]});
		endcase
	end
endmodule