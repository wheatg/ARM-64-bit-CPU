`timescale 1ns/10ps
module ID_EX_Reg (
	input logic reset, clk,
	
	input logic [63:0] Da_in, Db_in,
	input logic [9:0] control_in,
	input logic [4:0] Rd_in,
	input logic [8:0] Imm9_in,
	input logic [11:0] Imm12_in,
	input logic [5:0] shamt_in,
	
	output logic [63:0] Da_out, Db_out,
	output logic [9:0] control_out,
	output logic [4:0] Rd_out,
	output logic [8:0] Imm9_out,
	output logic [11:0] Imm12_out,
	output logic [5:0] shamt_out
	
	);
	
	//Data
	
	D_FF_En_VAR #(64) Da_DFF (.data_out(Da_out), .data_in(Da_in), .write_en(1'b1), .reset, .clk);
	D_FF_En_VAR #(64) Db_DFF (.data_out(Db_out), .data_in(Db_in), .write_en(1'b1), .reset, .clk);
	D_FF_En_VAR #(5) 	Rd_DFF (.data_out(Rd_out), .data_in(Rd_in), .write_en(1'b1), .reset, .clk);
	D_FF_En_VAR #(9) 	Imm9_DFF (.data_out(Imm9_out), .data_in(Imm9_in), .write_en(1'b1), .reset, .clk);
	D_FF_En_VAR #(12) Imm12_DFF (.data_out(Imm12_out), .data_in(Imm12_in), .write_en(1'b1), .reset, .clk);
	D_FF_En_VAR #(6) 	shamt_DFF (.data_out(shamt_out), .data_in(shamt_in), .write_en(1'b1), .reset, .clk);

	//Control
	
	D_FF_En_VAR #(10) control_DFF (.data_out(control_out), .data_in(control_in), .write_en(1'b1), .reset, .clk);
	//{ALU[2:0], ALUSrc, ADDI_signal, SetFlag, MemWrite, MemtoReg, LSRtoReg, RegWrite}
	
endmodule
