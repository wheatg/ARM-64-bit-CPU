`timescale 1ns/10ps

module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	input logic		[63:0]	A, B;
	input  logic		[2:0]		cntrl;
	output logic		[63:0]	result;
	output  logic					negative, zero, overflow, carry_out;
	
// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

	logic [63:0] c_connections;
	logic [63:0] alu_result;
	
	alu_ith alu_0th(.A_ith(A[0]), .B_ith(B[0]), .c_in_ith(cntrl[0]), .c_out_ith(c_connections[0]), .cntrl, .result_ith(alu_result[0]));
	genvar i;
		generate
			for(i=1; i<64; i++) begin: each_alu_ith
				alu_ith eachalu_ith (.A_ith(A[i]), .B_ith(B[i]), .c_in_ith(c_connections[i-1]), .c_out_ith(c_connections[i]), .cntrl, .result_ith(alu_result[i]));
		end
	endgenerate
	
	assign result = alu_result;
	assign carry_out = c_connections[63];
	assign negative = alu_result[63];
	xor #0.05 gxo1 (overflow, c_connections[63], c_connections[62]);
	nor_64bit zeroflag (.in(alu_result), .out(zero));
	
endmodule
