// Yoel Ivan (yivan3@gatech.edu)

`timescale 1ns / 1ps

module OnBoardTester;
	
	reg [2:0] KEY = 3'b0;
	reg [7:0] SW = 8'b0;
	reg CLK = 1'b0;
	
	wire [6:0] HEX3 = 7'b0, HEX2 = 7'b0, HEX1 = 7'b0, HEX0 = 7'b0; 
	wire [9:0] LEDR = 10'b0;
	wire [2:0] STATE;
	
	OnBoard board(STATE, LEDR, HEX3, HEX2, HEX1, HEX0, SW, KEY, CLK);
	
	initial begin
		#100
		
		
		// try RESETTING
		KEY[0] = 1;
		#100
		KEY[0] = 0;
		#100
		$display("[TEST] RESET PRESSED!\n");
		
		#5	// wait a cycle		
		SW[7:0] = 8'b10100011;
		
		
		// pressing KEY[1]
		KEY[1] = 1;
		#100
		KEY[1] = 0;
		#100
		$display("[TEST] KEY[1] PRESSED!\n");
		
		SW[7:0] = 8'b11010110;
		
		// pressing KEY[1]
		KEY[1] = 1;
		#100
		KEY[1] = 0;
		#100
		$display("[TEST] KEY[1] PRESSED!\n");

		
		#200;
		
		$stop;
		
	end
	
	always begin
		#5 CLK = !CLK;
	end

endmodule