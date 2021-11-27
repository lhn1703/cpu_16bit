# cpu_16bit
Custom CPU Architecture design inspired by MIPS and ARM
![alt text](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/cpu_architecture.jpeg)

# Registers and Memory
- 13 general purpose regisers r0 to r12
- r_zero: immutable register containing 16'b0
- sp: initialized to the address of the highest 3/4ths of the data memory
- lr: updated when executing a bl instruction

# Instruction List 
- add 	rd, rs, rt
- addi	rd, rs, imm(4 bit)
- sub  	rd, rs, rt
-	and	  rd, rs, rt
-	or	  rd, rs, rt
-	xor 	rd, rs, rt
-	not	  rd, rs
-	slt	  rd, rs, rt //set if less than
-	lsl	  rd, rs, imm(4 bit)
-	lsr	  rd, rs, imm(4 bit)
-	ldr	  rt, rs, offset
-	str	  rt, rs, offset
-	b	    label(12 bit imm)
-	bl	  label(8 bit imm)
-	br	  rs
-	beq	  rt, rs, label(4 bit signed imm)
