module hazard_detection_unit(
    output reg pc_write, ifid_write, controls_clear,
    input idex_memread,
    input [3:0] idex_rt, ifid_rs, ifid_rt
    );

    always @ (*) begin
        if (idex_memread && (idex_rt == ifid_rs || idex_rt == ifid_rt)) begin
            pc_write = 0; //add a bubble
            ifid_write = 0;
            controls_clear = 1;
        end else begin
            pc_write = 1; //normal operation
            ifid_write = 1;
            controls_clear = 0;
        end
            
    end

endmodule   
