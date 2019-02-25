`timescale 1ns/10ps
module D_FF_En (q, d, en, reset, clk);
	output logic q;
	input logic d, en, reset, clk;
	logic mux_2_dff;
	
	mux2_1 mux_en (.out(mux_2_dff), .i0(q), .i1(d), .sel(en));
	D_FF dff_en (.q, .d(mux_2_dff), .reset, .clk);
	
endmodule

module D_FF_En_testbench();       
	logic q, d, en, reset, clk; 
	
	D_FF_En dut (.q, .d, .en, .reset, .clk);     
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	initial begin
								  @(posedge clk);
	d<=0; en<=0; reset<=1; @(posedge clk);
					 reset<=0; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	d<=1; en<=0; reset<=0; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	d<=0; en<=0; reset<=0; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	d<=1; en<=1; reset<=0; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	d<=0; en<=1; reset<=0; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	d<=1; en<=0; reset<=0; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	d<=1; en<=1; reset<=0; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	d<=0; en<=0; reset<=0; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop;
	end
endmodule
	
								  