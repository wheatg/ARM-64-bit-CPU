`timescale 1ns/10ps
module pipeline_ControlLogic (
	input logic [10:0] instruction31_21,
	input logic FLAG_negative, b_Zero_FW, FLAG_overflow,
	output logic Reg2Loc_ID, ADDI_Signal_ID, SetFlag_ID, ALUSrc_ID, MemWrite_ID, LSRtoReg_ID, MemtoReg_ID, RegWrite_ID, BrTaken_ID, CondBr_ID,
	output logic [2:0] ALUOp_ID);
	
	logic BLT_BrTaken;
	xor #0.05 gxor1 (BLT_BrTaken, FLAG_negative, FLAG_overflow);
	
	always_comb begin   
      casex(instruction31_21) 
			11'b11111000000: begin // STUR
									Reg2Loc_ID = 	   1'b1;
									ADDI_Signal_ID =  1'b0;
									SetFlag_ID = 	   1'b0;
									ALUSrc_ID = 	   1'b1;
									MemWrite_ID = 	   1'b1;
									LSRtoReg_ID = 	   1'b0;
									MemtoReg_ID =	   1'bx;
									RegWrite_ID = 	   1'b0;
									BrTaken_ID = 	   1'b0;
									CondBr_ID = 	   1'bx;
									ALUOp_ID =		   3'b010;
									end
									
			11'b11111000010: begin // LUDR
									Reg2Loc_ID = 		1'bx;
									ADDI_Signal_ID = 	1'b0;
									SetFlag_ID = 		1'b0;
									ALUSrc_ID =			1'b1;
									MemWrite_ID = 		1'b0;
									LSRtoReg_ID = 		1'b0;
									MemtoReg_ID = 		1'b1;
									RegWrite_ID = 		1'b1;
									BrTaken_ID = 		1'b0;
									CondBr_ID = 		1'bx;
									ALUOp_ID = 			3'b010;
									end
									
         11'b000101xxxxx: begin // B
									Reg2Loc_ID = 		1'bx;
									ADDI_Signal_ID = 	1'bx;
									SetFlag_ID = 		1'b0;
									ALUSrc_ID = 		1'bx;
									MemWrite_ID = 		1'b0;
									LSRtoReg_ID = 		1'bx;
									MemtoReg_ID =	 	1'bx;
									RegWrite_ID = 		1'b0;
									BrTaken_ID = 		1'b1;
									CondBr_ID = 		1'b0;
									ALUOp_ID = 			3'bxxx;
									end
									
			11'b01010100xxx: begin // B.LT
									Reg2Loc_ID = 		1'bx;
									ADDI_Signal_ID = 	1'bx;
									SetFlag_ID = 		1'b0;
									ALUSrc_ID = 		1'bx;
									MemWrite_ID = 		1'b0;
									LSRtoReg_ID = 		1'bx;
									MemtoReg_ID = 		1'bx;
									RegWrite_ID = 		1'b0;
									BrTaken_ID = 		BLT_BrTaken;
									CondBr_ID = 		1'b1;
									ALUOp_ID = 			3'bxxx;
									end
									
         11'b10110100xxx: begin // CBZ
									Reg2Loc_ID = 		1'b1;
									ADDI_Signal_ID = 	1'bx;
									SetFlag_ID = 		1'b1;
									ALUSrc_ID = 		1'b0;
									MemWrite_ID = 		1'b0;
									LSRtoReg_ID = 		1'bx;
									MemtoReg_ID = 		1'bx;
									RegWrite_ID = 		1'b0;
									BrTaken_ID = 		b_Zero_FW;
									CondBr_ID = 		1'b1;
									ALUOp_ID = 			3'b000;
									end
									 
         11'b10001010000: begin // AND
									Reg2Loc_ID = 		1'b0;
									ADDI_Signal_ID = 	1'bx;
									SetFlag_ID = 		1'b0;
									ALUSrc_ID = 		1'b0;
									MemWrite_ID = 		1'b0;
									LSRtoReg_ID = 		1'b0;
									MemtoReg_ID = 		1'b0;
									RegWrite_ID = 		1'b1;
									BrTaken_ID = 		1'b0;
									CondBr_ID = 		1'bx;
									ALUOp_ID = 			3'b100;
									end
									
         11'b10101011000: begin // ADDS
									Reg2Loc_ID = 		1'b0;
									ADDI_Signal_ID = 	1'bx;
									SetFlag_ID = 		1'b1;
									ALUSrc_ID = 		1'b0;
									MemWrite_ID = 		1'b0;
									LSRtoReg_ID = 		1'b0;
									MemtoReg_ID = 		1'b0;
									RegWrite_ID = 		1'b1;
									BrTaken_ID = 		1'b0;
									CondBr_ID = 		1'bx;
									ALUOp_ID = 			3'b010;
									end
									
         11'b11101011000: begin // SUBS
									Reg2Loc_ID = 		1'b0;
									ADDI_Signal_ID = 	1'bx;
									SetFlag_ID = 		1'b1;
									ALUSrc_ID = 		1'b0;
									MemWrite_ID = 		1'b0;
									LSRtoReg_ID = 		1'b0;
									MemtoReg_ID = 		1'b0;
									RegWrite_ID = 		1'b1;
									BrTaken_ID = 		1'b0;
									CondBr_ID = 		1'bx;
									ALUOp_ID = 			3'b011;
									end
									
         11'b11001010000: begin // EOR
									Reg2Loc_ID = 		1'b0;
									ADDI_Signal_ID = 	1'bx;
									SetFlag_ID = 		1'b0;
									ALUSrc_ID = 		1'b0;
									MemWrite_ID = 		1'b0;
									LSRtoReg_ID = 		1'b0;
									MemtoReg_ID = 		1'b0;
									RegWrite_ID = 		1'b1;
									BrTaken_ID = 		1'b0;
									CondBr_ID = 		1'bx;
									ALUOp_ID = 			3'b110;
									end
									 
         11'b11010011010: begin // LSR
									Reg2Loc_ID = 		1'bx;
									ADDI_Signal_ID = 	1'bx;
									SetFlag_ID = 		1'b0;
									ALUSrc_ID = 		1'bx;
									MemWrite_ID = 		1'b0;
									LSRtoReg_ID = 		1'b1;
									MemtoReg_ID = 		1'b0;
									RegWrite_ID = 		1'b1;
									BrTaken_ID = 		1'b0;
									CondBr_ID = 		1'bx;
									ALUOp_ID = 			3'bxxx;
									end
									
         11'b1001000100x: begin // ADDI
									Reg2Loc_ID = 		1'bx;
									ADDI_Signal_ID = 	1'b1;
									SetFlag_ID = 		1'b0;
									ALUSrc_ID = 		1'b1;
									MemWrite_ID = 		1'b0;
									LSRtoReg_ID = 		1'b0;
									MemtoReg_ID = 		1'b0;
									RegWrite_ID = 		1'b1;
									BrTaken_ID = 		1'b0;
									CondBr_ID = 		1'bx;
									ALUOp_ID = 			3'b010;
									end
									
         default: begin // default
									Reg2Loc_ID = 		1'b0;
									ADDI_Signal_ID = 	1'b0;
									SetFlag_ID = 		1'b0;
									ALUSrc_ID = 		1'b0;
									MemWrite_ID = 		1'b0;
									LSRtoReg_ID = 		1'b0;
									MemtoReg_ID = 		1'b0;
									RegWrite_ID = 		1'b0;
									BrTaken_ID = 		1'b0;
									CondBr_ID = 		1'b0;
									ALUOp_ID = 			3'b000;
									end   
      endcase   
   end   
endmodule 

//module singlecycle_ControlLogic_testbench();
//	logic [10:0] instruction31_21;
//	logic FLAG_negative, FLAG_zero, FLAG_overflow;
//	logic Reg2Loc, ADDI_Signal, SetFlag, ALUSrc, MemWrite, LSRtoReg, MemtoReg, RegWrite, BrTaken, CondBr;
//	logic [2:0] ALUOp;
//	
//	singlecycle_ControlLogic dut (.*);
//	integer i;
//		initial begin
//			//N/A Instruction
//			instruction31_21 = 11'b0; FLAG_negative=0; FLAG_zero=0; FLAG_overflow=0; #10;
//			//STUR
//			instruction31_21 = 11'b11111000000; FLAG_negative=0; FLAG_zero=0; FLAG_overflow=0; #10;
//			//ADDI
//			instruction31_21 = 11'b10010001000; FLAG_negative=0; FLAG_zero=0; FLAG_overflow=0; #10;
//			instruction31_21 = 11'b10010001001; FLAG_negative=0; FLAG_zero=0; FLAG_overflow=0; #10;
//			//CBZ
//			instruction31_21 = 11'b10110100001; FLAG_negative=0; FLAG_zero=0; FLAG_overflow=0; #10;
//			instruction31_21 = 11'b10110100001; FLAG_negative=0; FLAG_zero=1; FLAG_overflow=0; #10;
//			instruction31_21 = 11'b10110100xxx; FLAG_negative=0; FLAG_zero=1; FLAG_overflow=0; #10;
//           
//   end      
//endmodule	