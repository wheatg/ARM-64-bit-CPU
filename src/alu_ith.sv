`timescale 1ns/10ps
module alu_ith (A_ith, B_ith, c_in_ith, c_out_ith, cntrl, result_ith);
	input logic A_ith, B_ith, c_in_ith;
	input logic [2:0] cntrl;
	output logic result_ith, c_out_ith;
	
//	000:			result = B		
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B	
// 101:			result = bitwise A | B		
// 110:			result = bitwise A XOR B


	logic result_adder; //NOT DONE
	logic B_ith_not, B_ith_2_adder;
	
	not #0.05 (B_ith_not, B_ith);
	mux2_1 mux2 (.out(B_ith_2_adder), .i0(B_ith), .i1(B_ith_not), .sel(cntrl[0]));
	fullAdder adder (.a(A_ith), .b(B_ith_2_adder), .c_in(c_in_ith), .sum(result_adder), .c_out(c_out_ith));
	
	//logic result_sub; //NOT DONE (maybe c_in 1 for 0th alu)
	
	logic result_and;
	and #0.05 ga0 (result_and, A_ith, B_ith);
	
	logic result_or;
	or #0.05 go0 (result_or, A_ith, B_ith);
	
	logic result_xor;
	xor #0.05 gxo0 (result_xor, A_ith, B_ith);
	
	mux8_1 mux8 (.out(result_ith), .in_signal({1'b0,result_xor,result_or,result_and,result_adder,result_adder,1'b0,B_ith}), .selection(cntrl));

endmodule

module alu_ith_testbench();
	logic A_ith, B_ith, c_in_ith;
	logic [2:0] cntrl;
	logic result_ith, c_out_ith;
	alu_ith dut (.*);
	integer i;   
	initial begin
	A_ith = 1'b1; B_ith = 1'b0; c_in_ith = 1'b0;
	for(i=0; i<8; i++) begin
		cntrl = i; #10;
	end
	
	A_ith = 1'b1; B_ith = 1'b1; c_in_ith = 1'b0;
	for(i=0; i<8; i++) begin
		cntrl = i; #10;
	end
	
	A_ith = 1'b1; B_ith = 1'b1; c_in_ith = 1'b1;
	for(i=0; i<8; i++) begin
		cntrl = i; #10;
	end
	
	end
endmodule
