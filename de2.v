module de2(input 		    CLOCK_50,
			  input  [17:0] SW,
			  input  [3:0]  KEY,
			  output [6:0]  HEX0,
			  output [6:0]  HEX1,
			  output [6:0]  HEX2,
			  output [6:0]  HEX3,
			  output [6:0]  HEX4,
			  output [6:0]  HEX5,
			  output [6:0]  HEX6,
			  output [6:0]  HEX7);
	// Connection wires from fecth to execute
	wire [63:0] instr_F_EX;
	wire [9:0]	branch_addr_EX_F, jtype_addr_EX_F, reg_addr_EX_F, pc_EX_F, pc_F_EX;
	wire [1:0]	pcsrc_EX_F;
	wire        stall_EX_F;
	
	// Connection wires to the regfile for execute
	wire [31:0] rs_data1_EX, rt_data1_EX, rs_data2_EX, rt_data2_EX;
	wire [4:0]  rs1_EX, rt1_EX, rs2_EX, rt2_EX;
	
	// Connection wires from execute to write back
	wire [31:0] hi_EX_WB, lo_EX_WB, r1_EX_WB, r2_EX_WB, memdata_EX_WB;
	wire [9:0]  pc_EX_WB;
	wire [4:0]  rd1_EX_WB, rd2_EX_WB;
	wire [2:0]  regsel1_EX_WB, regsel2_EX_WB;
	wire        regwrite1_EX_WB, regwrite2_EX_WB;
	
	// Connections from write back
	wire [31:0] writedata1_WB, writedata2_WB;
	wire [4:0]  writeaddr1_WB, writeaddr2_WB;
	wire        we1_WB, we2_WB;
	
	// Misc. connections
	wire [31:0] reg30_out;
	
	regfile32x32 regfile(.clk(CLOCK_50), .we1(we1_WB), .we2(we2_WB),
								.readaddr1(rs1_EX), .readaddr2(rt1_EX),
								.readaddr3(rs2_EX), .readaddr4(rt2_EX),
								.writeaddr1(writeaddr1_WB), .writeaddr2(writeaddr2_WB), .reg30_in({14'b0, SW}),
								.readdata1(rs_data1_EX), .readdata2(rt_data1_EX),
								.readdata3(rs_data2_EX), .readdata4(rt_data2_EX),
								.writedata1(writedata1_WB), .writedata2(writedata2_WB), .reg30_out(reg30_out));
	
	// CPU stages
	fetch my_fetch(.clk(CLOCK_50), .rst(~KEY[0]), .stall(stall_EX_F),
						.pcsrc(pcsrc_EX_F), .pc_EX(pc_EX_F), .pc_F(pc_F_EX),
						.branch_addr(branch_addr_EX_F), .jtype_addr(jtype_addr_EX_F), .reg_addr(reg_addr_EX_F),
						.instr(instr_F_EX));

	execute my_execute(.clk(CLOCK_50), .instr(instr_F_EX), .stall(stall_EX_F),
							 .rs_data1(rs_data1_EX), .rt_data1(rt_data1_EX), .rs_data2(rs_data2_EX), .rt_data2(rt_data2_EX),
							 .rs1(rs1_EX), .rt1(rt1_EX), .rd1(rd1_EX_WB),
							 .rs2(rs2_EX), .rt2(rt2_EX), .rd2(rd2_EX_WB),
							 .hi(hi_EX_WB), .lo(lo_EX_WB), .r1(r1_EX_WB), .r2(r2_EX_WB), .memdata(memdata_EX_WB),
							 .regsel1(regsel1_EX_WB), .regwrite1(regwrite1_EX_WB),
							 .regsel2(regsel2_EX_WB), .regwrite2(regwrite2_EX_WB),
							 .pcsrc(pcsrc_EX_F), .pc_EX(pc_EX_WB), .pc_F(pc_F_EX),
							 .branch_addr(branch_addr_EX_F), .jtype_addr(jtype_addr_EX_F), .reg_addr(reg_addr_EX_F));

	write_back my_wb(.clk(CLOCK_50), .pc(pc_EX_WB),
						  .hi(hi_EX_WB), .lo(lo_EX_WB), .r1(r1_EX_WB), .r2(r2_EX_WB), .memdata(memdata_EX_WB),
						  .rd1(rd1_EX_WB), .regsel1(regsel1_EX_WB), .regwrite1(regwrite1_EX_WB),
						  .rd2(rd2_EX_WB), .regsel2(regsel2_EX_WB), .regwrite2(regwrite2_EX_WB),
						  .writedata1(writedata1_WB), .writeaddr1(writeaddr1_WB), .we1(we1_WB),
						  .writedata2(writedata2_WB), .writeaddr2(writeaddr2_WB), .we2(we2_WB));
	
	// Let reg30_out connect to the seven segment display.
	sevenseg seg(.data(reg30_out[3:0]), .segments(HEX0));
	sevenseg seg1(.data(reg30_out[7:4]), .segments(HEX1));
	sevenseg seg2(.data(reg30_out[11:8]), .segments(HEX2));
	sevenseg seg3(.data(reg30_out[15:12]), .segments(HEX3));
	sevenseg seg4(.data(reg30_out[19:16]), .segments(HEX4));
	sevenseg seg5(.data(reg30_out[23:20]), .segments(HEX5));
	sevenseg seg6(.data(reg30_out[27:24]), .segments(HEX6));
	sevenseg seg7(.data(reg30_out[31:28]), .segments(HEX7));
	
endmodule 