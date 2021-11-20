module cpu_16bit (input [15:0] instruction_in, input load_instruction, clk, pc_reset);
    //pc + instr mem
    wire [15:0] pc_address, new_pc_address, instruction;
    
    //registers
    wire [15:0] read_data1, read_data2;
	wire [3:0] read_reg1, read_reg2, write_reg;
	wire [15:0] write_data;
	wire reg_write;

    pc u_pc (pc_address, new_pc_address, clk, pc_reset);
    instruction_memory u_instr_mem (
        instruction, pc_address, instruction_in, load_instruction, clk
    );

    registers u_regs (	
        read_data1, read_data2,
	    read_reg1, read_reg2, write_reg,
	    write_data,
	    reg_write, clk
	);		


endmodule