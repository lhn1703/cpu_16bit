`include "macro_defines.v"
module cpu_16bit (output [15:0] result_reg, input [15:0] initial_input, input clk, pc_reset);
    
	// IF
	wire [15:0] IF_pc_address_in, IF_pc_address_out;
	wire [15:0] EX_branch_address_3;
	wire pc_write;
	wire [15:0] IF_pc_plus_1, IF_instruction;
	wire IF_ID_write, IF_ID_sync_nop;

	reg ID_EX_b, ID_EX_br, ID_EX_bl, ID_EX_beq;
	wire EX_alu_zero;
	
	assign IF_pc_address_in = (ID_EX_b | ID_EX_br | ID_EX_bl | (ID_EX_beq&EX_alu_zero)) ? EX_branch_address_3 : IF_pc_plus_1;
	pc _pc (IF_pc_address_out, IF_pc_address_in, clk, pc_reset, pc_write);
	add_1 _add_1 (IF_pc_plus_1, IF_pc_address_out);
	instruction_memory _instruction_mem(IF_instruction, IF_pc_address_out, clk);
	

	// IF/ID
	reg [15:0] IF_ID_pc_plus_1;
	reg [15:0] IF_ID_instruction;

	always @ (posedge clk or posedge pc_reset) begin
		if (pc_reset) begin
		 	IF_ID_instruction <= `nop;
			//IF_ID_pc_plus_1 <= 16'b0;
		end
		else if (~IF_ID_write) begin
			IF_ID_pc_plus_1 <= IF_ID_pc_plus_1;
			IF_ID_instruction <= IF_ID_instruction;
		end
		else if (IF_ID_sync_nop)
			IF_ID_instruction <= `nop;
		else begin
			IF_ID_pc_plus_1 <= IF_pc_plus_1;
			IF_ID_instruction <= IF_instruction;
		end
	end
	

	// ID
	reg MEM_WB_reg_write;
	wire [15:0] WB_data;
	reg [3:0] MEM_WB_rd;
	wire controls_clear;
	wire [15:0] ID_read_data_1, ID_read_data_2;
	wire [15:0] ID_imm;
	reg [3:0] ID_rs, ID_rt, ID_rd;
	wire [15:0] ID_branch_address;
	
	wire ID_reg_write, ID_mem_to_reg;
	wire ID_mem_write, ID_mem_read;
	wire ID_b, ID_br, ID_bl, ID_beq, ID_alu_src, ID_reg_dst;
	wire [3:0] ID_alu_op;

	always @ (*) begin
		case(IF_ID_instruction[15:12]) //opcode
			`addi: begin // i-type
				ID_rs = IF_ID_instruction[11:8];
				ID_rt = `r_zero;
				ID_rd = IF_ID_instruction[7:4];
			end
			`lsl: begin
				ID_rs = IF_ID_instruction[11:8];
				ID_rt = `r_zero;
				ID_rd = IF_ID_instruction[7:4];
			end
			`lsr: begin
				ID_rs = IF_ID_instruction[11:8];
				ID_rt = `r_zero;
				ID_rd = IF_ID_instruction[7:4];
			end
			`ldr: begin
				ID_rs = IF_ID_instruction[11:8];
				ID_rt = IF_ID_instruction[7:4];
				ID_rd = `r_zero;
			end
			`str: begin
				ID_rs = IF_ID_instruction[11:8];
				ID_rt = IF_ID_instruction[7:4];
				ID_rd = `r_zero;
			end
			`beq: begin
				ID_rs = IF_ID_instruction[11:8];
				ID_rt = IF_ID_instruction[7:4];
				ID_rd = `r_zero;
			end
			`b: begin
				ID_rs = `r_zero;
				ID_rt = `r_zero;
				ID_rd = `r_zero;
			end
			`bl: begin
				ID_rs = `r_zero;
				ID_rt = `r_zero;
				ID_rd = IF_ID_instruction[3:0];
			end
			`br: begin
				ID_rs = IF_ID_instruction[11:8];
				ID_rt = `r_zero;
				ID_rd = `r_zero;
			end
			default: begin // r-type instruction
				ID_rs = IF_ID_instruction[11:8];
				ID_rt = IF_ID_instruction[7:4];
				ID_rd = IF_ID_instruction[3:0];
			end
		endcase
	end

	assign ID_imm = ID_bl ? {{8{IF_ID_instruction[11]}}, IF_ID_instruction[11:4]} : {{12{IF_ID_instruction[3]}}, IF_ID_instruction[3:0]};
	assign ID_branch_address = {IF_ID_pc_plus_1[15:12], IF_ID_instruction[11:0]};

	controls _controls (
		ID_reg_dst, ID_b, ID_beq, ID_bl, ID_br, ID_mem_to_reg,
		ID_mem_read, ID_mem_write, ID_alu_src, ID_reg_write, ID_alu_op,
		IF_ID_instruction[15:12]
	);

	registers _reg (
		ID_read_data_1, ID_read_data_2, result_reg,
		IF_ID_instruction[11:8], IF_ID_instruction[7:4], MEM_WB_rd,
		WB_data, initial_input,
		MEM_WB_reg_write, clk, pc_reset
	);

	
	// ID/EX
	reg ID_EX_reg_write, ID_EX_mem_to_reg;
	reg ID_EX_mem_write, ID_EX_mem_read;
	reg ID_EX_alu_src, ID_EX_reg_dst;
	reg [3:0] ID_EX_alu_op;

	reg [15:0] ID_EX_branch_address, ID_EX_pc_plus_1;
	reg [15:0] ID_EX_read_data_1, ID_EX_read_data_2;
	reg [15:0] ID_EX_imm;
	reg [3:0] ID_EX_rs, ID_EX_rt, ID_EX_rd;

	always @(posedge clk) begin
		if (controls_clear) begin
			{
				ID_EX_reg_write, ID_EX_mem_to_reg,
				ID_EX_mem_write, ID_EX_mem_read,
				ID_EX_b, ID_EX_br, ID_EX_bl, ID_EX_beq,
				ID_EX_alu_src, ID_EX_reg_dst,
				ID_EX_alu_op
			} <= 14'b0;
		end
		else begin
			{
				ID_EX_reg_write, ID_EX_mem_to_reg,
				ID_EX_mem_write, ID_EX_mem_read,
				ID_EX_b, ID_EX_br, ID_EX_bl, ID_EX_beq,
				ID_EX_alu_src, ID_EX_reg_dst,
				ID_EX_alu_op
			} <= {
				ID_reg_write, ID_mem_to_reg,
				ID_mem_write, ID_mem_read,
				ID_b, ID_br, ID_bl, ID_beq,
				ID_alu_src, ID_reg_dst,
				ID_alu_op
			};
		end

		ID_EX_branch_address <= ID_branch_address;
		ID_EX_pc_plus_1 <= IF_ID_pc_plus_1;
		ID_EX_read_data_1 <= ID_read_data_1;
		ID_EX_read_data_2 <= ID_read_data_2;
		ID_EX_imm <= ID_imm;

		ID_EX_rs <= ID_rs;
		ID_EX_rt <= ID_rt;
		ID_EX_rd <= ID_rd;
	end
	

	// EX
	wire [15:0] EX_alu_out;
	reg [3:0] EX_rt_rd;
	wire [1:0] forward_a, forward_b;

	reg [15:0] EX_MEM_alu_out;

	//need to implement branching adder and muxes
	wire [15:0] EX_branch_address_1, EX_branch_address_2;
	reg [15:0] EX_alu_in_1, EX_alu_in_2, EX_write_data;
	cla_16 _branch_adder (EX_branch_address_1, 1'b0, ID_EX_imm, ID_EX_pc_plus_1);
	assign EX_branch_address_2 = ID_EX_b ? ID_EX_branch_address : EX_branch_address_1;
	assign EX_branch_address_3 = ID_EX_br ? EX_alu_in_1 : EX_branch_address_2;

	always @ (*) begin
		case (forward_a) 
			2'b00: EX_alu_in_1 = ID_EX_read_data_1;
			2'b01: EX_alu_in_1 = WB_data;
			2'b10: EX_alu_in_1 = EX_MEM_alu_out;
			default: EX_alu_in_1 = 16'hffff;
		endcase

		case (forward_b)
			2'b00: EX_write_data = ID_EX_read_data_2;
			2'b01: EX_write_data = WB_data;
			2'b10: EX_write_data = EX_MEM_alu_out;
			default: EX_write_data = 16'hffff;
		endcase	

		EX_alu_in_2 = (ID_EX_alu_src) ? ID_EX_imm : EX_write_data;
		EX_rt_rd = (ID_EX_reg_dst) ? ID_EX_rd : ID_EX_rt;
	end
	
	alu _alu(EX_alu_zero, EX_alu_out, EX_alu_in_1, EX_alu_in_2, ID_EX_alu_op);
	
	// EX/MEM
	reg EX_MEM_reg_write, EX_MEM_bl, EX_MEM_mem_to_reg;
	reg EX_MEM_mem_write, EX_MEM_mem_read;
	reg [15:0] EX_MEM_pc_plus_1, EX_MEM_write_data; 
	reg [3:0] EX_MEM_rd;

	always @ (posedge clk) begin
		EX_MEM_reg_write <= ID_EX_reg_write;
		EX_MEM_bl <= ID_EX_bl;
		EX_MEM_mem_to_reg <= ID_EX_mem_to_reg;

		EX_MEM_mem_write <= ID_EX_mem_write;
		EX_MEM_mem_read <= ID_EX_mem_read;

		EX_MEM_pc_plus_1 <= ID_EX_pc_plus_1;
		EX_MEM_alu_out <= EX_alu_out;
		EX_MEM_write_data <= EX_write_data;

		EX_MEM_rd <= EX_rt_rd;
	end
	
	// MEM
	wire [15:0] MEM_read_data;

	data_memory _data_memory(
		MEM_read_data,
		EX_MEM_alu_out,
		EX_MEM_write_data,
		EX_MEM_mem_read, EX_MEM_mem_write, clk
	);
	
	// MEM/WB
	reg MEM_WB_bl, MEM_WB_mem_to_reg;
	reg [15:0] MEM_WB_pc_plus_1, MEM_WB_read_data, MEM_WB_alu_out;
	
	always @ (posedge clk) begin
		MEM_WB_reg_write <= EX_MEM_reg_write; 
		MEM_WB_bl <= EX_MEM_bl; 
		MEM_WB_mem_to_reg <= EX_MEM_mem_to_reg;

		MEM_WB_pc_plus_1 <= EX_MEM_pc_plus_1;
		MEM_WB_read_data <= MEM_read_data;
		MEM_WB_alu_out <= EX_MEM_alu_out;
		MEM_WB_rd <= EX_MEM_rd;
	end
	
	// WB
	wire [15:0] WB_mux_1;
	assign WB_mux_1 = (MEM_WB_mem_to_reg) ? MEM_WB_read_data : MEM_WB_alu_out; 
	assign WB_data = (MEM_WB_bl) ? MEM_WB_pc_plus_1 : WB_mux_1;

	// Pipelining Units
	forwarding_unit _forwarding_unit (
		forward_a, forward_b,
		ID_EX_rs, ID_EX_rt, EX_MEM_rd, MEM_WB_rd,
		EX_MEM_reg_write, MEM_WB_reg_write
	);
	hazard_detection_unit _hazard_detection_unit(
		pc_write, IF_ID_write, controls_clear,
		ID_EX_mem_read,
		ID_EX_rt, ID_rs, ID_rt
	);
	pipeline_flusher _pipeline_flusher(
		IF_ID_sync_nop,
		ID_read_data_1, ID_read_data_2, EX_alu_out,
		IF_ID_instruction[15:12], ID_rs, ID_rt, EX_rt_rd,
		clk
	);
endmodule