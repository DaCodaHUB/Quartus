module centerLight (Clock, Reset, L, R, NL, NR, lightOn);
	input Clock, Reset;
	
	 // L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	input L, R, NL, NR;
	reg ns;
	reg ps;
	
	// when lightOn is true, the center light should be on.
	output lightOn;
	parameter  on = 1'b1, off = 1'b0;
	
	always @(*)
	case(ps) 
		on: if((L)||(R))ns = off;
			else ns = on;
		off: if((L && NR)||(R && NL)) ns = on;
				else ns = off;
		default: ns = 1'bx;
	endcase
	
	assign lightOn = (ps == on);
	
	always @(posedge Clock)
		if (Reset)
			ps <= on;
		else
			ps <= ns;

endmodule

module centerLight_testbench();
	reg clk, reset;
	wire out;
	wire [9:0] LEDR;
	wire [3:0] KEY;
	wire [6:0] HEX;
	reg [9:0] SW;	
	reg NL, NR, L, R;
	centerLight dut(.Clock(clk), .Reset(reset), .L(L), .R(R), .NL(NL), .NR(NR), .lightOn(LEDR[5]));

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
			#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin

		reset <= 1; L <= 1;		@(posedge clk);
		reset <= 0;					@(posedge clk);
										@(posedge clk);
						NR <= 1;		@(posedge clk);
										@(posedge clk);
										@(posedge clk);
						NR <= 0;		@(posedge clk);
										@(posedge clk);
										@(posedge clk);
						L <= 0;		@(posedge clk);
										@(posedge clk);					
						R <= 1;		@(posedge clk);
										@(posedge clk);
						NL <= 1; 	@(posedge clk);
										@(posedge clk);
						NL <= 0;		@(posedge clk);
										@(posedge clk);
										@(posedge clk);
						R <= 0;		@(posedge clk);
										@(posedge clk);	
		$stop;
	end
endmodule