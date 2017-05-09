module winner (Clock, Reset, lastLED, defeat, out);
	input Clock, Reset, lastLED, defeat;
	output reg[6:0] out;
	reg [2:0] ps, ns;
	
	//parameter[6:0] leftWin = 7'b0100100, rightWin = 7'b1111001, none = 7'b1111111;
	
	always @(*)
		if(lastLED && defeat) ns = ns + 1;
		seg7 display (ps, out);
	
	always @(posedge Clock)
		if(Reset && (ps == 3'b111))
			begin 
				ps <= 3'b0;
			end
		else
			ps <= ns;
			
endmodule

module winner_testbench();
		reg CLOCK_50, lastLED, defeat, Reset;
		reg [6:0] win;
		wire out;
		
		// Set up the clock.
		winner dut (CLOCK_50, lastLED, defeat, out);
		parameter CLOCK_PERIOD=100;
		initial CLOCK_50=1;
		
		always begin
			#(CLOCK_PERIOD/2);
			CLOCK_50 = ~CLOCK_50;
		end

		initial begin
		Reset <= 1; 						 @(posedge CLOCK_50);
		Reset <= 0; 	defeat <= 0;	 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
							defeat <= 1; 	 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
							lastLED <= 0; 	 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
							lastLED <= 1;	 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
				$stop;
				end
endmodule