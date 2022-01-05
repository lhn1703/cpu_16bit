# 16-Bit Verilog CPU - DE1-SoC Pipelined Branch
Custom CPU Architecture design inspired by MIPS and ARM
![](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/pipelined_CPU.png)

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

# Pipelining Registers
- between instruction fetch and instruction decode
- between instruction decode and execute
- between execute and memory
- between memory and write back

# Forwarding Unit
- able to forward data from a previous execute or write back stage in the pipeline directly to the ALU in the current execute stage
- combinational logic to check for appropriate forwarding

# Hazard Dectection Unit
- detects and corrects load-use hazards
- if an instruction immediately following a load requires the load data, this unit will delay that following instruction by 1 cycle
- it also clears the control bits of the erroneous instruction in the ID/EX pipeline stage to nullify it

# Pipeline Flusher
- whenever a branch is detected, insert 2 NOPs before the next instruction to flush the pipeline
- this is done by pausing the pc increment and inserting NOP to the IF/ID pipeline registers for 2 cycles
- control hazards: assume branch not taken, contains combinational logic to check for conditional beq branching by comparing rs and rt in the ID stage
- will also forward the ALU result back to perform the correct comparison if rs or rt in beq instruction is being modified by a previous instruction

# Datapaths (Not Updated Yet)
- R-type Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/r-type.png)
- I-type Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/i-type.png)
- LDR Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/ldr.png)
- STR Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/str.png)
- Branch Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/branch.png)
- Branch and Link Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/bl.png)
- Branch Return Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/br.png)
- Branch if Equal Instruction
![](https://github.com/lhn1703/cpu_16bit/blob/main/documentation/beq.png)
