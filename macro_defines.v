`ifndef _macro_defines_v
`define _macro_defines_v

// register names
`define r0 0
`define r1 1
`define r2 2
`define r3 3
`define r4 4
`define r5 5
`define r6 6
`define r7 7
`define r8 8
`define r9 9
`define r10 10
`define r11 11
`define r12 12
`define r_zero 13
`define sp 14
`define lr 15

//instruction names
`define add 4'd0
`define addi 4'd1
`define sub 4'd2
`define and 4'd3
`define or 4'd4
`define xor 4'd5
`define not 4'd6
`define slt 4'd7
`define lsl 4'd8
`define lsr 4'd9
`define ldr 4'd10
`define str 4'd11
`define b 4'd12
`define bl 4'd13
`define br 4'd14
`define beq 4'd15

//nop instruction: lsl r0, r0, 0
`define nop 16'd32768

//memory size of data and instruction memory = 2^16 - 1
//`define data_size 16'd65535
`define data_size 16'd1024

//`define sp_initial_address 16'd49152
`define sp_initial_address 16'd768

`endif //_macro_defines_v