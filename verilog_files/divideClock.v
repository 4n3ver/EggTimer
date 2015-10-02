//Wenduo Yang(wyang73@gatech.edu)
module divideClock(clk_in, clk_out, rst);
	parameter freq = 1'd1;	// in hz

	input clk_in, rst;
	output clk_out;
	reg[31:0] ct;
	
	reg clk_out;
	always @(posedge clk_in) begin
		clk_out <= 0;
		if (ct % (32'd100000000 / (freq * 2)) == 0) begin
			clk_out <= ~clk_out;
			ct <= 32'b0;
		end		
		ct <= ct + 1'd1;
	end
endmodule