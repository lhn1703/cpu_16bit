module cpu_16bit (input [15:0] instruction_in, load_address, input load_instruction, clk, pc_reset);
    //Branching
	wire [15:0] pc_plus_1, branch_sum;
	wire [15:0] new_pc_address1, new_pc_address2, new_pc_address3;
	
	//IF: pc + instr mem
    wire [15:0] pc_address, new_pc_address, instruction;
    
    //IF: controls 
    wire reg_dst, branch, beq, bl, br, mem_to_reg;
	wire mem_read, mem_write, alu_src, reg_write; 
    wire [3:0] alu_op;
	wire [3:0] opcode;
    assign opcode = instruction[15:12];

    //ID: registers
    wire [15:0] read_data1, read_data2;
	wire [3:0] read_reg1, read_reg2, write_reg;
	wire [15:0] reg_write_data;
	wire [7:0] sign_extend4, immediate;
    wire [15:0] sign_extend16;
    assign read_reg1 = instruction[11:8];
    assign read_reg2 = instruction[7:4];
    assign write_reg = (reg_dst == 0) ? instruction[7:4] : instruction[3:0];
	assign sign_extend4 = {{4{instruction[3]}}, instruction[3:0]};
	assign immediate = (bl == 0) ? sign_extend4 : instruction[11:4];
    assign sign_extend16 = {{8{immediate[7]}}, immediate};

    //EX: alu
    wire zero;
    wire [15:0] ALU_out; 
    wire [15:0] a, b;
    wire [3:0] ALU_op;
	assign a = read_data1;
	assign b = (alu_src == 0) ? read_data2 : sign_extend16;
	
	//MEM: data memory
	wire [15:0] read_data;
	wire [15:0] mem_address, mem_write_data;
	wire [15:0] write_back1, write_back2;
	assign mem_address = ALU_out;
	assign mem_write_data = read_data2;
	assign write_back1 = (mem_to_reg == 0) ? ALU_out : read_data;
	assign write_back2 = (bl == 0) ? write_back1 : pc_plus_1;
	
	assign new_pc_address1 = (beq&zero | bl) ? branch_sum : pc_plus_1;
	assign new_pc_address2 = (branch == 0) ? new_pc_address1 : {pc_plus_1[15:12], instruction[11:0]};
	assign new_pc_address3 = (br == 0) ? new_pc_address2 : read_data1;

	//WB: write back
	assign reg_write_data = write_back2;
	assign new_pc_address = new_pc_address3;
	
	add_1 u_add_1 (pc_plus_1, pc_address);
	
	cla_16 branch_add (branch_sum, 1'b0, pc_plus_1, sign_extend16);
	
	alu u_alu (zero, ALU_out, a, b, alu_op);
	
    pc u_pc (pc_address, new_pc_address, clk, pc_reset);
	
    instruction_memory u_instr_mem (
        instruction, pc_address, instruction_in, load_address, load_instruction, clk
    );

    controls u_control (
		reg_dst, branch, beq, bl, br, mem_to_reg,
		mem_read, mem_write, alu_src, reg_write, alu_op,
		opcode
	);

    registers u_regs (	
        read_data1, read_data2,
	    read_reg1, read_reg2, write_reg,
	    reg_write_data,
	    reg_write, clk, pc_reset
	);	

	data_memory u_data_mem (
		read_data,
		mem_address, mem_write_data,
		mem_read, mem_write, clk
	);	


endmodule