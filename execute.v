module execute(input         clk,
					input  [9:0]  pc_F,
					input  [31:0] rs_data1, rt_data1, rs_data2, rt_data2,
					input  [63:0] instr,
					output				stall,
					output [4:0]      rs1, rt1, rs2, rt2,
					output [31:0] 		memdata,
					output reg [4:0]  rd1, rd2,
					output reg [31:0] hi, lo, r1, r2,
					output reg [9:0]	jtype_addr, branch_addr, reg_addr, pc_EX,
					output reg [2:0]  regsel1, regsel2,
					output reg [1:0]	pcsrc,
					output reg        regwrite1, regwrite2);
	// 1st Instr Vars
	reg  [31:0] rt_data1_EX, hi1_delay_EX, lo1_delay_EX;
	reg			enhilo1_delay_EX;
	
	wire [31:0] dataout1_EX;
	wire [3:0]  alu_op1_EX;
	wire [4:0]  alu_shamt1_EX;
	wire [2:0]  regsel1_EX;
	wire [1:0]  pcsrc1_EX, rdrt1_EX;
	wire        enhilo1_EX, regwrite1_EX, memwrite1_EX, alusrc1_EX;
	wire			reg_r1_EX, stall1_EX, signed1_EX;
	
	wire [31:0] alu_hi1, alu_lo1;
	wire 	      alu_zero1;
	
	// 2nd Instr Vars
	reg  [31:0] rt_data2_EX, hi2_delay_EX, lo2_delay_EX;
	reg			enhilo2_delay_EX;
	
	wire [31:0] dataout2_EX;
	wire [3:0]  alu_op2_EX;
	wire [4:0]  alu_shamt2_EX;
	wire [2:0]  regsel2_EX;
	wire [1:0]  pcsrc2_EX, rdrt2_EX;
	wire        enhilo2_EX, regwrite2_EX, memwrite2_EX, alusrc2_EX;
	wire			reg_r2_EX, stall2_EX, signed2_EX;
	
	wire [31:0] alu_hi2, alu_lo2;
	wire 	      alu_zero2;
	wire			stall2;
	
	// 1st Instr alu and control unit
	alu my_alu1(.a(rs_data1), .b(rt_data1_EX), .op(alu_op1_EX), .shamt(alu_shamt1_EX),
				   .hi(alu_hi1), .lo(alu_lo1), .zero(alu_zero1));
	control_unit cunit1(.op_code(instr[63:58]), .funct_code(instr[37:32]), .instr_shamt(instr[42:38]),
							 .rs_data(rs_data1), .alu_zero(alu_zero1),
							 .alu_op(alu_op1_EX), .alu_shamt(alu_shamt1_EX),
							 .enhilo(enhilo1_EX), .regsel(regsel1_EX), .regwrite(regwrite1_EX),
							 .memwrite(memwrite1_EX), .alusrc(alusrc1_EX), .rdrt(rdrt1_EX), .reg_r(reg_r1_EX),
							 .stall(stall), .pcsrc(pcsrc1_EX), .sign(signed1_EX));
	data_memory my_mem(.clk(clk), .we(memwrite1_EX),
							 .addr(alu_lo1[9:0]), .datain(rt_data1),
							 .dataout(dataout1_EX));
	
	// 2nd Instr alu and control unit
	alu my_alu2(.a(rs_data2), .b(rt_data2_EX), .op(alu_op2_EX), .shamt(alu_shamt2_EX),
				   .hi(alu_hi2), .lo(alu_lo2), .zero(alu_zero2));
	control_unit cunit2(.op_code(instr[31:26]), .funct_code(instr[5:0]), .instr_shamt(instr[10:6]),
							 .rs_data(rs_data2), .alu_zero(alu_zero2),
							 .alu_op(alu_op2_EX), .alu_shamt(alu_shamt2_EX),
							 .enhilo(enhilo2_EX), .regsel(regsel2_EX), .regwrite(regwrite2_EX),
							 .memwrite(memwrite2_EX), .alusrc(alusrc2_EX), .rdrt(rdrt2_EX), .reg_r(reg_r2_EX),
							 .stall(stall2_EX), .pcsrc(pcsrc2_EX), .sign(signed2_EX));
	
	
	assign memdata = dataout1_EX;
	assign rs1 = instr[57:53];
	assign rt1 = instr[52:48];
	assign rs2 = instr[25:21];
	assign rt2 = instr[20:16];
	
	always @(*) begin
		if(alusrc1_EX) begin  // 1st Instr
			if(signed1_EX) rt_data1_EX <= {{16{instr[47]}}, instr[47:32]};
			else 			   rt_data1_EX <= {{16{1'b0}}, instr[47:32]};
		end else begin
			rt_data1_EX <= rt_data1;
		end
		
		if(alusrc2_EX) begin // 2nd Instr
			if(signed2_EX)  rt_data2_EX <= {{16{instr[15]}}, instr[15:0]};
			else 			   rt_data2_EX <= {{16{1'b0}}, instr[15:0]};
		end else begin
			rt_data2_EX <= rt_data2;
		end
	end
	
	// Execute Stage
	always @(posedge clk) begin
		enhilo1_delay_EX <= enhilo1_EX;
		hi1_delay_EX <= alu_hi1;
		lo1_delay_EX <= alu_lo1;
		enhilo2_delay_EX <= enhilo2_EX;
		hi2_delay_EX <= alu_hi2;
		lo2_delay_EX <= alu_lo2;
	
		if(reg_r1_EX) r1 <= alu_lo1;
		if(reg_r2_EX) r2 <= alu_lo2;
		if(enhilo1_delay_EX) begin
			hi <= hi1_delay_EX;
			lo <= lo1_delay_EX;
		end else if(enhilo2_delay_EX) begin
			hi <= hi2_delay_EX;
			lo <= lo2_delay_EX;
		end
		pc_EX <= pc_F + 2;
		
		regsel1 <= regsel1_EX;
		regwrite1 <= regwrite1_EX;
		regsel2 <= regsel2_EX;
		regwrite2 <= regwrite2_EX;
		
		pcsrc <= pcsrc1_EX;
		reg_addr <= rs_data1[9:0];
		jtype_addr <= instr[41:32];
		branch_addr <= instr[41:32];
		
		case(rdrt1_EX)
			2'b00: rd1 <= instr[47:43];
			2'b01: rd1 <= instr[52:48];
			2'b10: rd1 <= 5'd31;
			default: rd1 <= 5'bX; 
		endcase
		case(rdrt2_EX)
			2'b00: rd2 <= instr[15:11];
			2'b01: rd2 <= instr[20:16];
			2'b10: rd2 <= 5'd31;
			default: rd2 <= 5'bX; 
		endcase
	end
	
endmodule 