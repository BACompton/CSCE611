module control_unit(input  [5:0]	 op_code,
						  input  [5:0]  funct_code,
						  input  [4:0]  instr_shamt,
						  input  [31:0] rs_data,
						  input         alu_zero,
						  output reg [3:0] alu_op,
						  output reg [4:0] alu_shamt,
						  output reg [2:0] regsel, 
						  output reg [1:0] rdrt, pcsrc,
						  output reg       enhilo, regwrite, memwrite, alusrc, reg_r, stall, sign);
	always @(*) begin
		alu_op = 4'b0;
		alu_shamt = 5'bX;
		enhilo = 1'b0;
		regsel = 3'b000; // 0 => r, 1 => hi, 2 => lo, 3 => mem, 4 => PC
		regwrite = 1'b0;
		memwrite = 1'b0;
		alusrc = 1'b0; // 0 => rt_data, 1 => Immediate
		rdrt = 2'b0; // 0 => rd; 1 => rt, 2 => 31
		reg_r = 1'b1;
		pcsrc = 2'b0; // 0 => +1, 1 => branch, 2 => jtype, 3 => reg 
		stall = 1'b0; // 0 => no, 1 => stall
		sign = 1'b1;
		
		if(op_code == 6'b000000) begin  // R-Type
			if((funct_code == 6'b100000) | (funct_code == 6'b100001)) begin // add, addu
				alu_op = 4'b0100;
				regwrite = 1'b1;
			end else if((funct_code == 6'b100010) | (funct_code == 6'b100011)) begin // sub, subu
				alu_op = 4'b0101;
				regwrite = 1'b1;
			end else if((funct_code == 6'b011000)) begin // mult
				alu_op = 4'b0110;
				enhilo = 1'b1;
			end else if((funct_code == 6'b011001)) begin // multu
				alu_op = 4'b0111;
				enhilo = 1'b1;
			end else if((funct_code == 6'b010000)) begin // mfhi
				alu_op = 4'bX;
				regsel = 3'b001;
				regwrite = 1'b1;
			end else if((funct_code == 6'b010010)) begin // mflo
				alu_op = 4'bX;
				regsel = 3'b010;
				regwrite = 1'b1;
			end else if((funct_code == 6'b100100)) begin // and
				alu_op = 4'b0000;
				regwrite = 1'b1;
			end else if((funct_code == 6'b100101)) begin // or
				alu_op = 4'b0001;
				regwrite = 1'b1;
			end else if((funct_code == 6'b100110)) begin // xor
				alu_op = 4'b0011;
				regwrite = 1'b1;
			end else if((funct_code == 6'b100111)) begin // nor
				alu_op = 4'b0010;
				regwrite = 1'b1;
			end else if((funct_code == 6'b000000) & (instr_shamt == 4'b0000)) begin // nop
				alu_op = 4'bX;
			end else if((funct_code == 6'b000000)) begin // sll
				alu_op = 4'b1000;
				alu_shamt = instr_shamt;
				regwrite = 1'b1;
			end else if((funct_code == 6'b000010)) begin // srl
				alu_op = 4'b1001;
				alu_shamt = instr_shamt;
				regwrite = 1'b1;
			end else if((funct_code == 6'b000011)) begin // sra
				alu_op = 4'b1011;
				alu_shamt = instr_shamt;
				regwrite = 1'b1;
			end else if((funct_code == 6'b101010)) begin // slt
				alu_op = 4'b1100;
				regwrite = 1'b1;
			end else if((funct_code == 6'b101011)) begin // sltu
				alu_op = 4'b1110;
				regwrite = 1'b1;
			end else if((funct_code == 6'b001000)) begin // jr
				alu_op = 4'bX;
				reg_r = 1'b0;
				pcsrc = 2'b11;
				stall = 1'b1;
			end 
		end else begin  // I-Type
			if((op_code == 6'b001000)) begin // addi
				alu_op = 4'b0100;
				regwrite = 1'b1;
				alusrc = 1'b1;
				rdrt = 2'b1;
			end else if((op_code == 6'b001001)) begin // addiu
				alu_op = 4'b0100;
				regwrite = 1'b1;
				alusrc = 1'b1;
				rdrt = 2'b1;
				sign = 1'b0;
			end else if((op_code == 6'b001100)) begin // andi
				alu_op = 4'b0000;
				regwrite = 1'b1;
				alusrc = 1'b1;
				rdrt = 2'b1;
				sign = 1'b0;
			end else if((op_code == 6'b001101)) begin // ori
				alu_op = 4'b0001;
				regwrite = 1'b1;
				alusrc = 1'b1;
				rdrt = 2'b1;
				sign = 1'b0;
			end else if((op_code == 6'b001110)) begin // xori
				alu_op = 4'b0011;
				regwrite = 1'b1;
				alusrc = 1'b1;
				rdrt = 2'b1;
				sign = 1'b0;
			end else if((op_code == 6'b001010)) begin // slti
				alu_op = 4'b1100;
				regwrite = 1'b1;
				alusrc = 1'b1;
				rdrt = 2'b1;
			end else if((op_code == 6'b100011)) begin // lw
				alu_op = 4'b0100;
				regwrite = 1'b1;
				alusrc = 1'b1;
				rdrt = 2'b1;
				regsel = 3'b011;
				reg_r = 1'b0;
			end else if((op_code == 6'b101011)) begin // sw
				alu_op = 4'b0100;
				alusrc = 1'b1;
				rdrt = 2'b1;
				memwrite = 1'b1;
				reg_r = 1'b0;
			end else if((op_code == 6'b001111)) begin // lui
				alu_op = 4'b1000;
				alu_shamt = 5'd16;
				regwrite = 1'b1;
				alusrc = 1'b1;
				rdrt = 2'b1;
			end else if((op_code == 6'b000100)) begin // beq
				alu_op = 4'b0101;
				reg_r = 1'b0;
				
				if(alu_zero) begin
					pcsrc = 2'b01;
					stall = 1'b1;
				end else begin
					pcsrc = 2'b00;
					stall = 1'b0;
				end
			end else if((op_code == 6'b000101)) begin // bne
				alu_op = 4'b0101;
				reg_r = 1'b0;
				
				if(alu_zero) begin
					pcsrc = 2'b00;
					stall = 1'b0;
				end else begin
					pcsrc = 2'b01;
					stall = 1'b1;
				end
			end else if((op_code == 6'b000001)) begin // bgez
				alu_op = 4'b1100;
				reg_r = 1'b0;
				
				if(rs_data[31] == 1'b0) begin
					pcsrc = 2'b01;
					stall = 1'b1;
				end else begin
					pcsrc = 2'b00;
					stall = 1'b0;
				end
			end else if((op_code == 6'b000010)) begin // j
				alu_op = 4'bX;
				reg_r = 1'b0;
				pcsrc = 2'b10;
				stall = 1'b1;
			end else if((op_code == 6'b000011)) begin // jal
				alu_op = 4'bX;
				reg_r = 1'b0;
				rdrt = 2'b10;
				regsel = 3'b100;
				regwrite = 1'b1;
				pcsrc = 2'b10;
				stall = 1'b1;
			end
		end	
	end
endmodule 