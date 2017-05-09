module press (Clock, pressed, pull, stop);
	input Clock, stop;
	input pressed;
	output reg pull;
	reg ps;
	reg ns;
	
	always @(*)
		ns = pressed;
		
	always @(posedge Clock)
		ps <= ns;
	
	always @(*)
	if (stop) pull = 1'b0;
	else pull = (~ps & ns);

endmodule

module press_testbench();
		reg CLOCK_50, pressed, pull;
		wire out;
		press dut (CLOCK_50, pressed, pull);
		
		// Set up the clock.
		parameter CLOCK_PERIOD = 100;
		initial CLOCK_50 = 1;
		always begin
			#(CLOCK_PERIOD/2);
			CLOCK_50 = ~CLOCK_50;
		end

		initial begin
			pressed<= 1;	 @(posedge CLOCK_50);
			pressed<= 0;	 @(posedge CLOCK_50);
			pressed<= 0;	 @(posedge CLOCK_50);
								 @(posedge CLOCK_50);
							  	 @(posedge CLOCK_50);
			pressed<= 1;  	 @(posedge CLOCK_50);
								 @(posedge CLOCK_50);
			$stop;
		end
endmodule