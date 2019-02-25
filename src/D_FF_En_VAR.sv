`timescale 1ns/10ps
module D_FF_En_VAR #(parameter WIDTH=64) (data_out, data_in, write_en, reset, clk);
	output logic [WIDTH-1:0] data_out;
	input logic [WIDTH-1:0] data_in;
	input logic write_en, reset, clk;
	
	initial assert(WIDTH>0);
	
	genvar i;
	generate
		for(i=0; i<WIDTH; i++) begin: eachDFF
			D_FF_En d_ff_en (.q(data_out[i]), .d(data_in[i]), .en(write_en), .reset, .clk);
		end
	endgenerate
endmodule

module D_FF_En_VAR_testbench();       
	logic [63:0] data_out, data_in;
	logic write_en, reset, clk; 
	
	D_FF_En_VAR #(64) dut (.data_out, .data_in, .write_en, .reset, .clk);     
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	initial begin
																	@(posedge clk);
	write_en <= 0; data_in <= 64'h00000000000000A0;	@(posedge clk);
																	@(posedge clk);
																	@(posedge clk);
						data_in <= 64'h0000000000000000;	@(posedge clk);
																	@(posedge clk);
																	@(posedge clk);
	write_en <= 1; data_in <= 64'h00000000000000A0;	@(posedge clk);
																	@(posedge clk);
																	@(posedge clk);
	write_en <= 0; data_in <= 64'h0000000000000000; @(posedge clk);
																	@(posedge clk);
	
	$stop;
	end
endmodule