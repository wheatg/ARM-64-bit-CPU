`timescale 1ns/10ps
module pipeline_ForwardLogic (
	input logic [4:0] readReg_ID, writeReg_EX, writeReg_MEM,
	input logic RegWrite_EX, RegWrite_MEM,
	output logic forwardEX, forwardMEM);
	
	always_comb begin
		casex({readReg_ID,RegWrite_EX,RegWrite_MEM})
			{5'd31, 2'bxx}:				begin
												forwardEX = 1'b0;
												forwardMEM = 1'b0;
												end
								
			{writeReg_EX,1'b1,1'bx}:	begin
												forwardEX = 1'b1;
												forwardMEM = 1'b0;
												end
								
							 
			{writeReg_MEM,1'bx,1'b1}:  begin
												forwardEX = 1'b0;
												forwardMEM = 1'b1;
												end
			
								
			default: 						begin
												forwardEX = 1'b0;
												forwardMEM = 1'b0;
												end
		endcase
	end
endmodule

module pipeline_ForwardLogic_testbench();
	logic [4:0] readReg_ID, writeReg_EX, writeReg_MEM;
	logic RegWrite_EX, RegWrite_MEM, forwardEX, forwardMEM;
	
	pipeline_ForwardLogic dut (.readReg_ID, .writeReg_EX, .writeReg_MEM, .RegWrite_EX, .RegWrite_MEM, .forwardEX, .forwardMEM);
	initial begin 
	//Should forward nothing
	readReg_ID = 5'd0; writeReg_EX = 5'd10; writeReg_MEM = 5'd20; RegWrite_EX = 1'b1; RegWrite_MEM = 1'b1;	#10;
	//Forwarding from EX
	readReg_ID = 5'd10;															#10;
	//Forwarding from MEM
	readReg_ID = 5'd0;								writeReg_MEM = 5'd0;	#10;
	//EX to forward first
	readReg_ID = 5'd5; writeReg_EX = 5'd5; writeReg_MEM = 5'd5;		#10;
	end
endmodule
	