module bcd_to_7seg (
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
    input negative,
    input [3:0] bcd_digit0, bcd_digit1, bcd_digit2, bcd_digit3, bcd_digit4
    );

    assign Hex5 = (negative) ? 7'h7E:7'hFF;
    bcd_to_hex u0 (HEX0, bcd_digit0);
    bcd_to_hex u1 (HEX1, bcd_digit1);
    bcd_to_hex u2 (HEX2, bcd_digit2);
    bcd_to_hex u3 (HEX3, bcd_digit3);
    bcd_to_hex u4 (HEX4, bcd_digit4);

endmodule
