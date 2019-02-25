`timescale 1ns/10ps
module dec2_4_en (out, code, en);
	output logic [3:0] out;
	input logic [1:0] code;
	input logic en;
	logic v0, nv0;
	logic v1,v2;
	
	//assign out[0] = ~(code[1] | code[0]);
	or #0.05 go0 (v0, code[1], code[0]);
	not #0.05 gn0 (nv0, v0);
	and #0.05 ga0 (out[0], nv0, en);
	
	//assign out[1] = ~code[1] & code[0];
	not #0.05 gn1 (v1, code[1]);
	and #0.05 ga1 (out[1], v1, code[0], en);
	
	//assign out[2] = code[1] & ~code[0];
	not #0.05 gn2 (v2, code[0]);
	and #0.05 ga2 (out[2], code[1], v2, en);
	
	//assign out[3] = code[1] & code[0];
	and #0.05 ga3 (out[3], code[1], code[0], en);
	
endmodule

module dec2_4_en_testbench();
	logic [3:0] out;
	logic [1:0] code;
	logic en;
	dec2_4_en dut (.out, .code, .en);
	integer i;
	initial begin
	en = 0;
	for(i=0; i<4; i++) begin
	code = i; #10;
	end
	en = 1;
	for(i=0; i<4; i++) begin
	code = i; #10;
	end
	end
endmodule
	