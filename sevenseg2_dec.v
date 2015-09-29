module sevenseg2_dec(num, display);
	
	input [6:0] display;
	
	output [3:0] num;
		
	assign num =	
			display	== ~7'b0111111 ? 0 :
			display	== ~7'b0000110 ? 1 :
			display	== ~7'b1011011 ? 2 :
			display	== ~7'b1001111 ? 3 :
			display	== ~7'b1100110 ? 4 :
			display	== ~7'b1101101 ? 5 :
			display	== ~7'b1111101 ? 6 :
			display	== ~7'b0000111 ? 7 :
			display	== ~7'b1111111 ? 8 :
			display	== ~7'b1100111 ? 9 :
			14;			//	Output	is	an E or error
			
endmodule