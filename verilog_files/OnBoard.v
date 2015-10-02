// Yoel Ivan (yivan3@gatech.edu), Wenduo Yang(wyang73@gatech.edu)

module OnBoard(LEDR, HEX3, HEX2, HEX1, HEX0, SW, KEY, CLOCK_50);
	parameter [3:0]	RESET		= 4'b0100,	// 4
					SET_SEC 	= 4'b0000,	// 0
					SET_MIN		= 4'b0001,	// 1
					READY		= 4'b0011, 	// 3
					TIMER		= 4'b0010,	// 2
					FLASH		= 4'b0101,	// 5
					SEC_MIN 	= 4'b0111,	// transition state
					READY_TIMER	= 4'b1001,
					TIMER_READY	= 4'b1011,
					MIN_READY	= 4'b1010;
									
	input [7:0] SW;
	input [2:0] KEY;
	input CLOCK_50;
	
	output [9:0] LEDR;
	output [6:0] HEX3, HEX2, HEX1, HEX0;
	
	wire timeoutBit, clk0;	
	wire [3:0] wSTATE;
	TimerController fsm(wSTATE, KEY, CLOCK_50, timeoutBit);	
	divideClock #(1) dvd(CLOCK_50, clk0, ~KEY[0]);

	reg [3:0] r0, r1, r2, r3;
	reg [15:0] timeStore;
	
	// connect to display	
	wire [3:0] out3, out2, out1, out0;
	dec2_7seg disp3(HEX3, out3);
	dec2_7seg disp2(HEX2, out2);
	dec2_7seg disp1(HEX1, out1);
	dec2_7seg disp0(HEX0, out0);
	
	reg sel;
	nBit2InputMux #(4) mux3(out3, sel, timeStore[15:12], r3);
	nBit2InputMux #(4) mux2(out2, sel, timeStore[11:8], r2);
	nBit2InputMux #(4) mux1(out1, sel, timeStore[7:4], r1);
	nBit2InputMux #(4) mux0(out0, sel, timeStore[3:0], r0);
	
	assign timeoutBit = ({r3, r2, r1, r0} == 0) ? 1 : 0;
	reg [9:0] LEDR;
	
	wire CLK500ms;
	divideClock #(2) ledrclock(CLOCK_50, CLK500ms, ~KEY[0]);
	always@(posedge CLK500ms) begin		
		case(wSTATE)		
			FLASH: begin
				LEDR[9:0] <= ~LEDR[9:0];
			end
			default: begin
				LEDR[9:0] <= 10'b0;
			end
		endcase
	end
	
	always @(posedge clk0) begin
		case(wSTATE)
			FLASH: begin end
			TIMER: begin
				r0 <= r0 - 1;
				if (r0 == 0) begin
					r0 <= 9;
					r1 <= r1 - 1;
					if (r1 == 0) begin
						r1 <= 5;
						r2 <= r2 - 1;
						if (r2 == 0) begin
							r2 <= 9;
							r3 <= r3 - 1;
						end
					end
				end
			end
			TIMER_READY: begin end
			READY_TIMER: begin end
			READY: begin end	
			default:
				{r3, r2, r1, r0} <= timeStore;	
		endcase
	end
	
	always@(posedge CLOCK_50) begin
		case(wSTATE)
			MIN_READY:
				sel <= 1;
			SET_MIN: begin
				timeStore[15:12] <= (SW[7:4] <= 4'd5) ? SW[7:4] : 4'd5;
				timeStore[11:8] <= (SW[3:0] <= 4'd9) ? SW[3:0] : 4'd9;
			end
			SEC_MIN: begin
				timeStore[7:4] <= (SW[7:4] <= 4'd5) ? SW[7:4] : 4'd5;
				timeStore[3:0] <= (SW[3:0] <= 4'd9) ? SW[3:0] : 4'd9;
			end
			SET_SEC: begin
				timeStore[7:4] <= (SW[7:4] <= 4'd5) ? SW[7:4] : 4'd5;
				timeStore[3:0] <= (SW[3:0] <= 4'd9) ? SW[3:0] : 4'd9;
			end
			RESET: begin
				sel <= 0;
				timeStore = 16'b0;
			end
		endcase
	end
	
endmodule