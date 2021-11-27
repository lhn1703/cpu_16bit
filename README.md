# cpu_16bit
Custom CPU Architecture design inspired by MIPS and ARM
![alt text](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/cpu_architecture.jpeg)

# Registers and Memory
- 13 general purpose regisers r0 to r12
- r_zero: immutable register containing 16'b0
- sp: initialized to the address of the highest 3/4ths of the data memory, incremented by 1
- lr: updated when executing a bl instruction

# Instruction List 
- add 	rd, rs, rt
- addi	rd, rs, imm(4 bit)
- sub  	rd, rs, rt
-	and	  rd, rs, rt
-	or	  rd, rs, rt
-	xor 	rd, rs, rt
-	not	  rd, rs
-	slt	  rd, rs, rt           \t           //set if less than
-	lsl	  rd, rs, imm(4 bit)     \t         //logical shift left
-	lsr	  rd, rs, imm(4 bit)       \t       //logical shift right
-	ldr	  rt, rs, offset             \t     //load halfword
-	str	  rt, rs, offset                  //store halfword
-	b	    label(12 bit imm)               //branch
-	bl	  label(8 bit imm)                //branch and link
-	br	  rs                              //branch return to rs, usually to lr
-	beq	  rt, rs, label(4 bit signed imm) //branch on equal
