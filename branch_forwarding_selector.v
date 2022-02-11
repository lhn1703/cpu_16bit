module branch_forwarding_selector (
    output reg [15:0] rd1_sel, rd2_sel,
    input [15:0] rd1, rd2, exmem_alu, alu, wb_data, 
    input [3:0] forward_c
    );

    always @(*) begin
       case (forward_c[1:0])
           2'b00: rd1_sel =  rd1;
           2'b01: rd1_sel =  alu;
           2'b10: rd1_sel =  exmem_alu;
           2'b11: rd1_sel =  wb_data;
           default: rd1;
       endcase
       case (forward_c[3:2])
           2'b00: rd2_sel =  rd2;
           2'b01: rd2_sel =  alu;
           2'b10: rd2_sel =  exmem_alu;
           2'b11: rd2_sel =  wb_data;
           default: rd2;
       endcase
    end

endmodule