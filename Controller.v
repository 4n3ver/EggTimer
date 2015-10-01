// Yoel Ivan (yivan3@gatech.edu)

module Controller(state, key, clk);

	parameter [2:0]	RESET		= 3'b100,	// 4
					SET_SEC 	= 3'b000,	// 0
					SET_MIN		= 3'b001,	// 1
					READY		= 3'b011, 	// 3
					TIMER		= 3'b010,	// 2
					FLASH_OFF	= 3'b110,	// 6
					FLASH_ON	= 3'b101,	// 5
					SETTING_MIN	= 3'b111;	// 7
						
	input [2:0] key;
	input clk;
	
	output [2:0] state;
	
	reg [2:0] state;
	
	// apparently KEY are inversed,
	// KEY == 1 if not pressed
	// KEY == 0 if pressed
	always@(posedge clk) begin
		case (state)
			FLASH_OFF:
				state <= FLASH_ON;	// need to at 0.5sec delay before it moves to next state
			FLASH_ON:
				state <= FLASH_OFF;	// need to at 0.5sec delay before it moves to next state
			TIMER:	
				state <= FLASH_ON;	// change this so that it moves to FLASH_ON only after timer ran out
			READY:
				if (key[2])
					state <= TIMER;
			SET_MIN	:
				if (!key[1])
					state <= READY;
			SETTING_MIN:
				if (key[1])
					state <= SET_MIN;
			SET_SEC:
				if (!key[1])
					state <= SETTING_MIN;
			RESET:
				if (key[0])
					state <= SET_SEC;
		endcase
		if (!key[0])	// Highest priority
			state <= RESET;
	end
	
endmodule