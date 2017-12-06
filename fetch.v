module fetch(input         	 clk, rst, stall,
				 input 		[1:0]  pcsrc,
				 input 		[9:0]  branch_addr, jtype_addr, reg_addr,
				 input      [9:0]  pc_EX,
				 output reg [9:0]  pc_F,
				 output reg [63:0] instr);
	reg [63:0] mem[511:0];
	
	initial begin
		$readmemh("hexcode.txt", mem);
		pc_F = 10'd511;
	end
	
	always @(posedge clk) begin	
		if(rst) begin
			pc_F <= 10'b0;
			instr <= 32'b0;
		end else begin
			case(pcsrc)
				2'b00: pc_F = ((pc_F == 10'd511) | (pc_F === 10'bX))? 10'b0 : pc_F + 10'd2;
				2'b01: pc_F = pc_F + branch_addr - 10'b1;
				2'b10: pc_F = jtype_addr;
				2'b11: pc_F = reg_addr;
				default: pc_F = 10'bX;
			endcase
			
			instr <= (stall | (pc_F === 10'bX)) ? 64'b0 : mem[pc_F[9:1]];
		end
	end
endmodule 