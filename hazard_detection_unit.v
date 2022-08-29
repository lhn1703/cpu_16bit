module hazard_detection_unit(
    output reg pc_write, ifid_write, controls_clear,
    input idex_memread, exmem_memread, id_br,
    input [3:0] idex_rt, ifid_rs, ifid_rt, exmem_rd
    );

    always @ (*) begin
        if (id_br && exmem_memread && (exmem_rd == ifid_rs)) begin
            pc_write = 1'b0; //add a bubble
            ifid_write = 1'b0;
            controls_clear = 1'b1;
        end else if (idex_memread && (idex_rt == ifid_rs || idex_rt == ifid_rt)) begin
            pc_write = 1'b0; //add a bubble
            ifid_write = 1'b0;
            controls_clear = 1'b1;
        end else begin
            pc_write = 1'b1; //normal operation
            ifid_write = 1'b1;
            controls_clear = 1'b0;
        end
            
    end

endmodule   
