module ClockDiviver(clkOut, clkIn);
	parameter freq = 1;	// in hz
	
	input clkIn;
	
	output clkOut;
	
	reg clkOut;
	reg [31:0] counter;
	
	always@(posedge clkIn) begin
		clkOut <= 0;
		counter <= 0;
		if (counter % (50000000 / (freq * 2))) begin
			clkOut <= ~clkOut;
		end
		counter <= counter + 1;
	end	
endmodule