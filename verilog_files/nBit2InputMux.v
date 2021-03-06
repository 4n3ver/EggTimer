// Yoel Ivan (yivan3@gatech.edu)

module nBit2InputMux(out, sel, in0, in1);
	parameter n = 8;
	
	input sel;
	input [(n - 1):0] in0, in1;
	
	output [(n - 1):0] out;
	
	reg [(n - 1):0] rOut;
	
	assign out = rOut;
	
	always@(sel) begin
		if (sel) begin
			rOut = in1;
		end
		else begin
			rOut = in0;		
		end
	end 

endmodule