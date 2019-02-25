`timescale 1ns/10ps
module EX_MEM_Reg (
	
	input logic reset, clk,
	
	input logic [63:0] ALU_LSR_result_in, Db_in,
	input logic [2:0] control_in,
	input logic [4:0] Rd_in,
	
	
	output logic [63:0] ALU_LSR_result_out, Db_out,
	output logic [2:0] control_out,
	output logic [4:0] Rd_out
	
	);
	
	//Data
	
	D_FF_En_VAR #(64) ALU_LSR_result_DFF (.data_out(ALU_LSR_result_out), .data_in(ALU_LSR_result_in), .write_en(1'b1), .reset, .clk);
	D_FF_En_VAR #(64) Db_DFF (.data_out(Db_out), .data_in(Db_in), .write_en(1'b1), .reset, .clk);
	D_FF_En_VAR #(5)  Rd_DFF (.data_out(Rd_out), .data_in(Rd_in), .write_en(1'b1), .reset, .clk);
	
	//Control
	
	D_FF_En_VAR #(3) control_DFF (.data_out(control_out), .data_in(control_in), .write_en(1'b1), .reset, .clk);
	//{MemWrite, MemtoReg, RegWrite}

endmodule
