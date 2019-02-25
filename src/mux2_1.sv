`timescale 1ns/10ps
module mux2_1(out, i0, i1, sel);     
	output logic out;  
	input  logic i0, i1, sel;      
	//assign out = (i1 & sel) | (i0 & ~sel);
	
	logic v1, v2, nsel;
	
	and #0.05 ga1 (v1, i1, sel);
	not #0.05 gn1 (nsel, sel);
	and #0.05 ga2 (v2, i0, nsel);
	or	 #0.05 g01 (out, v1, v2);
	
endmodule    
module mux2_1_testbench();     
	logic i0, i1, sel;  
	logic out;   
	mux2_1 dut (.out, .i0, .i1, .sel);   
	initial begin 
	sel=0; i0=0; i1=0; #10;  
	sel=0; i0=0; i1=1; #10;  
	sel=0; i0=1; i1=0; #10;  
	sel=0; i0=1; i1=1; #10;  
	sel=1; i0=0; i1=0; #10;  
	sel=1; i0=0; i1=1; #10;  
	sel=1; i0=1; i1=0; #10;  
	sel=1; i0=1; i1=1; #10;  
	end    
endmodule 