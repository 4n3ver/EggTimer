// Yoel Ivan (yivan3@gatech.edu)

`timescale 1ns / 1ps

module ClockDividerTester;

	reg clk;
	
	reg compare;
	
	wire out;
	
	ClockDiviver div(out, clk);
	
	initial begin
		clk = 0;
		compare = 0;
		
		#100000000;
		
		$stop;
		
	end
	
	always begin
		#1 clk = !clk;
	end
	
	always begin
		#25000000 compare = !compare;
	end

endmodule