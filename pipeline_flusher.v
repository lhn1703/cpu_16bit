`include "macro_defines.v"
module pipeline_flusher (
    output IF_ID_sync_nop,
    input [15:0] ID_read_data_1, ID_read_data_2, EX_alu_out,
    input [3:0] opcode, ID_rs, ID_rt, EX_rt_rd,
	input clk
);
    
    reg start_nop;
    reg flush_counter;
    always @ (*) begin
        if (opcode == `b || opcode == `bl || opcode == `br)
            start_nop = 1'b1;
        else if (opcode == `beq) begin
            if (EX_rt_rd == ID_rs)
                start_nop = (ID_read_data_2 == EX_alu_out);
            else if (EX_rt_rd == ID_rt)
                start_nop = (ID_read_data_1 == EX_alu_out);
            else
                start_nop = (ID_read_data_1 == ID_read_data_2);
        end 
        else
            start_nop = 1'b0;
    end
    always @ (posedge clk) begin
        if (flush_counter == 1'b0)
            flush_counter <= start_nop;
        else
            flush_counter <= 1'b0;
    end

    assign IF_ID_sync_nop = (flush_counter > 1'b0) ? 1'b1 : start_nop;
endmodule