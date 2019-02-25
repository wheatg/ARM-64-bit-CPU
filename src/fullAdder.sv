`timescale 1ns/10ps
module fullAdder (a, b, c_in, sum, c_out);
	input a, b, c_in;
	output sum, c_out;
	logic v0, v1, v2;
	
	//sum = c_in ^ (a ^ b);
	xor #0.05 gx0 (sum, c_in, a, b);
	
	//c_out = (a & b) | ((a ^ b) & c_in);
	and #0.05 ga1 (v0, a, b);
	and #0.05 ga2 (v1, a, c_in);
	and #0.05 ga3 (v2, b, c_in);
	or  #0.05 go4 (c_out, v0, v1, v2);
	
endmodule 

module fullAdder_testbench();     
	logic  a, b, c_in;
	logic sum, c_out;  
	fullAdder dut (.a, .b, .c_in, .sum, .c_out);     
	integer i;   
	initial begin 
	for(i=0; i<8; i++) begin 
	{a,b,c_in} = i; #10;  
	end    
	end    
endmodule
