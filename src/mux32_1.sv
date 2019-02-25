`timescale 1ns/10ps
module mux32_1(out, in_signal, selection);    
	output logic out;  
	input  logic [31:0] in_signal;
	input logic [4:0] selection;
	logic  v0, v1;   
	mux16_1 m0 (.out(v0), .in_signal(in_signal[15:0]), .selection(selection[3:0]));  
	mux16_1 m1 (.out(v1), .in_signal(in_signal[31:16]), .selection(selection[3:0]));  
	mux2_1 m   (.out(out), .i0(v0), .i1(v1), .sel(selection[4]));
endmodule

module mux32_1_testbench();     
	logic out;  
	logic [31:0] in_signal;
	logic [4:0] selection;  
	
	mux32_1 dut (.out, .in_signal, .selection);     
	
	
	integer i;   
	initial begin 
	
	end    
endmodule
