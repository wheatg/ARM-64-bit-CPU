`timescale 1ns/10ps
module mux2_1_VAR #(parameter WIDTH=64) (out, i0, i1, sel);
	output logic [WIDTH-1:0] out;
	input logic [WIDTH-1:0] i0, i1;
	input logic sel;
	
	initial assert(WIDTH>0);
	
	genvar i;
	generate
		for(i=0; i<WIDTH; i++) begin: eachmux2_1
			mux2_1 mux2_1 (.out(out[i]), .i0(i0[i]), .i1(i1[i]), .sel);
		end
	endgenerate
endmodule	

module mux2_1_VAR_testbench();     
	logic [63:0] out, i0, i1;  
	logic sel;   
	mux2_1_VAR #(64) dut (.out, .i0, .i1, .sel);   
	initial begin 
	sel=0; i0=64'h0; i1=64'h0; #10;  
	sel=0; i0=64'h0; i1=64'hf; #10;  
	sel=0; i0=64'hf; i1=64'h0; #10;  
	sel=0; i0=64'hf; i1=64'hf; #10;  
	sel=1; i0=64'h0; i1=64'h0; #10;  
	sel=1; i0=64'h0; i1=64'hf; #10;  
	sel=1; i0=64'hf; i1=64'h0; #10;  
	sel=1; i0=64'hf; i1=64'hf; #10;
	end    
endmodule 