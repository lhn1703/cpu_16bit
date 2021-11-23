# cpu_16bit
Custom CPU Architecture design inspired by MIPS and ARM
![alt text](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/CPU_Diagram.png)

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
