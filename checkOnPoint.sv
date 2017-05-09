module checkOnPoint (Clock, Reset, in, allOff, harder, column, point, stop);
	input Clock, Reset, in, stop, allOff, harder;
	input [4:0] column;
	reg [1:0] ns, ps;
	output reg [1:0] point;

	parameter [1:0] none = 2'b00, plus1 = 2'b01, plus2 = 2'b10, minus2 = 2'b11;
	
//	always @(column) begin
//		if (stop) point = 2'b00;
//		else begin
//				case(column) 
//					5'b00100: begin 
//									if (in) point = 2'b01;
//									else point = 2'b00;
//								 end
//					5'b01000: begin 
//									if (in) point = 2'b10;
//									else point = 2'b00;
//								 end
//					5'b10000: begin 
//									if (in) point = 2'b01;
//									else point = 2'b00;
//								 end
////					5'b00000:  begin 
////									if (allOff || in) point = 2'b11;
////									else point = 2'b00;
////								 end
//					default: begin
//									if (in) point = 2'b11;
//									else point = 2'b00;
//								end
//				endcase
//		end
//	end
	
	always @(*) begin	
		case (ps)
			none: if (in) begin
						if (column == 5'b01000) 
							ns = plus2;
						else if ((column == 5'b10000) || (column == 5'b00100)) 
							ns = plus1;
						else ns = minus2;
					end
					else begin 
						if (allOff && harder) ns = minus2;
						else ns = none;
					end
//					else 
//						ns = none;
			
			plus1: if (in) begin
						if (column == 5'b01000) 
							ns = plus2;
						else if ((column == 5'b10000) || (column == 5'b00100)) 
							ns = plus1;
						else ns = minus2;
					end
					else begin 
						if (allOff && harder) ns = minus2;
						else ns = none;
					end
//					else 
//						ns = none;
			
			plus2: if (in) begin
						if (column == 5'b01000) 
							ns = plus2;
						else if ((column == 5'b10000) || (column == 5'b00100)) 
							ns = plus1;
						else ns = minus2;
					end
					else begin 
						if (allOff && harder) ns = minus2;
						else ns = none;
					end
//					else 
//						ns = none;
			
			minus2: if (in) begin
						if (column == 5'b01000) 
							ns = plus2;
						else if ((column == 5'b10000) || (column == 5'b00100)) 
							ns = plus1;
						else ns = minus2;
					end
//					else begin 
//						if (allOff) ns = minus2;
//						else ns = none;
//					end
					else 
						ns = none;
		endcase
	end
		
	always @(posedge Clock)
		if (Reset)
			ps <= 2'b0;
		else
			ps <= ns;
	
	always @(*)
	if (stop) point = none;
	else point = ps;

endmodule
