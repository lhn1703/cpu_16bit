module bin16_to_bcd(output negative, output [3:0] digit [0:4], input [15:0] bin);
    wire [3:0], x0, x1, x2, x3;
    wire [3:0] s0, s1, s2, s3, s4;
    wire [4:0] c;
    reg carry10, carry100, carry1000, carry10000;
    assign {x3, x2, x1, x0} = bin;
    //make sure the output negative is 1 if input is negative and vice versa

    cla_4(output c_out, output [3:0] s, input c_in, input [3:0] a, b);
    
    cla_4 u0 (c[0], s0, x0, 4'd6);
    cla_4 u1 (c1, s1, );
    cla_4 u2 ();
    cla_4 u3 ();
    cla_4 u4 ();

    digit[0] = (x0 < 4'd10) ? x0:s0;

    always @ (*) begin

        case(x0)
            10: begin 
                carry10 = 1;
                digit[0] = 0;
            end
            11: begin 
                excess1 = 1;
                digit[0] = 1;
            end
            12: begin 
                excess1 = 1;
                digit[0] = 2;
            end
            13: begin 
                excess1 = 1;
                digit[0] = 3;
            end
            14: begin 
                excess1 = 1;
                digit[0] = 4;
            end
            15: begin 
                excess1 = 1;
                digit[0] = 5;
            end
        endcase
    end
endmodule
