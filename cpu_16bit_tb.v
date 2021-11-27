
module cpu_16bit_tb();
	reg [15:0] instruction_in, load_address = 0;
	reg load_instruction = 0, pc_reset = 1, clk = 0;
	always clk = #5 ~clk;
	
	cpu_16bit u_cpu(instruction_in, load_address, load_instruction, clk, pc_reset);

	integer file;
	integer i = 0;
	
	initial begin
		load_instruction = 1;
		file = $fopen("assembler/output.txt", "r");
		while(!$feof(file)) begin
			$fscanf(file, "%b\n", instruction_in);
			#10;
			load_address = load_address + 1;
		end
		$fclose(file);
		
		load_instruction = 0;
		pc_reset = 0;
	end
endmodule
