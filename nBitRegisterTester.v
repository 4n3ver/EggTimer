// Yoel Ivan (yivan3@gatech.edu)

`timescale 1ns / 1ps

module nBitRegisterTester;
	
	reg [15:0] in;
	reg clk, en;
	
	wire [15:0] out;
	
	nBitRegister #(16) register(out, in, en, clk);
	
	initial begin
		clk = 1'b0;
		in = 16'd36;
		en = 0;
		#100
		
		en = 1;
		clk = 1;
		#5
		in = 16'd0;
		#5
		clk = 0;
		en = 0;
		$display("REG val: %d, should be 36\n", out);
		
		in = 16'd26;
		#5
		
		clk = 1;
		#5
		in = 16'd0;
		#5
		clk = 0;
		$display("REG val: %d, should be 36\n", out);
		
		in = 16'd9;
		#5
		
		en = 1;
		clk = 1;
		#5
		in = 16'd0;
		#5
		clk = 0;
		en = 0;
		$display("REG val: %d, should be 9\n", out);

		
		#200;
		
		$stop;
		
	end

endmodule