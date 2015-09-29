// Yoel Ivan (yivan3@gatech.edu)

module OnBoard(state, LEDR, HEX3, HEX2, HEX1, HEX0, SW, KEY, CLOCK_50);

	parameter [2:0]	RESET		= 3'b100,	// 4
					SET_SEC 	= 3'b000,	// 0
					SET_MIN		= 3'b001,	// 1
					READY		= 3'b011, 	// 3
					TIMER		= 3'b010,	// 2
					FLASH_OFF	= 3'b110,	// 6
					FLASH_ON	= 3'b101,	// 5
					SETTING_MIN	= 3'b111;

	input [7:0] SW;
	input [2:0] KEY;
	input CLOCK_50;
	
	output [9:0] LEDR;
	output [6:0] HEX3, HEX2, HEX1, HEX0;
	output [3:0] state;
	
	wire [3:0] wSTATE;
	wire [6:0] wR, w3, w2, w1, w0;
	
	Controller fsm(wSTATE, KEY, CLOCK_50);
	assign state = wSTATE;
	
	dec2_7seg disp3(w3, SW[7:4]);
	dec2_7seg disp2(w2, SW[3:0]);
	dec2_7seg disp1(w1, SW[7:4]);
	dec2_7seg disp0(w0, SW[3:0]);
	dec2_7seg reset(wR, 4'b0);
	
	assign HEX3 = rHEX3;
	assign HEX2 = rHEX2;
	assign HEX1 = rHEX1;
	assign HEX0 = rHEX0;
	assign LEDR = rLEDR;

	reg [9:0] rLEDR;
	reg [6:0] rHEX3, rHEX2, rHEX1, rHEX0; 
	
	always@(*) begin 
		case(wSTATE)
			FLASH_OFF:
				rLEDR <= 10'b0;
			FLASH_ON:
				rLEDR <= 10'b1111111111;
			SET_MIN: 
				begin
					rHEX2 <= w2;
					rHEX3 <= w3;
				end
			SET_SEC:
				begin
					rHEX0 <= w0;
					rHEX1 <= w1;
				end
			RESET:
				begin
					rLEDR <= 10'b0;
					rHEX0 <= wR;
					rHEX1 <= wR;
					rHEX2 <= wR;
					rHEX3 <= wR;
				end
		endcase
	end
	
endmodule