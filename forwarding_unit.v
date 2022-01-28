`include "macro_defines.v"

module forwarding_unit(
    output reg [1:0] forward_a, forward_b,
    output reg [2:0] forward_c,
    input [3:0] idex_rt_rd, idex_rs, idex_rt, id_rs, id_rt exmem_rd, memwb_rd,
    input exmem_regwrite, memwb_regwrite
    );

    always @ (*) begin
        if (exmem_regwrite && exmem_rd != `r_zero && exmem_rd == idex_rs)
            forward_a = 2'b10; //forward from EX
        else if (memwb_regwrite && memwb_rd != `r_zero && exmem_rd != idex_rs && memwb_rd == idex_rs)
            forward_a = 2'b01; //forward from MEM
        else
            forward_a = 2'b00;
            
        if (exmem_regwrite && exmem_rd != `r_zero && exmem_rd == idex_rt)
            forward_b = 2'b10; //forward from EX  
        else if (memwb_regwrite && memwb_rd != `r_zero && exmem_rd != idex_rt && memwb_rd == idex_rt)
            forward_b = 2'b01; //forward from MEM
        else 
            forward_b = 2'b00;

        // if (idex_regwrite && idex_rt_rd != `r_zero && idex_rt_rd == id_rs)
        //     forward_c = 3'b000;
        // else if (idex_regwrite && idex_rt_rd != `r_zero && idex_rt_rd != id_rs && idex_rt_rd == id_rt)
        // else if (exmem_regwrite && exmem_rd != `r_zero && idex_rt_rd != id_rs && exmem_rd == idex_rs)
        //     forward_c = 3'b001; //forward from EX
        // else if (memwb_regwrite && memwb_rd != `r_zero && idex_rt_rd != id_rs && exmem_rd != idex_rs && memwb_rd == idex_rs)
        //     forward_c = 3'b010; //forward from MEM
        // else
        //     forward_a = 2'b00;
    end
endmodule

addi r2, r2, 1
addi r3, r3, 1
beq r2, r3, loop