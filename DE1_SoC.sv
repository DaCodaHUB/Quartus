// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW, GPIO_0);
	input CLOCK_50; // 50MHz clock.
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	output [35:0] GPIO_0;
	input [3:0] KEY; // True when not pressed, False when pressed
	input [9:0] SW;
	reg [4:0] count, count1, count2, count3, count4, count5, count6;
	reg tick1, tick2, tick3, tick4;
	reg hold1, hold2, hold3, hold4;
	reg restart, terminate;
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	wire [31:0] clk;
	parameter whichClock = 9;
	clock_divider cdiv (CLOCK_50, clk);
	
	wire last;
	wire [8:0] random;
	wire [4:0] column1, column2, column3, column4;
	wire spot1, spot2, spot3, spot4;
	wire [1:0] play1, play2, play3, play4;
	
	reg [7:0][7:0] green_array, red_array;

	assign terminate = 1'b0;
	assign restart = (count > 5'd9) && (count < 5'd23);
//	assign hold = (column1 == 5'b00000) || (column2 == 5'b00000) || 
//						(column3 == 5'b00000) || (column4 == 5'b00000);
	assign hold1 = (column1 == 5'b00000);
	assign hold2 = (column2 == 5'b00000);
	assign hold3 = (column3 == 5'b00000);
	assign hold4 = (column4 == 5'b00000);

	assign LEDR[4:0] = column1;
	assign LEDR[9:5] = column2;
	
	assign green_array[0][0] = column1[0];
	assign green_array[1][0] = column1[1];
	assign green_array[2][0] = column1[2];
	assign green_array[3][0] = column1[3];
	assign green_array[4][0] = column1[4];
	assign green_array[0][2] = column2[0];
	assign green_array[1][2] = column2[1];
	assign green_array[2][2] = column2[2];
	assign green_array[3][2] = column2[3];
	assign green_array[4][2] = column2[4];
	assign green_array[0][4] = column3[0];
	assign green_array[1][4] = column3[1];
	assign green_array[2][4] = column3[2];
	assign green_array[3][4] = column3[3];
	assign green_array[4][4] = column3[4];
	assign green_array[0][6] = column4[0];
	assign green_array[1][6] = column4[1];
	assign green_array[2][6] = column4[2];
	assign green_array[3][6] = column4[3];
	assign green_array[4][6] = column4[4];
	
	led_matrix_driver led (clk[whichClock], red_array, green_array, GPIO_0[27:20], GPIO_0[35:28], GPIO_0[19:12]);
	
	LFSR r (.Clock(clk[whichClock]), .Reset(SW[9]), .q(random));
	
	cyber cy1  (.Clock(clk[whichClock]) , .pressed(hold1)	  , .pull(tick1) , .stop(terminate));
	cyber cy2  (.Clock(clk[whichClock]) , .pressed(hold2)	  , .pull(tick2) , .stop(terminate));
	cyber cy3  (.Clock(clk[whichClock]) , .pressed(hold3)	  , .pull(tick3) , .stop(terminate));
	cyber cy4  (.Clock(clk[whichClock]) , .pressed(hold4)	  , .pull(tick4) , .stop(terminate));
	press p1 (.Clock(clk[whichClock]) , .pressed(~KEY[0]), .pull(spot1), .stop(terminate));
	press p2 (.Clock(clk[whichClock]) , .pressed(~KEY[1]), .pull(spot2), .stop(terminate));
	press p3 (.Clock(clk[whichClock]) , .pressed(~KEY[2]), .pull(spot3), .stop(terminate));
	press p4 (.Clock(clk[whichClock]) , .pressed(~KEY[3]), .pull(spot4), .stop(terminate));
	
	oneBank o1 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .speed(SW[1:0]), .start(random[0]), .out(column1), .stop(terminate));
	oneBank o2 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .speed(SW[1:0]), .start(random[5]), .out(column2), .stop(terminate));
	oneBank o3 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .speed(SW[1:0]), .start(random[7]), .out(column3), .stop(terminate));
	oneBank o4 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .speed(SW[1:0]), .start(random[2]), .out(column4), .stop(terminate));
	
	checkOnPoint c1 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .in(spot1), .allOff(tick1), .harder(SW[2]), .column(column1), .point(play1), .stop(terminate));
	checkOnPoint c2 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .in(spot2), .allOff(tick2), .harder(SW[2]), .column(column2), .point(play2), .stop(terminate));
	checkOnPoint c3 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .in(spot3), .allOff(tick3), .harder(SW[2]), .column(column3), .point(play3), .stop(terminate));
	checkOnPoint c4 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .in(spot4), .allOff(tick4), .harder(SW[2]), .column(column4), .point(play4), .stop(terminate));
	
	score s1 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .onPoint(play1), .out(count1), .stop(terminate));
	score s2 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .onPoint(play2), .out(count2), .stop(terminate));
	score s3 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .onPoint(play3), .out(count3), .stop(terminate));
	score s4 (.Clock(clk[whichClock]), .Reset(SW[9] || restart), .onPoint(play4), .out(count4), .stop(terminate));
	//score s2 (.Clock(CLOCK_50), .Reset(SW[9]), .out(countR), .stop(max));
	
	add5bits aa1 (.A(count1), .B(count2), .out(count5), .stop(terminate), .E(1'b0));
	add5bits aa2 (.A(count3), .B(count4), .out(count6), .stop(terminate), .E(1'b0));
	add5bits aa3 (.A(count5), .B(count6), .out(count) , .stop(terminate), .E(1'b0));
	//add5bits (.A(count3), .B(count4), .out(count), .stop(max || min), .E(1'b0));
	
	seg7 display1 (count, HEX1, HEX0);
	//seg7 display1 (count2, HEX9, HEX8);
endmodule

 //divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,
//[25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
	input clock;
	output [31:0] divided_clocks;
	reg [31:0] divided_clocks;
	
	initial
		divided_clocks = 0;
		
	always @(posedge clock)
		divided_clocks = divided_clocks + 1;
endmodule