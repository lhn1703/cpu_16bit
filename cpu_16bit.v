`include "macro_defines.v"
module cpu_16bit (
		output reg [127:0] debug,
		input [15:0] initial_input,
		input [15:0] bluetooth_addr,
		input [15:0] bluetooth_data,
		input prog_ld,
		input clk,
		input pc_reset
	);
    
	// IF
	//wire [15:0] IF_pc_address_in, IF_pc_address_out;
	
	wire [15:0] IF_pc_address_in, IF_pc_address_in_plus_1;
	wire [15:0] IF_pc_address_in_B, IF_pc_address_in_BL_BEQ, IF_pc_address_in_BR;
	wire [15:0] IF_pc_address_out;
	wire pc_write;
	wire [15:0] IF_pc_plus_1, IF_instruction;
	wire IF_ID_write, IF_ID_sync_nop;

	reg ID_EX_bl;

	wire [2:0] IF_branch_select;
   	wire [15:0] IF_branch_return_addr;

	wire [15:0] ID_BL_BEQ_address;
	wire [15:0] IF_B_address;   
	wire IF_B, IF_BL, IF_BEQ, IF_BR;
	
	// pc adder sections
	assign {IF_BL, IF_BEQ, IF_BR} = IF_branch_select;
	assign IF_B = (IF_instruction[15:12] == `b);
	assign IF_B_address = {IF_pc_plus_1[15:12], IF_instruction[11:0]};
	
	assign IF_pc_address_in_BL_BEQ = (IF_BL | IF_BEQ) ? ID_BL_BEQ_address : 16'b0;
	assign IF_pc_address_in_BR = (~(IF_BL | IF_BEQ) & IF_BR) ? IF_branch_return_addr : 16'b0;
	assign IF_pc_address_in_B = (~(IF_BL | IF_BEQ | IF_BR) & IF_B) ? IF_B_address : 16'b0;
	assign IF_pc_address_in_plus_1 = (IF_BL | IF_BEQ | IF_BR | IF_B) ? 16'b0 : IF_pc_plus_1;
	
	assign IF_pc_address_in = IF_pc_address_in_BL_BEQ | IF_pc_address_in_BR | IF_pc_address_in_B | IF_pc_address_in_plus_1;
	
	/*
	always @ (*) begin
		casex ({IF_B, IF_branch_select})
			4'bx1xx: IF_pc_address_in = ID_BL_BEQ_address;
			4'bx01x: IF_pc_address_in = ID_BL_BEQ_address;
			4'bx001: IF_pc_address_in = IF_branch_return_addr;
			4'b1000: IF_pc_address_in = IF_B_address;
			default: IF_pc_address_in = IF_pc_plus_1;
		endcase
	end
	*/

	pc _pc (IF_pc_address_out, IF_pc_address_in, clk, pc_reset, pc_write);
	add_1 _add_1 (IF_pc_plus_1, IF_pc_address_out);
	instruction_memory _instruction_mem(
		IF_instruction, IF_pc_address_out,
		bluetooth_data, bluetooth_addr,
		prog_ld, clk
	);
	

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
	
	reg ID_mux_reg_write, ID_mux_mem_to_reg;
	reg ID_mux_mem_write, ID_mux_mem_read;
	reg ID_mux_b, ID_mux_br, ID_mux_bl, ID_mux_beq;
	reg ID_mux_alu_src, ID_mux_reg_dst;
	reg [3:0] ID_mux_alu_op;

	wire [31:0] result_reg;

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

	always @(*) begin
		if (controls_clear) begin
			{
				ID_mux_reg_write, ID_mux_mem_to_reg,
				ID_mux_mem_write, ID_mux_mem_read,
				ID_mux_b, ID_mux_br, ID_mux_bl, ID_mux_beq,
				ID_mux_alu_src, ID_mux_reg_dst,
				ID_mux_alu_op
			} <= 14'b0;
		end
		else begin
			{
				ID_mux_reg_write, ID_mux_mem_to_reg,
				ID_mux_mem_write, ID_mux_mem_read,
				ID_mux_b, ID_mux_br, ID_mux_bl, ID_mux_beq,
				ID_mux_alu_src, ID_mux_reg_dst,
				ID_mux_alu_op
			} <= {
				ID_reg_write, ID_mem_to_reg,
				ID_mem_write, ID_mem_read,
				ID_b, ID_br, ID_bl, ID_beq,
				ID_alu_src, ID_reg_dst,
				ID_alu_op
			};
		end
	end

	assign ID_imm = ID_bl ? {{8{IF_ID_instruction[11]}}, IF_ID_instruction[11:4]} : {{12{IF_ID_instruction[3]}}, IF_ID_instruction[3:0]};


	cla_16 _branch_adder (ID_BL_BEQ_address, 1'b0, ID_imm, IF_ID_pc_plus_1);

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
		{
			ID_EX_reg_write, ID_EX_mem_to_reg,
			ID_EX_mem_write, ID_EX_mem_read,
			ID_EX_bl,
			ID_EX_alu_src, ID_EX_reg_dst,
			ID_EX_alu_op
		} <= {
			ID_mux_reg_write, ID_mux_mem_to_reg,
			ID_mux_mem_write, ID_mux_mem_read,
			ID_mux_bl,
			ID_mux_alu_src, ID_mux_reg_dst,
			ID_mux_alu_op
		};

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
	
	reg [15:0] EX_alu_in_1, EX_alu_in_2, EX_write_data;
	reg [15:0] EX_MEM_alu_out;

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
	
	alu _alu(EX_alu_out, EX_alu_in_1, EX_alu_in_2, ID_EX_alu_op);
	
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
	wire [3:0] forward_c;
	wire [15:0] rd1_sel, rd2_sel;

	forwarding_unit _forwarding_unit (
    	forward_a, forward_b,
    	forward_c,
    	EX_rt_rd, ID_EX_rs, ID_EX_rt, ID_rs, ID_rt, EX_MEM_rd, MEM_WB_rd,
    	ID_EX_reg_write, EX_MEM_reg_write, MEM_WB_reg_write
    );

	hazard_detection_unit _hazard_detection_unit(
		pc_write, IF_ID_write, controls_clear,
		ID_EX_mem_read, EX_MEM_mem_read, ID_br,
		ID_EX_rt, ID_rs, ID_rt, EX_MEM_rd
	);
	
	branch_forwarding_selector _branch_forwarding_selector(
    	rd1_sel, rd2_sel,
    	ID_read_data_1, ID_read_data_2, EX_MEM_alu_out, EX_alu_out, WB_data, 
    	forward_c
    );
	
	pipeline_flusher _pipeline_flusher (
    	IF_ID_sync_nop,
    	IF_branch_select,
   		IF_branch_return_addr,
    	rd1_sel, rd2_sel,
		ID_mux_bl, ID_mux_beq, ID_mux_br
    );

	// Debugging
	always @ (*) begin
		debug[31:0] = {16'h0, result_reg};
		debug[63:32] = {IF_pc_address_out, IF_instruction};
		debug[95:64] = {bluetooth_addr, bluetooth_data};
		debug[127:96] = {31'h0, prog_ld};
		/*
		debug[7:0] = IF_pc_address_in_B[7:0];
		debug[15:8] = IF_pc_address_in_BL_BEQ[7:0];
		debug[23:16] = IF_pc_address_in_BR[7:0];
		debug[31:24] = IF_pc_address_in_plus_1[7:0];
		debug[63:32] = result_reg;
		debug[71:64] = IF_pc_address_out[7:0];
		debug[79:72] = IF_pc_address_in[7:0];
		debug[87:80] = {7'b0, pc_write};
		debug[127:88] = 40'b0;
		*/
	end
endmodule