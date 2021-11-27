# cpu_16bit
Custom CPU Architecture design inspired by MIPS and ARM
![alt text](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/cpu_architecture.jpeg)

# Registers and Memory
- 13 general purpose regisers r0 to r12
- r_zero: immutable register containing 16'b0
- sp: initialized to the data memory address that allocates the top quarter of data storage
- lr: updated when executing a bl instruction

# Instruction List 
- add 	rd, rs, rt
- addi	rd, rs, imm(4 bit)
- sub  	rd, rs, rt
-	and	  rd, rs, rt
-	or	  rd, rs, rt
-	xor 	rd, rs, rt
-	not	  rd, rs
-	slt	  rd, rs, rt             
-	lsl	  rd, rs, imm(4 bit)  
-	lsr	  rd, rs, imm(4 bit)
-	ldr	  rt, rs, offset
-	str	  rt, rs, offset 
-	b	    label(12 bit imm)
-	bl	  label(8 bit imm)  
-	br	  rs               
-	beq	  rt, rs, label(4 bit signed imm)

# Assembler instructions
- make a .txt assembly file with the instructions listed above and run the assembler.cpp file
- the assembler does not support comments 
- the assembler only parses decimal immediate values (can also parse negative sign)
- labels must be terminated with a semicolon (":")
- the beq can only branch to a label within 8 preceding instsructions or 7 following instructions 
- use auxiliary branches to implement further beq branches
