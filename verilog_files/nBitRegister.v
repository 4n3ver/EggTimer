// Yoel Ivan (yivan3@gatech.edu)

module nBitRegister(out, in, wr_en, clk);
	parameter n = 8;
	
	input [n-1:0] in;
	input clk, wr_en;
	
	output [n-1:0] out;
	
	reg [n-1:0] out;
	
	always@(posedge clk) begin
		if (wr_en)
			out <= in;
	end
	
endmodule