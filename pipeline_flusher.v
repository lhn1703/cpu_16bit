`include "macro_defines.v"
module pipeline_flusher (
    output IF_ID_sync_nop,
    output [2:0] IF_branch_select,
    output [15:0] branch_return_addr,
    input [15:0] rd1_sel, rd2_sel,
	input bl, beq, br
    );
    wire beq_true;
    assign beq_true = (rd1_sel == rd2_sel) & beq;

    assign IF_branch_select = {bl, beq_true, br};
    assign IF_ID_sync_nop = (bl | br | beq_true);
    assign branch_return_addr = rd1_sel;
endmodule