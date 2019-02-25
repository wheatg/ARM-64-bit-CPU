`timescale 1ns/10ps
module regfile (ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, RegWrite, clk);

	input logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0]	WriteData;
	input logic 			RegWrite, clk;
	output logic [63:0]	ReadData1, ReadData2;
	logic [31:0]			Enable_for_DFF;
	logic [31:0][63:0]	reg_values; 
	
	dec5_32_en decoder (.out(Enable_for_DFF), .code(WriteRegister), .en(RegWrite));
	
	genvar i;
	generate 
		for(i=0; i<31; i++) begin: eachreg
			D_FF_En_VAR #(64) dffreg (.data_out(reg_values[i]), .data_in(WriteData), .write_en(Enable_for_DFF[i]), .reset(1'b0), .clk);
		end
	endgenerate
	
	assign reg_values[31] = 64'h0000000000000000;
	
	mux32x64_64 reader1 (.data_out(ReadData1), .reg_values, .reg_read(ReadRegister1));
	mux32x64_64 reader2 (.data_out(ReadData2), .reg_values, .reg_read(ReadRegister2));
	

endmodule
