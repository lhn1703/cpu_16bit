`include "macro_defines.v"

module forwarding_unit(
    output reg [1:0] forward_a, forward_b,
    input [3:0] idex_rs, idex_rt, exmem_rd, memwb_rd,
    input exmem_regwrite, memwb_regwrite
    );

    always @ (*) begin
        if (exmem_regwrite && exmem_rd != `r_zero && exmem_rd == idex_rs)
            forward_a = 2'b10; //forward from EX
        else if (memwb_regwrite && memwb_rd != `r_zero && exmem_rd != idex_rs && memwb_rd == idex_rs)
            forward_a = 2'b01; //forward from MEM
        else
            forward_a == 2'b00;


        if (exmem_regwrite && exmem_rd != `r_zero && exmem_rd == idex_rt)
            forward_b = 2'b10; //forward from EX  
        else if (memwb_regwrite && memwb_rd != `r_zero && exmem_rd != idex_rt && memwb_rd == idex_rt)
            forward_b = 2'b01; //forward from MEM
        else 
            forward_b == 2'b00;
    end

endmodule
