// Yoel Ivan (yivan3@gatech.edu), Wenduo Yang(wyang73@gatech.edu)

module TimerController(state, key, clk, finishBit);

	parameter [3:0]	RESET		= 4'b0100,	// 4
					SET_SEC 	= 4'b0000,	// 0
					SET_MIN		= 4'b0001,	// 1
					READY		= 4'b0011, 	// 3
					TIMER		= 4'b0010,	// 2
					FLASH		= 4'b0101,	// 5
					SEC_MIN 	= 4'b0111,	// 7
					READY_TIMER	= 4'b1001,
					TIMER_READY	= 4'b1011,
					MIN_READY	= 4'b1010;
						
	input [2:0] key;
	input clk, finishBit;
	
	output [3:0] state;
	
	reg [3:0] state;
	
	// apparently KEY are inversed,
	// KEY == 1 if not pressed
	// KEY == 0 if pressed
	always@(posedge clk) begin
		case (state)
			FLASH:
				state <= FLASH;	// need to at 0.5sec delay before it moves to next state
			TIMER:
				if (~key[2])
					state <= TIMER_READY;
				else if (finishBit)
					state <= FLASH;  // change this so that it moves to FLASH_ON only after timer ran out
			TIMER_READY:
				if (key[2])
					state <= READY;
			READY_TIMER:
				if (key[2])
					state <= TIMER;
			READY:
				if (~key[2])
					state <= READY_TIMER;
			MIN_READY:
				if (key[1])
					state <= READY;
			SET_MIN:
				if (~key[1])
					state <= MIN_READY;
			SEC_MIN:
				if (key[1])
					state <= SET_MIN;
			SET_SEC:
				if (~key[1])
					state <= SEC_MIN;
			RESET:
				if (key[0])
					state <= SET_SEC;
		endcase
		if (!key[0])	// Highest priority
			state <= RESET;
	end
	
endmodule