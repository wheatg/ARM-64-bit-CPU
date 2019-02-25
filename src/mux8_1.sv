`timescale 1ns/10ps
module mux8_1(out, in_signal, selection);    
	output logic out;  
	input  logic [7:0] in_signal;
	input logic [2:0] selection;     
	logic  v0, v1; 
	mux4_1 m0(.out(v0), .in_signal(in_signal[3:0]), .selection(selection[1:0]));
	mux4_1 m1(.out(v1), .in_signal(in_signal[7:4]), .selection(selection[1:0]));
	mux2_1 m2(.out(out), .i0(v0),  .i1(v1),  .sel(selection[2]));  
 
endmodule
    
module mux8_1_testbench();     
	logic  [7:0] in_signal;
	logic [2:0] selection;
	logic  out;  
	mux8_1 dut (.out, .in_signal, .selection);     
	integer i;   
	initial begin 
	for(i=0; i<2048; i++) begin 
	{selection[2:0], in_signal[7:0]} = i; #10;  
	end    
	end    
endmodule