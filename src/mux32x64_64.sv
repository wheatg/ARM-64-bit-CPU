`timescale 1ns/10ps
module mux32x64_64 (data_out, reg_values, reg_read);

	output logic [63:0] data_out;
	input logic [31:0][63:0] reg_values;
	input logic [4:0] reg_read;
	
	genvar i;
	generate
		for(i=0; i<64; i++) begin: eachmux32_1
			mux32_1 eachmux (
			.out(data_out[i]), 
			.in_signal({reg_values[31][i], reg_values[30][i], reg_values[29][i], reg_values[28][i], 
							reg_values[27][i], reg_values[26][i], reg_values[25][i], reg_values[24][i], 
							reg_values[23][i], reg_values[22][i], reg_values[21][i], reg_values[20][i], 
							reg_values[19][i], reg_values[18][i], reg_values[17][i], reg_values[16][i], 
							reg_values[15][i], reg_values[14][i], reg_values[13][i], reg_values[12][i], 
							reg_values[11][i], reg_values[10][i], reg_values[9][i], reg_values[8][i],
							reg_values[7][i], reg_values[6][i], reg_values[5][i], reg_values[4][i],
							reg_values[3][i], reg_values[2][i], reg_values[1][i], reg_values[0][i]}),
			.selection(reg_read));
		end
	endgenerate
endmodule

module mux32x64_64_testbench();       
	logic [63:0] data_out;
	logic [31:0][63:0] reg_values;
	logic [4:0] reg_read;  
	
	mux32x64_64 dut (.data_out, .reg_values, .reg_read);
	integer k;   
	initial begin
	for(k=0; k<32; k++) begin
		reg_values[k] = 64'h0000000000000000;
	end
	reg_read=5'b00000; #10;
	reg_values[0] = 64'h00000000000000A0; reg_values[3] = 64'h000000000000000F; #10;
	for(k=0; k<32; k++) begin
	reg_read=k; #10;
	end
	
	end   
endmodule
