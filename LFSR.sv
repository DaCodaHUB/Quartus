module LFSR (Clock, Reset, q);
	input Clock, Reset;
	output [8:0]q;
	wire r;

	assign r = q[4] ^~ q[8];
	flipFlop ff1 (q[0], r, Reset, Clock);
	flipFlop ff2 (q[1], q[0], Reset, Clock);
	flipFlop ff3 (q[2], q[1], Reset, Clock);
	flipFlop ff4 (q[3], q[2], Reset, Clock);
	flipFlop ff5 (q[4], q[3], Reset, Clock);
	flipFlop ff6 (q[5], q[4], Reset, Clock);
	flipFlop ff7 (q[6], q[5], Reset, Clock);
	flipFlop ff8 (q[7], q[6], Reset, Clock);
	flipFlop ff9 (q[8], q[7], Reset, Clock);

endmodule

module flipFlop (Q, D, Reset, clk);
	output Q;
	input D, Reset, clk;
	reg Q;
	
	always @(posedge clk)
	if (Reset)
		Q <= 0;
	else
		Q <= D;
endmodule

module LFSR_testbench();
		reg CLOCK_50, Reset;
		reg [9:1] q;
		wire out;
		LFSR dut (CLOCK_50, Reset, q);
		
		// Set up the clock.
		parameter CLOCK_PERIOD = 100;
		initial CLOCK_50 = 1;
		always begin
			#(CLOCK_PERIOD/2);
			CLOCK_50 = ~CLOCK_50;
		end

		initial begin
			Reset <= 1;	 @(posedge CLOCK_50);
			Reset <= 0;	 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
						  	 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
							 @(posedge CLOCK_50);
			$stop;
		end
endmodule