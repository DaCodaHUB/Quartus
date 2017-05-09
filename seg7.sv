module seg7 (bcd, leds1, leds2);
	input [4:0] bcd;
	output reg [6:0] leds1, leds2;
	
	always @(*)
		case (bcd)
			5'b10111: begin
							leds1 = ~7'b1000000;
							leds2 = ~7'b1101111; // -9							
						 end
			5'b11000: begin
							leds1 = ~7'b1000000;
							leds2 = ~7'b1111111; // -8
						 end
			5'b11001: begin
							leds1 = ~7'b1000000;
							leds2 = ~7'b0000111; // -7
						 end
			5'b11010: begin
							leds1 = ~7'b1000000;
							leds2 = ~7'b1111101; // -6
						 end
			5'b11011: begin
							leds1 = ~7'b1000000;
							leds2 = ~7'b1101101; // -5
						 end
			5'b11100: begin
							leds1 = ~7'b1000000;
							leds2 = ~7'b1100110; // -4
						 end
			5'b11101: begin
							leds1 = ~7'b1000000;
							leds2 = ~7'b1001111; // -3
						 end
			5'b11110: begin
							leds1 = ~7'b1000000;
							leds2 = ~7'b1011011; // -2
						 end
			5'b11111: begin
							leds1 = ~7'b1000000;
							leds2 = ~7'b0000110; // -1
						 end
			5'b00000: begin
							leds1 = ~7'b0111111;
							leds2 = ~7'b0111111; // 0
						 end
			5'b00001: begin
							leds1 = ~7'b0111111;
							leds2 = ~7'b0000110; // 1
						 end
			5'b00010: begin
							leds1 = ~7'b0111111;
							leds2 = ~7'b1011011; // 2
						 end
			5'b00011: begin
							leds1 = ~7'b0111111;
							leds2 = ~7'b1001111; // 3
						 end
			5'b00100: begin
							leds1 = ~7'b0111111;
							leds2 = ~7'b1100110; // 4
						 end
			5'b00101: begin
							leds1 = ~7'b0111111;
							leds2 = ~7'b1101101; // 5
						 end
			5'b00110: begin
							leds1 = ~7'b0111111;
							leds2 = ~7'b1111101; // 6
						 end
			5'b00111: begin
							leds1 = ~7'b0111111;
							leds2 = ~7'b0000111; // 7
						 end
			5'b01000: begin
							leds1 = ~7'b0111111;
							leds2 = ~7'b1111111; // 8
						 end
			5'b01001: begin
							leds1 = ~7'b0111111;
							leds2 = ~7'b1101111; // 9
						 end
			default: begin
							leds1 = 7'bX;
							leds2 = 7'bX;
						end
		endcase
endmodule
