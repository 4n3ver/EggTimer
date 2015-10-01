// Yoel Ivan (yivan3@gatech.edu)

`timescale 1ns / 1ps

module OnBoardTester;
	
	reg [2:0] KEY;
	reg [7:0] SW;
	reg CLK;
	
	wire [6:0] HEX3, HEX2, HEX1, HEX0; 
	wire [9:0] LEDR;
	wire [6:0] LEDG;
	
	OnBoard board(LEDG, LEDR, HEX3, HEX2, HEX1, HEX0, SW, KEY, CLK);
	
	initial begin
		CLK = 1'b0;
		KEY = 3'b1;
		SW = 8'b0;
		#100
		
		// try RESETTING
		KEY[0] = 0;
		#100
		KEY[0] = 1;
		#100
		$display("[TEST] RESET PRESSED!\n");
		
	
		SW[7:4] = 4'd5;
		SW[3:0] = 4'd9;
		#100
		
		
		// pressing KEY[1]
		KEY[1] = 0;
		#100
		KEY[1] = 1;
		#100
		$display("[TEST] KEY[1] PRESSED!\n");
		
		SW[7:4] = 4'd1;
		SW[3:0] = 4'd0;
		#100
		
		// pressing KEY[1]
		KEY[1] = 0;
		#100
		KEY[1] = 1;
		#100
		$display("[TEST] KEY[1] PRESSED!\n");

		
		#200;
		
		$stop;
		
	end
	
	always begin
		#5 CLK = !CLK;
	end

endmodule