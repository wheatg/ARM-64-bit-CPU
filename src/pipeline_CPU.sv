`timescale 1ns/10ps
module pipeline_CPU (reset, clk);
	input logic reset, clk;
	
	//Instruction Memory
	logic [63:0] PC, computedPC, PC_ID;
	logic [31:0] instruction_IF;
	instructmem instructmem(.address(PC),
									.instruction(instruction_IF),
									.clk);
									
	/* IF_ID_Reg */
	logic [31:0] instruction_ID;
	IF_ID_Reg IF_ID (.reset, .clk, 
						  .instruction_in(instruction_IF), 
						  .pc_in(PC),
						  .instruction_out(instruction_ID),
						  .pc_out(PC_ID));
	
	//Decoding Instruction
	logic [4:0] Rd_ID, Rm_ID, Rn_ID;
	logic [8:0] Imm9_ID;
	logic [11:0] Imm12_ID;
	logic [18:0] Imm19_ID;
	logic [25:0] Imm26_ID;
	logic [5:0] shamt_ID;
	assign Rd_ID = instruction_ID[4:0];
	assign Rm_ID = instruction_ID[20:16];
	assign Rn_ID = instruction_ID[9:5];
	assign Imm9_ID = instruction_ID[20:12];
	assign Imm12_ID = instruction_ID[21:10];
	assign Imm19_ID = instruction_ID[23:5];
	assign Imm26_ID = instruction_ID[25:0];
	assign shamt_ID = instruction_ID[15:10];
	
	//Control Signals For ID Stage
	logic Reg2Loc_ID, ADDI_Signal_ID, SetFlag_ID, ALUSrc_ID, MemWrite_ID, LSRtoReg_ID, MemtoReg_ID, RegWrite_ID, BrTaken_ID, CondBr_ID;
	logic [2:0] ALUOp_ID;
	
	
	
	//RegFile
	logic [4:0] Reg_Ab;
	logic [63:0] Reg_Da, Reg_Db, Reg_Dw;
	
	mux2_1_VAR #(64) reg_mux(.out(Reg_Ab), .i0(Rm_ID), .i1(Rd_ID), .sel(Reg2Loc_ID));
	
	//Control Logic for WB
	logic RegWrite_WB; /* See MEM_WB_Reg */
	//Data for WB
	logic [63:0] Dw_MEM, Dw_WB;
	logic [4:0] Rd_WB;
	

	regfile regfile(.ReadData1(Reg_Da), 
						 .ReadData2(Reg_Db), 
						 .WriteData(Dw_WB),
						 .ReadRegister1(Rn_ID), 
						 .ReadRegister2(Reg_Ab), 
						 .WriteRegister(Rd_WB), 
						 .RegWrite(RegWrite_WB), 
						 .clk(~clk)); /* Invert Clk for forwarding */
	
	/* Forwarding Logic */
	logic [4:0] Rd_EX, Rd_MEM;
	logic RegWrite_EX, RegWrite_MEM;
	logic forwardEX_A, forwardMEM_A, forwardEX_B, forwardMEM_B;
	pipeline_ForwardLogic forwardlogic_A (.readReg_ID(Rn_ID), 
													  .writeReg_EX(Rd_EX), 
													  .writeReg_MEM(Rd_MEM),
													  .RegWrite_EX,
													  .RegWrite_MEM,
													  .forwardEX(forwardEX_A), 
													  .forwardMEM(forwardMEM_A));
													  
	pipeline_ForwardLogic forwardlogic_B (.readReg_ID(Reg_Ab), 
													  .writeReg_EX(Rd_EX), 
													  .writeReg_MEM(Rd_MEM),
													  .RegWrite_EX,
													  .RegWrite_MEM,
													  .forwardEX(forwardEX_B), 
													  .forwardMEM(forwardMEM_B));
													  
	/* Forwarding Muxs */
	logic [63:0] A_EX_MEM, B_EX_MEM, fw_A, fw_B;
	logic [63:0] ALU_LSR_result;
	mux2_1_VAR #(64) forward_A_EX_mux(.out(A_EX_MEM), .i0(Reg_Da), .i1(ALU_LSR_result), .sel(forwardEX_A));
	mux2_1_VAR #(64) forward_A_MEM_mux(.out(fw_A), .i0(A_EX_MEM), .i1(Dw_MEM), .sel(forwardMEM_A));
	
	mux2_1_VAR #(64) forward_B_EX_mux(.out(B_EX_MEM), .i0(Reg_Db), .i1(ALU_LSR_result), .sel(forwardEX_B));
	mux2_1_VAR #(64) forward_B_MEM_mux(.out(fw_B), .i0(B_EX_MEM), .i1(Dw_MEM), .sel(forwardMEM_B));
	
	
	/*Check if B == 0 for CBZ forwarding */
	logic b_Zero_FW;
	nor_64bit bZeroForward (.in(fw_B), .out(b_Zero_FW));
	
	
	/* ID_EX_Reg */
	//Control Signals For EX Stage
	logic ALUSrc_EX, ADDI_Signal_EX, SetFlag_EX, MemWrite_EX, LSRtoReg_EX, MemtoReg_EX; /*RegWrite_EX is in forwarding*/
	logic [2:0] ALUOp_EX;
	
	//Data For EX Stage
	logic [63:0] Da_EX, Db_EX;
	logic [8:0] Imm9_EX;
	logic [11:0] Imm12_EX;
	logic [5:0] shamt_EX;
	
	ID_EX_Reg ID_EX (.reset, .clk, 
						  .Da_in(fw_A), 
						  .Db_in(fw_B),
						  .control_in({ALUOp_ID[2:0], ALUSrc_ID, ADDI_Signal_ID, SetFlag_ID, MemWrite_ID, LSRtoReg_ID, MemtoReg_ID, RegWrite_ID}), /* NEED CONTROL */
						  .Rd_in(Rd_ID),
						  .Imm9_in(Imm9_ID),
						  .Imm12_in(Imm12_ID),
						  .shamt_in(shamt_ID),
	
						  .Da_out(Da_EX), 
						  .Db_out(Db_EX),
						  .control_out({ALUOp_EX[2:0], ALUSrc_EX, ADDI_Signal_EX, SetFlag_EX, MemWrite_EX, LSRtoReg_EX, MemtoReg_EX, RegWrite_EX}), /*NEED Control */
						  .Rd_out(Rd_EX),
						  .Imm9_out(Imm9_EX),
						  .Imm12_out(Imm12_EX),
						  .shamt_out(shamt_EX)
						  );
	
	
	//ALUSrc Line
	logic [63:0] toALUSrc_mux;
	
	mux2_1_VAR #(64) addi_mux(.out(toALUSrc_mux), .i0({ {55{Imm9_EX[8]}} , Imm9_EX[8:0]}), .i1({ {52{1'b0}} , Imm12_EX[11:0]}), .sel(ADDI_Signal_EX));
	
	logic [63:0] ALU_B;
	mux2_1_VAR #(64) alusrc_mux(.out(ALU_B), .i0(Db_EX), .i1(toALUSrc_mux), .sel(ALUSrc_EX));
	
						 
	//ALU
	logic [63:0] ALU_result;
	logic ALU_negative, ALU_zero, ALU_overflow, ALU_carry_out;
	alu alu (.A(Da_EX), 
				.B(ALU_B), 
				.cntrl(ALUOp_EX), 
				.result(ALU_result), 
				.negative(ALU_negative), 
				.zero(ALU_zero), 
				.overflow(ALU_overflow), 
				.carry_out(ALU_carry_out));
	
	//Setting Flags
	logic [3:0] tempFlags;
	logic FLAG_negative, FLAG_zero, FLAG_overflow, FLAG_carry_out;
	D_FF_En_VAR #(4) flag_Dff(.data_out(tempFlags), 
									  .data_in({ALU_negative, ALU_zero, ALU_overflow, ALU_carry_out}),
									  .write_en(SetFlag_EX),
									  .reset(reset), //1'b0
									  .clk(~clk));
	assign FLAG_negative = tempFlags[3];
	assign FLAG_zero = tempFlags[2];
	assign FLAG_overflow = tempFlags[1];
	assign FLAG_carry_out = tempFlags[0];
			
			
	//LSR
	logic [63:0] LSR_result;
	shifter LSR_shifter (.value(Da_EX), .direction(1'b1), .distance(shamt_EX), .result(LSR_result));
	
	mux2_1_VAR #(64) lsr2reg_mux(.out(ALU_LSR_result), .i0(ALU_result), .i1(LSR_result), .sel(LSRtoReg_EX));
	
	/* EX_MEM_Reg */
	//Control Logic for MEM Stage
	logic MemWrite_MEM, MemtoReg_MEM; /*RegWrite_MEM is in forwarding*/
	
	//Data for MEM Stage
	logic [63:0] ALU_LSR_result_MEM, Db_MEM;
	
	
	EX_MEM_Reg EX_MEM (.reset, 
							 .clk, 
							 .ALU_LSR_result_in(ALU_LSR_result), 
							 .Db_in(Db_EX), 
							 .control_in({MemWrite_EX, MemtoReg_EX, RegWrite_EX}),
							 .Rd_in(Rd_EX),
							 .ALU_LSR_result_out(ALU_LSR_result_MEM), 
						    .Db_out(Db_MEM), 
							 .control_out({MemWrite_MEM, MemtoReg_MEM, RegWrite_MEM}),
							 .Rd_out(Rd_MEM)
							 );
	
	
	//Data Memory
	logic [63:0] Mem_Dout;
	datamem datamem(.address(ALU_LSR_result_MEM),
						 .write_enable(MemWrite_MEM),
						 .read_enable(1'b1),
						 .write_data(Db_MEM),
						 .clk,
						 .xfer_size(4'd8),
						 .read_data(Mem_Dout));
						 
	//Write Back Mux
	mux2_1_VAR #(64) mem2reg_mux(.out(Dw_MEM), .i0(ALU_LSR_result_MEM), .i1(Mem_Dout), .sel(MemtoReg_MEM));
	

	
	/* MEM_WB_Reg */
	//Control and Data are in the Reg file part since they needed to be defined first
	
	MEM_WB_Reg MEM_WB (.reset,
							 .clk,
							 .Rd_in(Rd_MEM),
							 .Dw_in(Dw_MEM),
							 .control_in(RegWrite_MEM),
							 .Rd_out(Rd_WB),
							 .Dw_out(Dw_WB),
							 .control_out(RegWrite_WB)
							 );
	
									
	//No Branch
	logic [63:0] toBrmux_nobr;
	logic [3:0] notNeeded_1;
	alu nobr_adder(.A(PC), .B(64'h04), .cntrl(010), .result(toBrmux_nobr), .negative(notNeeded_1[0]), .zero(notNeeded_1[1]), .overflow(notNeeded_1[2]), .carry_out(notNeeded_1[3]));
	
	
	//Branching
	logic [63:0] branchamount_preshift;
	mux2_1_VAR #(64) condbr_mux(.out(branchamount_preshift),
										 .i0({ {38{Imm26_ID[25]}} , Imm26_ID[25:0]}),
										 .i1({ {45{Imm19_ID[18]}} , Imm19_ID[18:0]}),
										 .sel(CondBr_ID));
	logic [63:0] branchamount;
	shifter branchshifter (.value(branchamount_preshift), .direction(1'b0), .distance(6'b000010), .result(branchamount));
	logic [63:0] toBrmux_br;
	logic [3:0] notNeeded_2;
	alu br_amount_adder(.A(branchamount), .B(PC_ID), .cntrl(010), .result(toBrmux_br), .negative(notNeeded_2[0]), .zero(notNeeded_2[1]), .overflow(notNeeded_2[2]), .carry_out(notNeeded_2[3]));
	
	//BrTaken mux
	mux2_1_VAR #(64) brtaken_mux(.out(computedPC),
										  .i0(toBrmux_nobr),
										  .i1(toBrmux_br),
										  .sel(BrTaken_ID));
										  
	/*
	
	So notes I guess:
	uhh flags I guess
	
	So the B.LT isnt working sad face
	
	
	
	
	
	
	*/
	
	//Control Module
	pipeline_ControlLogic controllogic (.instruction31_21(instruction_ID[31:21]),
									  .FLAG_negative, .b_Zero_FW, .FLAG_overflow,
									  .Reg2Loc_ID, .ADDI_Signal_ID, .SetFlag_ID, .ALUSrc_ID, .MemWrite_ID, .LSRtoReg_ID, .MemtoReg_ID, .RegWrite_ID, .BrTaken_ID, .CondBr_ID,
									  .ALUOp_ID);
									  
	//Program Counter
	D_FF_En_VAR #(64) PC_Dff (.data_out(PC), 
							 .data_in(computedPC), 
							 .write_en(~reset), 
							 .reset, 
							 .clk);

endmodule 