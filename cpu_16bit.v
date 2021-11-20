module cpu_16bit (input [15:0] instruction_in, input load_instruction, clk, pc_reset);
    //IF: pc + instr mem
    wire [15:0] pc_address, new_pc_address, instruction;
    
    //IF: controls 
    wire reg_dst, branch, beq, mem_to_reg;
	wire mem_read, mem_write, alu_src, reg_write; 
    wire [3:0] alu_op;
	wire [3:0] opcode;
    assign opcode = instruction[15:12];

    //IF: registers
    wire [15:0] read_data1, read_data2;
	wire [3:0] read_reg1, read_reg2, write_reg;
	wire [15:0] write_data;
	wire reg_write;
    wire [15:0] sign_extend16;
    assign read_reg1 = instruction[11:8];
    assign read_reg2 = instruction[7:4];
    assign write_reg = (reg_dst == 0) ? instruction[7:4]:instruction[3:0];
    assign sign_extend16 = {8{instruction[7]}, instruction[7:0]};

    //EX: alu
    wire zero;
    wire [15:0] ALU_out; 
    wire [15:0] a, b;
    wire [3:0] ALU_op;

    pc u_pc (pc_address, new_pc_address, clk, pc_reset);
    instruction_memory u_instr_mem (
        instruction, pc_address, instruction_in, load_instruction, clk
    );

    module controls (
	reg_dst, branch, beq, mem_to_reg,
	mem_read, mem_write, alu_src, reg_write, alu_op,
	opcode
	);

    registers u_regs (	
        read_data1, read_data2,
	    read_reg1, read_reg2, write_reg,
	    write_data,
	    reg_write, clk
	);		


endmodule