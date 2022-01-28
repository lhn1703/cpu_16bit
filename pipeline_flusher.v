`include "macro_defines.v"
module pipeline_flusher (
    output reg IF_ID_sync_nop, 
    output [2:0] IF_branch_select,
    input [15:0] ID_read_data_1, ID_read_data_2, forward_c_data,
    input [2:0] forward_c,
	input bl, br, beq, clk
);
    
    always @ (*) begin
        if (bl | br)
            IF_ID_sync_nop = 1'b1;
        else if (beq) begin
            // if (forward_c[1:0] == 2'b11)
            //     IF_ID_sync_nop = (ID_read_data_1 == ID_read_data_2);
            // else begin
            //     if (forward_c[2] == 1'b0)
            //         IF_ID_sync_nop = (ID_read_data_1 == forward_c_data);
            //     else
            //         IF_ID_sync_nop = (ID_read_data_2 == forward_c_data);
            // end
        end 
        else
            IF_ID_sync_nop = 1'b0;
    end
endmodule