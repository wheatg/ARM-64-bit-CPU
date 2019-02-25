`timescale 1ns/10ps
module MEM_WB_Reg (
	
	input logic reset, clk,
	
	input logic [4:0]	 Rd_in,
	input logic [63:0] Dw_in,
	input logic control_in,
	
	output logic [4:0]  Rd_out,
	output logic [63:0] Dw_out,
	output logic control_out

	);
	
	//Data
	
	D_FF_En_VAR #(5)  Rd_DFF (.data_out(Rd_out), .data_in(Rd_in), .write_en(1'b1), .reset, .clk);
	D_FF_En_VAR #(64) Dw_DFF (.data_out(Dw_out), .data_in(Dw_in), .write_en(1'b1), .reset, .clk);
	
	//Control
	D_FF control_DFF (.q(control_out), .d(control_in), .reset, .clk);
	//{RegWrite}
	
	
endmodule
