// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

module cpu_16bit
(
// {ALTERA_ARGS_BEGIN} DO NOT REMOVE THIS LINE!

	clk,
	instruction_in,
	load_address,
	load_instruction,
	pc_reset,
	result_reg,
	ADC_CS_N,
	ADC_DIN,
	ADC_DOUT,
	ADC_SCLK,
	AUD_ADCDAT,
	AUD_ADCLRCK,
	AUD_BCLK,
	AUD_DACDAT,
	AUD_DACLRCK,
	AUD_XCK,
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,
	CLOCK4_50,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_LDQM,
	DRAM_RAS_N,
	DRAM_UDQM,
	DRAM_WE_N,
	FAN_CTRL,
	FPGA_I2C_SCLK,
	FPGA_I2C_SDAT,
	IRDA_RXD,
	IRDA_TXD,
	PS2_CLK,
	PS2_DAT,
	PS2_CLK2,
	PS2_DAT2,
	TD_CLK27,
	TD_HS,
	TD_RESET_N,
	TD_VS,
	USB_B2_CLK,
	USB_EMPTY,
	USB_FULL,
	USB_OE_N,
	USB_RD_N,
	USB_RESET_N,
	USB_SCL,
	USB_SDA,
	USB_WR_N,
	VGA_BLANK_N,
	VGA_CLK,
	VGA_HS,
	VGA_SYNC_N,
	VGA_VS,
	DRAM_ADDR,
	DRAM_BA,
	DRAM_DQ,
	GPIO_0,
	GPIO_1,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	KEY,
	LEDR,
	SW,
	TD_DATA,
	USB_B2_DATA,
	VGA_B,
	VGA_G,
	VGA_R
// {ALTERA_ARGS_END} DO NOT REMOVE THIS LINE!

);

// {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!
input			clk;
input	[15:0]	instruction_in;
input	[15:0]	load_address;
input			load_instruction;
input			pc_reset;
output	[15:0]	result_reg;
input			ADC_CS_N;
input			ADC_DIN;
input			ADC_DOUT;
input			ADC_SCLK;
input			AUD_ADCDAT;
input			AUD_ADCLRCK;
input			AUD_BCLK;
input			AUD_DACDAT;
input			AUD_DACLRCK;
input			AUD_XCK;
input			CLOCK_50;
input			CLOCK2_50;
input			CLOCK3_50;
input			CLOCK4_50;
input			DRAM_CAS_N;
input			DRAM_CKE;
input			DRAM_CLK;
input			DRAM_CS_N;
input			DRAM_LDQM;
input			DRAM_RAS_N;
input			DRAM_UDQM;
input			DRAM_WE_N;
input			FAN_CTRL;
input			FPGA_I2C_SCLK;
input			FPGA_I2C_SDAT;
input			IRDA_RXD;
input			IRDA_TXD;
input			PS2_CLK;
input			PS2_DAT;
input			PS2_CLK2;
input			PS2_DAT2;
input			TD_CLK27;
input			TD_HS;
input			TD_RESET_N;
input			TD_VS;
input			USB_B2_CLK;
input			USB_EMPTY;
input			USB_FULL;
input			USB_OE_N;
input			USB_RD_N;
input			USB_RESET_N;
input			USB_SCL;
input			USB_SDA;
input			USB_WR_N;
input			VGA_BLANK_N;
input			VGA_CLK;
input			VGA_HS;
input			VGA_SYNC_N;
input			VGA_VS;
input	[0:12]	DRAM_ADDR;
input	[0:1]	DRAM_BA;
input	[0:15]	DRAM_DQ;
input	[0:35]	GPIO_0;
input	[0:35]	GPIO_1;
input	[0:6]	HEX0;
input	[0:6]	HEX1;
input	[0:6]	HEX2;
input	[0:6]	HEX3;
input	[0:6]	HEX4;
input	[0:6]	HEX5;
input	[0:3]	KEY;
input	[0:9]	LEDR;
input	[0:9]	SW;
input	[0:7]	TD_DATA;
input	[0:7]	USB_B2_DATA;
input	[0:7]	VGA_B;
input	[0:7]	VGA_G;
input	[0:7]	VGA_R;

// {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_BEGIN} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_END} DO NOT REMOVE THIS LINE!
endmodule

