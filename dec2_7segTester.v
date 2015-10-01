// Yoel Ivan (yivan3@gatech.edu)

`timescale 1ns / 1ps

module dec2_7segTester;
	
	reg [3:0] num;
	
	reg [5:0] j; // temp var for iteration
	
	wire [6:0] display;
	
	dec2_7seg conv(display, num);
	
	initial begin
		#100		
		for (j = 5'd0; j < 5'd10; j = j + 1'b1) begin
			num = j;
			#100;	// wait 100 ns (prop delay)
			$display("Decimal: %d 7Seg: %b\n", num, display);
			#100;	// wait 100 ns
		end		
		#200;
		
		num = 5'hF;
		#100;	// wait 100 ns (prop delay)
		$display("Decimal: %d 7Seg: %b\n", num, display);
		
		$stop;
		
	end
endmodule