`timescale 1ns/10ps
module nor_64bit (in, out);
	input logic [63:0] in;
	output logic out;
	
	logic [15:0] nor_lvl0_out;
	logic [3:0]  nor_lvl1_out;
	
	//lvl0
	nor #0.05 l00 (nor_lvl0_out[0], in[0], in[0+1], in[0+2], in[0+3]);
	nor #0.05 l01 (nor_lvl0_out[1], in[4], in[4+1], in[4+2], in[4+3]);
	nor #0.05 l02 (nor_lvl0_out[2], in[8], in[8+1], in[8+2], in[8+3]);
	nor #0.05 l03 (nor_lvl0_out[3], in[12], in[12+1], in[12+2], in[12+3]);
	nor #0.05 l04 (nor_lvl0_out[4], in[16], in[16+1], in[16+2], in[16+3]);
	nor #0.05 l05 (nor_lvl0_out[5], in[20], in[20+1], in[20+2], in[20+3]);
	nor #0.05 l06 (nor_lvl0_out[6], in[24], in[24+1], in[24+2], in[24+3]);
	nor #0.05 l07 (nor_lvl0_out[7], in[28], in[28+1], in[28+2], in[28+3]);
	nor #0.05 l08 (nor_lvl0_out[8], in[32], in[32+1], in[32+2], in[32+3]);
	nor #0.05 l09 (nor_lvl0_out[9], in[36], in[36+1], in[36+2], in[36+3]);
	nor #0.05 l010 (nor_lvl0_out[10], in[40], in[40+1], in[40+2], in[40+3]);
	nor #0.05 l011 (nor_lvl0_out[11], in[44], in[44+1], in[44+2], in[44+3]);
	nor #0.05 l012 (nor_lvl0_out[12], in[48], in[48+1], in[48+2], in[48+3]);
	nor #0.05 l013 (nor_lvl0_out[13], in[52], in[52+1], in[52+2], in[52+3]);
	nor #0.05 l014 (nor_lvl0_out[14], in[56], in[56+1], in[56+2], in[56+3]);
	nor #0.05 l015 (nor_lvl0_out[15], in[60], in[60+1], in[60+2], in[60+3]);
	
	//lvl1
	and #0.05 l10(nor_lvl1_out[0], nor_lvl0_out[0], nor_lvl0_out[0+1], nor_lvl0_out[0+2], nor_lvl0_out[0+3]);
	and #0.05 l11(nor_lvl1_out[1], nor_lvl0_out[4], nor_lvl0_out[4+1], nor_lvl0_out[4+2], nor_lvl0_out[4+3]);
	and #0.05 l12(nor_lvl1_out[2], nor_lvl0_out[8], nor_lvl0_out[8+1], nor_lvl0_out[8+2], nor_lvl0_out[8+3]);
	and #0.05 l13(nor_lvl1_out[3], nor_lvl0_out[12], nor_lvl0_out[12+1], nor_lvl0_out[12+2], nor_lvl0_out[12+3]);
	
	//lvl2
	and #0.05 l20(out, nor_lvl1_out[0],nor_lvl1_out[1],nor_lvl1_out[2],nor_lvl1_out[3]); 
	
endmodule

`timescale 1ns/10ps
module nor_64bit_testbench();
	logic [63:0] in;
	logic out;
	nor_64bit dut (.in, .out);
	integer i;   
	initial begin 
	in=64'h0000000000000000; #10;
	in=64'h000000000000000f; #10;
	in=64'hf000000000000000; #10;
	in=64'hfffffffffffffff0; #10;
	in=64'h1111111111111111; #10;    
	end    
endmodule
