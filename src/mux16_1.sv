`timescale 1ns/10ps
module mux16_1(out, in_signal, selection);    
	output logic out;  
	input  logic [15:0] in_signal;
	input logic [3:0] selection;
	logic  v00, v01, v10, v11;  
   
	mux4_1 m00 (.out(v00), .in_signal(in_signal[3:0]), .selection(selection[1:0]));
	mux4_1 m01 (.out(v01), .in_signal(in_signal[7:4]), .selection(selection[1:0]));
	mux4_1 m10 (.out(v10), .in_signal(in_signal[11:8]), .selection(selection[1:0]));
	mux4_1 m11 (.out(v11), .in_signal(in_signal[15:12]), .selection(selection[1:0]));
	
	mux4_1 m   (.out(out), .in_signal({v11,v10,v01,v00}), .selection(selection[3:2]));
endmodule

module mux16_1_testbench();     
	logic out;  
	logic [15:0] in_signal;
	logic [3:0] selection;  
	
	mux16_1 dut (.out, .in_signal, .selection);     
	integer i;   
	initial begin 
	for(i=0; i<1048576; i++) begin 
	{selection[3:0], in_signal[15:0]} = i; #10;  
	end 
	  
	end    
endmodule