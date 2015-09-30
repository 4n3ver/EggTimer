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
	output [2:0] state;
	
	wire [2:0] wSTATE;
	wire [6:0] wR, w3, w2, w1, w0;

	reg [9:0] LEDR;
	reg [6:0] HEX3, HEX2, HEX1, HEX0; 
	
	Controller fsm(wSTATE, KEY, CLOCK_50);
	assign state = wSTATE;
	
	dec2_7seg disp3(w3, SW[7:4]);
	dec2_7seg disp2(w2, SW[3:0]);
	dec2_7seg disp1(w1, SW[7:4]);
	dec2_7seg disp0(w0, SW[3:0]);
	dec2_7seg reset(wR, 4'b0);
	
	always@(*) begin 
		case(wSTATE)
			FLASH_OFF:
				LEDR <= 10'b0;
			FLASH_ON:
				LEDR <= 10'b1111111111;
			SET_MIN: 
				begin
					HEX2 <= w2;
					HEX3 <= w3;
				end
			SET_SEC:
				begin
					HEX0 <= w0;
					HEX1 <= w1;
				end
			RESET:
				begin
					LEDR <= 10'b0;
					HEX0 <= wR;
					HEX1 <= wR;
					HEX2 <= wR;
					HEX3 <= wR;
				end
		endcase
	end
	
endmodule