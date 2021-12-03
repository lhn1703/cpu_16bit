module registers_tb();
	wire [16:0] read_data1, read_data2;
	reg [3:0] read_reg1, read_reg2, write_reg;
	reg [15:0] write_data;
	reg reg_write, clk = 0;
    always clk = #5 ~clk;

	registers u1(.read_data1, .read_data2, .read_reg1, .read_reg2, .write_reg, .write_data, .reg_write, .clk);
    
    integer i;
	initial begin
        reg_write = 1;
        for (i = 0; i < 16; i = i + 1) begin
            write_reg = i;
            write_data = i;
            #10;
        end
        reg_write = 0;    
        for (i = 0; i < 16; i = i + 1) begin   
            read_reg1 = i;
            read_reg2 = i;
            #10;
        end
	end

endmodule
