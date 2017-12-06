module write_back(input clk,
						input [31:0] hi, lo, r1, r2, memdata,
						input [9:0]  pc,
						input [4:0]  rd1, rd2,
						input [2:0]  regsel1, regsel2,
						input        regwrite1, regwrite2,
						output reg [31:0] writedata1, writedata2,
						output reg        we1, we2,
						output reg [4:0]  writeaddr1, writeaddr2);

	always @(*) begin
		writeaddr1 <= rd1;
		writeaddr2 <= rd2;
		we1 <= regwrite1;
		we2 <= regwrite2;
		
		case(regsel1)
			3'b000: writedata1 <= r1;
			3'b001: writedata1 <= hi;
			3'b010: writedata1 <= lo;
			3'b011: writedata1 <= memdata;
			3'b100: writedata1 <= pc;
			default: writedata1 <= 32'bX;
		endcase
		
		case(regsel2)
			3'b000: writedata2 <= r2;
			3'b001: writedata2 <= hi;
			3'b010: writedata2 <= lo;
			3'b011: writedata2 <= memdata;
			3'b100: writedata2 <= pc;
			default: writedata2 <= 32'bX;
		endcase
	end
						
endmodule 