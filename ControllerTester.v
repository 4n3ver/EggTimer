// Yoel Ivan (yivan3@gatech.edu)

`timescale 1ns / 1ps

module ControllerTester;
	
	reg [2:0] KEY = 3'b0;
	reg CLK = 1'b0;
	
	wire [3:0] STATE;
	
	
	Controller fsm(STATE, KEY, CLK);
	
	initial begin
		#100
		
		$display("initial STATE: %b\n", STATE);
		
		// try RESETTING
		KEY[0] = 1;
		#100
		KEY[0] = 0;
		#100
		$display("[TEST] RESET PRESSED!\n");
		$display("[RESET] STATE: %b\n", STATE);
		
		#5	// wait a cycle		
		$display("[SET_SEC] STATE: %b\n", STATE);
		
		// pressing KEY[1]
		KEY[1] = 1;
		#100
		KEY[1] = 0;
		#100
		$display("[TEST] KEY[1] PRESSED!\n");
		$display("[SET_MIN] STATE: %b\n", STATE);
		
		// pressing KEY[1]
		KEY[1] = 1;
		#100
		KEY[1] = 0;
		#100
		$display("[TEST] KEY[1] PRESSED!\n");
		$display("[READY] STATE: %b\n", STATE);

		
		#200;
		
		$stop;
		
	end
	
	always begin
		#5 CLK = !CLK;
	end

endmodule