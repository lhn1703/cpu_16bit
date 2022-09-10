module hex_display (
    output [6:0] HEX0, HEX1, HEX2, HEX3,
    input [15:0] result_reg
    );

    hex_decoder u0 (HEX0, result_reg[3:0]);
    hex_decoder u1 (HEX1, result_reg[7:4]);
    hex_decoder u2 (HEX2, result_reg[11:8]);
    hex_decoder u3 (HEX3, result_reg[15:12]);

endmodule
