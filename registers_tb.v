module registers_tb();
	wire [16:0] read_data1, read_data2;
	reg [3:0] read_reg1, read_reg2, write_reg;
	reg [15:0] write_data;
	reg reg_write, cl;

	registers u1(.read_data1, .read_data2, .read_reg1, .read_reg2, .write_reg, .write_data, .reg_write, .cl);

	inital begin

	end

endmodule
