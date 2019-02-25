`timescale 1ns/10ps
module dec5_32_en (out, code, en);
	output logic [31:0] out;
	input logic [4:0] code;
	input logic en;
	
	logic [3:0] v_en;
	
	dec2_4_en dec_en (.out(v_en), .code(code[4:3]), .en);
	
	dec3_8_en dec1 (.out(out[7:0]), .code(code[2:0]), .en(v_en[0]));
	dec3_8_en dec2 (.out(out[15:8]), .code(code[2:0]), .en(v_en[1]));
	dec3_8_en dec3 (.out(out[23:16]), .code(code[2:0]), .en(v_en[2]));
	dec3_8_en dec4 (.out(out[31:24]), .code(code[2:0]), .en(v_en[3]));
	
endmodule

module dec5_32_en_testbench();
	logic [31:0] out;
	logic [4:0] code;
	logic en;
	
	dec5_32_en dut (.out, .code, .en);
	integer i;
	initial begin
	en = 0;
	for(i=0; i<32; i++) begin
	code = i; #10;
	end
	en = 1;
	for(i=0; i<32; i++) begin
	code = i; #10;
	end
	end
endmodule
