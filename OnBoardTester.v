// Yoel Ivan (yivan3@gatech.edu)

`timescale 1ns / 1ps

module OnBoardTester;

	reg [7:0] SW;
	reg [2:0] KEY;

	wire [9:0] LEDR;
	wire [6:0] HEX3, HEX2, HEX1, HEX0;
		
	OnBoard onboard(LEDR, HEX3, HEX2, HEX1, HEX0, SW, KEY, CLOCK_50);
	
	initial begin
	
		for (k = 1'b0; k < 2'd2; k = k + 1'b1) begin
			for (i = 5'd0; i < 5'b10000; i = i + 1'b1) begin
				for (j = 5'd0; j < 5'b10000; j = j + 1'b1) begin
					c_in = k[0];
					in_a = i[3:0];
					in_b = j[3:0];
					#100;	// wait 100 ns (prop delay)
					$display ("a + b + c_in = %d + %d + %d = %d carry %d", in_a, in_b, c_in, out, c_out);
					#100;	// wait 100 ns
				end
			end
		end
		
		#200;
		
		in_a = 4'd0;
		in_b = 4'd0;
		c_in = 1'b0;		
		#1000;
		
		in_a = 4'd15;
		in_b = 4'd2;
		c_in = 1'b1;			
		#100;
		in_a = 4'd14;
		in_b = 4'd14;
		c_in = 1'b0;			
		#100;
		in_a = 4'd10;
		in_b = 4'd10;
		c_in = 1'b0;			
		#100;
		in_a = 4'd1;
		in_b = 4'd11;
		c_in = 1'b1;			
		#100;
		in_a = 4'd0;
		in_b = 4'd1;
		c_in = 1'b1;			
		#100;
		in_a = 4'd0;
		in_b = 4'd6;
		c_in = 1'b0;			
		#100;
		
		
		
		$finish;
		
	end

endmodule