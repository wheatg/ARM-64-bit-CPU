`timescale 1ns/10ps
module IF_ID_Reg (
	input logic reset, clk,
	input logic [31:0] instruction_in,
	input logic [63:0] pc_in,
	output logic [31:0] instruction_out,
	output logic [63:0] pc_out
	);
	
	D_FF_En_VAR #(32) instruction_DFF (.data_out(instruction_out), 
												  .data_in(instruction_in), 
												  .write_en(1'b1),
												  .reset, 
												  .clk);	
												  
	D_FF_En_VAR #(64) pc_DFF (.data_out(pc_out), 
												  .data_in(pc_in), 
												  .write_en(1'b1),
												  .reset, 
												  .clk);	
			
			
endmodule
	
