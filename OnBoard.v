// Yoel Ivan (yivan3@gatech.edu)

module OnBoard(LEDR, HEX3, HEX2, HEX1, HEX0, SW, KEY, CLOCK_50);

	input [7:0] SW;
	input [2:0] KEY;
	input CLOCK_50;
	
	output [9:0] LEDR;
	output [6:0] HEX3, HEX2, HEX1, HEX0;
	
	reg [9:0] LEDR;
	reg [6:0] HEX3, HEX2, HEX1, HEX0; 
	
	reg [3:0] STATE;
	
	// 000	SET_SEC
	// 001 	SET_MIN
	// 011	READY
	// 010	TIMER
	// 100	FLASH
	
	always@(*) begin 
		if (KEY[1]) begin
			if (STATE == 3'b001) begin
				STATE <= 3'b011;	// set state from SET_MIN to READY
			end
			else if (STATE == 3'b000) begin
				STATE <= 3'b001;	// set state from SET_SEC to SET_MIN
			end
		end
		// if (KEY[0]) begin
			// LEDR 	<= 10'b0;
			// HEX3	<= 1'h0;
			// HEX2	<= 1'h0;
			// HEX1	<= 1'h0;
			// HEX0	<= 1'h0;
			// STATE	<= 3'b0;
		// end
		
	end
	
	always@(SW[3:0]) begin
		if (STATE == 3'b000) begin
			HEX0[3:0] <= SW[3:0];
		end
		else if (STATE == 3'b001) begin
			HEX2[3:0] <= SW[3:0];
		end
	end
	
	always@(SW[7:4]) begin
		if (STATE == 3'b000) begin
			HEX1[3:0] <= SW[7:4];
		end
		else if (STATE == 3'b001) begin
			HEX3[3:0] <= SW[7:4];
		end
	end
	
endmodule