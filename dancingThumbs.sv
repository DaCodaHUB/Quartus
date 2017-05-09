module dancingThumbs (CLOCK_50, HEX0, HEX1, HEX8, HEX9, KEY, LEDR, SW);
	input CLOCK_50; // 50MHz clock.
	output [6:0] HEX0, HEX1, HEX8, HEX9;
	output [9:0] LEDR;
	input [3:0] KEY;
	input [9:0] SW;
	reg [4:0] count, count1, count2, count3, count4, count5, count6;
	reg tick1, tick2, tick3, tick4;
	reg hold1, hold2, hold3, hold4;
	reg restart;
	
//	// Generate clk off of CLOCK_50, whichClock picks rate.
//	wire [31:0] clk;
//	parameter whichClock = 8;
//	clock_divider cdiv (CLOCK_50, clk);
//	
	wire [8:0] random;
	//wire [9:0] check;
	wire [4:0] column1, column2, column3, column4;
	wire spot1, spot2, spot3, spot4;
	wire [1:0] play1, play2, play3, play4;

//	assign restart = 1'b0;
//	assign hold = (column1 == 5'b00000) || (column2 == 5'b00000) || 
//						(column3 == 5'b00000) || (column4 == 5'b00000);
	assign hold1 = (column1 == 5'b00000);
	assign hold2 = (column2 == 5'b00000);
	assign hold3 = (column3 == 5'b00000);
	assign hold4 = (column4 == 5'b00000);

	assign restart = (count >= 5'd9) && (count <= 5'd23);
	assign LEDR[4:0] = column1;
	assign LEDR[9:5] = column2;
	
	LFSR r (.Clock(CLOCK_50), .Reset(SW[9]), .q(random));
	
	press pp1  (.Clock(CLOCK_50) , .pressed(hold1)	  , .pull(tick1) , .stop(restart));
	press pp2  (.Clock(CLOCK_50) , .pressed(hold2)	  , .pull(tick2) , .stop(restart));
	press pp3  (.Clock(CLOCK_50) , .pressed(hold3)	  , .pull(tick3) , .stop(restart));
	press pp4  (.Clock(CLOCK_50) , .pressed(hold4)	  , .pull(tick4) , .stop(restart));
	press p1 (.Clock(CLOCK_50) , .pressed(~KEY[0]), .pull(spot1), .stop(restart));
	press p2 (.Clock(CLOCK_50) , .pressed(~KEY[1]), .pull(spot2), .stop(restart));
	press p3 (.Clock(CLOCK_50) , .pressed(~KEY[2]), .pull(spot3), .stop(restart));
	press p4 (.Clock(CLOCK_50) , .pressed(~KEY[3]), .pull(spot4), .stop(restart));
	
	oneBank o1 (.Clock(CLOCK_50), .Reset(SW[9]), .speed(SW[1:0]), .start(random[0]), .out(column1), .stop(restart));
	oneBank o2 (.Clock(CLOCK_50), .Reset(SW[9]), .speed(SW[1:0]), .start(random[5]), .out(column2), .stop(restart));
	oneBank o3 (.Clock(CLOCK_50), .Reset(SW[9]), .speed(SW[1:0]), .start(random[7]), .out(column3), .stop(restart));
	oneBank o4 (.Clock(CLOCK_50), .Reset(SW[9]), .speed(SW[1:0]), .start(random[2]), .out(column4), .stop(restart));
	
	checkOnPoint c1 (.Clock(CLOCK_50), .Reset(SW[9] || restart), .in(spot1), .allOff(tick1), .harder(SW[2]), .column(column1), .point(play1), .stop(terminate));
	checkOnPoint c2 (.Clock(CLOCK_50), .Reset(SW[9] || restart), .in(spot2), .allOff(tick2), .harder(SW[2]), .column(column2), .point(play2), .stop(terminate));
	checkOnPoint c3 (.Clock(CLOCK_50), .Reset(SW[9] || restart), .in(spot3), .allOff(tick3), .harder(SW[2]), .column(column3), .point(play3), .stop(terminate));
	checkOnPoint c4 (.Clock(CLOCK_50), .Reset(SW[9] || restart), .in(spot4), .allOff(tick4), .harder(SW[2]), .column(column4), .point(play4), .stop(terminate));
	score s1 (.Clock(CLOCK_50), .Reset(SW[9]), .onPoint(play1), .out(count1), .stop(restart));
	score s2 (.Clock(CLOCK_50), .Reset(SW[9]), .onPoint(play2), .out(count2), .stop(restart));
	score s3 (.Clock(CLOCK_50), .Reset(SW[9]), .onPoint(play3), .out(count3), .stop(restart));
	score s4 (.Clock(CLOCK_50), .Reset(SW[9]), .onPoint(play4), .out(count4), .stop(restart));
	//score s2 (.Clock(CLOCK_50), .Reset(SW[9]), .out(countR), .stop(max));
	
	add5bits aa1 (.A(count1), .B(count2), .out(count5), .stop(restart), .E(1'b0));
	add5bits aa2 (.A(count3), .B(count4), .out(count6), .stop(restart), .E(1'b0));
	add5bits aa3 (.A(count5), .B(count6), .out(count), .stop(restart), .E(1'b0));
	//add5bits (.A(count3), .B(count4), .out(count), .stop(max || min), .E(1'b0));
	
	seg7 display1 (count, HEX1, HEX0);
	//seg7 display1 (count2, HEX9, HEX8);
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

module dancingThumbs_testbench(); //CLOCK_50, KEY, SW, LEDR, HEX0
	reg CLOCK_50;
	reg [9:0] LEDR;
	reg [6:0] HEX0, HEX1;
	reg [9:0] SW;
	reg [3:0] KEY;
	dancingThumbs dut(CLOCK_50, HEX0, HEX1, HEX8, HEX9, KEY, LEDR, SW);
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
		SW[9] <= 1;											@(posedge CLOCK_50);
		SW[9] <= 0; 	KEY[0] <= 0;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							SW[1:0] <= 2'b11;				@(posedge CLOCK_50);
							SW[2]	<= 1'B0;					@(posedge CLOCK_50);
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
							KEY[0] <= 1;					@(posedge CLOCK_50);
							KEY[0] <= 0;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
							KEY[0] <= 0;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
							KEY[0] <= 0;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
							KEY[0] <= 0;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
							KEY[0] <= 0;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
							KEY[0] <= 0;					@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
							KEY[0] <= 1;					@(posedge CLOCK_50);
							KEY[0] <= 0;					@(posedge CLOCK_50);
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
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);

							$stop;
	end
endmodule
