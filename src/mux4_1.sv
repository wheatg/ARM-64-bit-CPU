`timescale 1ns/10ps
module mux4_1(out, in_signal, selection);    
	output logic out;  
	input  logic [3:0] in_signal;
	input logic [1:0] selection;     
	logic  v0, v1;     
	mux2_1 m0(.out(v0),  .i0(in_signal[0]), .i1(in_signal[1]), .sel(selection[0]));  
	mux2_1 m1(.out(v1),  .i0(in_signal[2]), .i1(in_signal[3]), .sel(selection[0]));  
	mux2_1 m (.out(out), .i0(v0),  .i1(v1),  .sel(selection[1]));  
endmodule
    
module mux4_1_testbench();     
	logic  [3:0] in_signal;
	logic [1:0] selection;
	logic  out;  
	mux4_1 dut (.out, .in_signal, .selection);     
	integer i;   
	initial begin 
	for(i=0; i<64; i++) begin 
	{selection[1:0], in_signal[3:0]} = i; #10;  
	end    
	end    
endmodule