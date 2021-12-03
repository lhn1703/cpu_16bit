# 16-Bit Verilog CPU - DE1-SoC Synthesis Branch
Custom CPU Architecture design inspired by MIPS and ARM
![](https://github.com/lhn1703/cpu_16bit/blob/fpga-de1/documentation/CPU.png)

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

# Assembly Instructions
- make a .txt assembly file with the instructions listed above and run the assembler.cpp file
- the assembler does not support comments 
- the assembler only parses decimal immediate values (can also parse negative sign)
- labels must be terminated with a semicolon (":")
- the beq can only branch to a label within 8 preceding instsructions or 7 following instructions 
- use auxiliary branches to implement further beq branches

# Datapaths
- R-type Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/fpga-de1/documentation/r-type.png)
- I-type Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/fpga-de1/documentation/i-type.png)
- LDR Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/fpga-de1/documentation/ldr.png)
- STR Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/fpga-de1/documentation/str.png)
- Branch Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/fpga-de1/documentation/branch.png)
- Branch and Link Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/fpga-de1/documentation/bl.png)
- Branch Return Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/fpga-de1/documentation/br.png)
- Branch if Equal Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/fpga-de1/documentation/beq.png)
