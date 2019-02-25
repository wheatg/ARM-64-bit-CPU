// Test bench for pipeline_CPU
`timescale 1ns/10ps


module pipeline_CPU_stim();

	logic reset, clk;
	
	pipeline_CPU dut (reset, clk);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	initial begin
	integer i;
					@(posedge clk);
	reset <= 1; @(posedge clk);
	reset <= 0; @(posedge clk);
	for (i=0; i<1400; i=i+1) begin
		@(posedge clk);
	end
	$stop;
	end 
endmodule
	