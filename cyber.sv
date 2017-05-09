module cyber (Clock, Reset, pressed, pull, stop);
	input Clock, Reset, pressed, stop;
	output reg pull;
	reg ps, ns;
	
	always @(*)
		ns = pressed;
		
	always @(posedge Clock)
		if (Reset)
			ps <= 1'b0;
		else
			ps <= ns;
	
	always @(*)
	if (stop) pull = 1'b0;
	else pull = (~ps & ns);

endmodule

module cyber_testbench();
		reg CLOCK_50, Reset, pressed; 
		reg [2:0] count;
		wire out;
		cyber dut (CLOCK_50, Reset, pressed, pull, count);
		
		// Set up the clock.
		parameter CLOCK_PERIOD = 100;
		initial CLOCK_50 = 1;
		always begin
			#(CLOCK_PERIOD/2);
			CLOCK_50 = ~CLOCK_50;
		end

		initial begin
		   count <= 3'b000;				 @(posedge CLOCK_50);
			Reset <= 1; pressed<= 1;	 @(posedge CLOCK_50);
			Reset <= 0;						 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
							pressed<= 0;	 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
							pressed<= 1;  	 @(posedge CLOCK_50);
												 @(posedge CLOCK_50);
			$stop;
		end
endmodule