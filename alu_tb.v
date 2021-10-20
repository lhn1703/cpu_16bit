module alu_tb();
	wire [15:0] out;
	wire zero;
	reg [15:0] a, b;
	reg [3:0] op;
    
	alu u1(.out, .zero, .a, .b, .op);
    integer i;   
	initial begin
        a = 1;
        b = 1;
        for (i = 0; i < 16; i = i+1)
            op = #5 i;
	end

endmodule
