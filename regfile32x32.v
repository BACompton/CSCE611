module regfile32x32 (input         clk, we1, we2,
							input  [4:0]  readaddr1, readaddr2, writeaddr1,
							input  [4:0]  readaddr3, readaddr4, writeaddr2,
							input  [31:0] writedata1, writedata2, reg30_in,
							output reg [31:0] readdata1, readdata2, readdata3, readdata4, reg30_out);
	reg [31:0] mem [31:0];
	reg [5:0] i;
	
	initial begin
		reg30_out <= 32'b0;
		
		for(i = 6'b0; i < 6'd32; i = i + 6'b1) begin
			mem[i[4:0]] <= 32'b0;
		end
		
		mem[1] <= 32'd10;
		mem[10] <= 32'd10;
		mem[2] <= 32'd429496730;
	end
	
	always @(posedge clk) begin
		if (we1) begin
			if (writeaddr1 == 5'd30) reg30_out <= writedata1;
			if (writeaddr1 != 5'b0)  mem[writeaddr1] <= writedata1;
		end 
		if (we2) begin
			if (writeaddr2 == 5'd30) reg30_out <= writedata2;
			if (writeaddr2 != 5'b0)  mem[writeaddr2] <= writedata2;
		end	
	end
	
	always @(*) begin
		readdata1 <= mem[readaddr1];
		if(readaddr1 == 5'd30)
			readdata1 <= reg30_in;
		else if(readaddr1 != 5'b0) begin
			if     (we2 & (readaddr1 == writeaddr2)) readdata1 <= writedata2;
			else if(we1 & (readaddr1 == writeaddr1)) readdata1 <= writedata1;
		end
		
		readdata2 <= mem[readaddr2];
		if(readaddr2 == 5'd30)
			readdata2 <= reg30_in;
		else if(readaddr2 != 5'b0) begin
			if     (we2 & (readaddr2 == writeaddr2)) readdata2 <= writedata2;
			else if(we1 & (readaddr2 == writeaddr1)) readdata2 <= writedata1;
		end
		
		readdata3 <= mem[readaddr3];
		if(readaddr3 == 5'd30)
			readdata3 <= reg30_in;
		else if(readaddr3 != 5'b0) begin
			if     (we2 & (readaddr3 == writeaddr2)) readdata3 <= writedata2;
			else if(we1 & (readaddr3 == writeaddr1)) readdata3 <= writedata1;
		end
		
		readdata4 <= mem[readaddr4];
		if(readaddr4 == 5'd30)
			readdata4 <= reg30_in;
		else if(readaddr4 != 5'b0) begin
			if     (we2 & (readaddr4 == writeaddr2)) readdata4 <= writedata2;
			else if(we1 & (readaddr4 == writeaddr1)) readdata4 <= writedata1;
		end
	end
endmodule
							