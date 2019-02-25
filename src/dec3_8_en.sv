`timescale 1ns/10ps
module dec3_8_en (out, code, en);
	output logic [7:0] out;
	input logic [2:0] code;
	input en;
	
	logic v0, v1, v2;
	
	not #0.05 gn0 (v0, code[2]);
	and #0.05 ga0 (v1, v0, en);
	
	and #0.05 ga1 (v2, code[2], en);
	
	dec2_4_en dec1 (.out(out[3:0]), .code(code[1:0]), .en(v1));
	dec2_4_en dec2 (.out(out[7:4]), .code(code[1:0]), .en(v2));
	
endmodule

module dec3_8_en_testbench();
	logic [7:0] out;
	logic [2:0] code;
	logic en;
	dec3_8_en dut (.out, .code, .en);
	integer i;
	initial begin
	en = 0;
	for(i=0; i<8; i++) begin
	code = i; #10;
	end
	en = 1;
	for(i=0; i<8; i++) begin
	code = i; #10;
	end
	end
endmodule