module cyberWar (CLOCK_50, HEX0, HEX1, KEY, LEDR, SW);
	input CLOCK_50; // 50MHz clock.
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [9:0] LEDR;
	input [3:0] KEY;
	input [9:0] SW;
	reg [2:0] countL, countR;
	
	//parameter[6:0] player2 = 7'b0100100, player1 = 7'b1111001, none = 7'b1111111;
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	//wire [31:0] clk;
	//parameter whichClock = 25;
	//clock_divider cdiv (CLOCK_50, clk);
	
	wire left, right, restart, max;
	wire [9:0] check, checkInc;
	wire [8:0] random;
	
	assign restart = (LEDR[9] && left) || (LEDR[1] && right) || SW[9];
	assign max = (countL == 3'b111) || (countR == 3'b111);
	
	LFSR r (.Clock(CLOCK_50), .Reset(SW[9]), .q(random));
	add9bits aa (random, SW[8:0], check, max);
	add9bits aa1 (check[8:0], 9'b000000001, checkInc, max);
	
	cyber c (.Clock(CLOCK_50), .Reset(restart), .pressed(checkInc[9]), .pull(left));
	press p (.Clock(CLOCK_50) , .pressed(~KEY[0]), .pull(right));
	
	normalLight l1(.Clock(CLOCK_50), .Reset(restart),.L(left),.R(right), .NL(LEDR[2]),.NR(1'b0),	.lightOn(LEDR[1]));
	normalLight l2(.Clock(CLOCK_50), .Reset(restart),.L(left),.R(right), .NL(LEDR[3]),.NR(LEDR[1]),.lightOn(LEDR[2]));
	normalLight l3(.Clock(CLOCK_50), .Reset(restart),.L(left),.R(right), .NL(LEDR[4]),.NR(LEDR[2]),.lightOn(LEDR[3]));
	normalLight l4(.Clock(CLOCK_50), .Reset(restart),.L(left),.R(right), .NL(LEDR[5]),.NR(LEDR[3]),.lightOn(LEDR[4]));
	centerLight l5(.Clock(CLOCK_50), .Reset(restart),.L(left),.R(right), .NL(LEDR[6]),.NR(LEDR[4]),.lightOn(LEDR[5]));
	normalLight l6(.Clock(CLOCK_50), .Reset(restart),.L(left),.R(right), .NL(LEDR[7]),.NR(LEDR[5]),.lightOn(LEDR[6]));
	normalLight l7(.Clock(CLOCK_50), .Reset(restart),.L(left),.R(right), .NL(LEDR[8]),.NR(LEDR[6]),.lightOn(LEDR[7]));
	normalLight l8(.Clock(CLOCK_50), .Reset(restart),.L(left),.R(right), .NL(LEDR[9]),.NR(LEDR[7]),.lightOn(LEDR[8]));
	normalLight l9(.Clock(CLOCK_50), .Reset(restart),.L(left),.R(right), .NL(1'b0),   .NR(LEDR[8]),.lightOn(LEDR[9]));
	
	counter c1 (.Clock(CLOCK_50), .Reset(SW[9]), .lastLED(left) , .defeat(LEDR[9]), .out(countL), .count(max));
	counter c2 (.Clock(CLOCK_50), .Reset(SW[9]), .lastLED(right), .defeat(LEDR[1]), .out(countR), .count(max));
	
	seg7 display1 (countL, HEX1);
	seg7 display2 (countR, HEX0);
	
endmodule

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,
//[25] = 0.75Hz, ...
//module clock_divider (clock, divided_clocks);
//	input clock;
//	output [31:0] divided_clocks;
//	reg [31:0] divided_clocks;
//	
//	initial
//		divided_clocks = 0;
//		
//	always @(posedge clock)
//		divided_clocks = divided_clocks + 1;
//endmodule

module cyberWar_testbench(); //CLOCK_50, KEY, SW, LEDR, HEX0
	reg CLOCK_50;
	reg [9:0] LEDR;
	reg [6:0] HEX0, HEX1;
	reg [9:0] SW;
	reg [3:0] KEY;
	cyberWar dut(CLOCK_50, HEX0, HEX1, KEY, LEDR, SW);
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial CLOCK_50=1;
	initial KEY[3:0]=4'b1111;
	
	always begin
			#(CLOCK_PERIOD/2);
		CLOCK_50 = ~CLOCK_50;
	end
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		SW[9] <= 1;		SW[8:0] = 9'b000010000;		@(posedge CLOCK_50);
		SW[9] <= 0; 	KEY[0] <= 0;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 0; 					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);		
							KEY[0] <= 0; 					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 0; 					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 0; 					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 0; 					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		$stop;
	end
endmodule