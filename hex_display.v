module hex_display (
    output [6:0] HEX0, HEX1, HEX2, HEX3,
    input [3:0] digit0, digit1, digit2, digit3
    );

    assign Hex5 = (negative) ? 7'h7E:7'hFF;
    hex_decoder u0 (HEX0, digit0);
    hex_decoder u1 (HEX1, digit1);
    hex_decoder u2 (HEX2, digit2);
    hex_decoder u3 (HEX3, digit3);
    
endmodule
