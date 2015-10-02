// Yoel Ivan (yivan3@gatech.edu)


`timescale 1ns / 1ps

module nBit2InputMuxTester;

	reg [15:0] a, b;
	reg sel;
	
	wire [15:0] out;
	
	nBit2InputMux #(16) mux(out, sel, a, b);
	
	initial begin
		#100
		
		a = 16'hFFFF;
		b = 16'h0;
		sel = 1'b0;
		#100
		$display("SEL: %d\ta: %h\tb: %h\tout: %h\n", sel, a, b, out);
		
		sel = 1'b1;
		#100
		$display("SEL: %d\ta: %h\tb: %h\tout: %h\n", sel, a, b, out);
		
		a = 16'hABCD;
		b = 16'hDCBA;
		sel = 1'b0;
		#100
		$display("SEL: %d\ta: %h\tb: %h\tout: %h\n", sel, a, b, out);

		sel = 1'b1;
		#100
		$display("SEL: %d\ta: %h\tb: %h\tout: %h\n", sel, a, b, out);

		a = 16'h0101;
		b = 16'h5985;
		sel = 1'b0;
		#100
		$display("SEL: %d\ta: %h\tb: %h\tout: %h\n", sel, a, b, out);

		sel = 1'b1;
		#100
		$display("SEL: %d\ta: %h\tb: %h\tout: %h\n", sel, a, b, out);
		
		$stop;
		
	end
endmodule