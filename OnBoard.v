// Yoel Ivan (yivan3@gatech.edu)

module OnBoard(LEDG, LEDR, HEX3, HEX2, HEX1, HEX0, SW, KEY, CLOCK_50);
	parameter [2:0]	RESET		= 3'b100,	// 4
					SET_SEC 	= 3'b000,	// 0
					SET_MIN		= 3'b001,	// 1
					READY		= 3'b011, 	// 3
					TIMER		= 3'b010,	// 2
					FLASH_OFF	= 3'b110,	// 6
					FLASH_ON	= 3'b101,	// 5
					SETTING_MIN	= 3'b111;	// 7

	input [7:0] SW;
	input [2:0] KEY;
	input CLOCK_50;
	
	output [9:0] LEDR;
	output [6:0] HEX3, HEX2, HEX1, HEX0;
	
	// debugging light, so we can see what state we are at on the board
	output [6:0] LEDG;
	reg [6:0] LEDG;	
	
	wire [2:0] wSTATE;
	Controller fsm(wSTATE, KEY, CLOCK_50);	

	reg [3:0] r0, r1, r2, r3;	// input wire
	reg en0, en1, en2, en3;	// enable bit
	wire [6:0] w0, w1, w2, w3;	// output wire
	nBitRegister #(4) LoSec(w0, r0, en0, CLOCK_50);
	nBitRegister #(4) HiSec(w1, r1, en1, CLOCK_50);
	nBitRegister #(4) LoMin(w2, r2, en2, CLOCK_50);
	nBitRegister #(4) HiMin(w3, r3, en3, CLOCK_50);
	
	// connect to display
	dec2_7seg disp3(HEX3, w3);
	dec2_7seg disp2(HEX2, w2);
	dec2_7seg disp1(HEX1, w1);
	dec2_7seg disp0(HEX0, w0);
	
	reg [9:0] LEDR;
	always@(*) begin 
		LEDG <= 7'b0;
		case(wSTATE)
			FLASH_OFF:
				begin
					LEDR <= 10'b0;
					LEDG <= 7'b0000011;
				end
			FLASH_ON:
				begin
					LEDR <= 10'b1111111111;
					LEDG <= 7'b0000001;
				end
			TIMER:
				begin
					LEDG <= 7'b0000010;
				end
			READY:
				begin
					LEDG <= 7'b0000100;
					LEDR <= 10'b0;
				end
			SET_MIN: 
				begin
					LEDR <= 10'b0;	// why is this flashing by its own?
					en2 <= 1'b1;
					en3 <= 1'b1;
					r2 <= (SW[3:0] <= 4'd9) ? SW[3:0] : 4'd9;
					r3 <= (SW[7:4] <= 4'd5) ? SW[7:4] : 4'd5;
				end
			SETTING_MIN:
				begin
					LEDR <= 10'b0;	// why is this flashing by its own?
					en0 <= 1'b0;
					en1 <= 1'b0;
				end
			SET_SEC:
				begin
					LEDR <= 10'b0;	// why is this flashing by its own?
					en2 <= 1'b0;
					en3 <= 1'b0;
					r0 <= (SW[3:0] <= 4'd9) ? SW[3:0] : 4'd9;
					r1 <= (SW[7:4] <= 4'd5) ? SW[7:4] : 4'd5;
				end
			RESET:
				begin
					// if LEDR not manually set to 0 on each state,it can somehow
					// lit up by its own
					LEDR <= 10'b0;	// why is this flashing by its own?
					en0 <= 1'b1;
					en1 <= 1'b1;
					en2 <= 1'b1;
					en3 <= 1'b1;
					r0 <= 4'b0;
					r1 <= 4'b0;
					r2 <= 4'b0;
					r3 <= 4'b0;
				end
		endcase
	end
	
endmodule