module tugOfWar (CLOCK_50, HEX0, KEY, LEDR, SW);
	input CLOCK_50; // 50MHz clock.
	output [6:0] HEX0;
	output [9:0] LEDR;
	input [3:0] KEY;
	input [9:0] SW;
	reg [6:0] ps;
	reg [6:0] ns;
	parameter[6:0] player2 = 7'b0100100, player1 = 7'b1111001, none = 7'b1111111;
	wire left, right;
	
	press p1 (.Clock(CLOCK_50) , .pressed(~KEY[3]), .pull(left));
	press p2 (.Clock(CLOCK_50) , .pressed(~KEY[0]), .pull(right));
	
	normalLight l1(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[2]),.NR(1'b0), .lightOn(LEDR[1]));
	normalLight l2(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[3]),.NR(LEDR[1]),.lightOn(LEDR[2]));
	normalLight l3(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[4]),.NR(LEDR[2]),.lightOn(LEDR[3]));
	normalLight l4(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[5]),.NR(LEDR[3]),.lightOn(LEDR[4]));
	centerLight l5(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[6]),.NR(LEDR[4]),.lightOn(LEDR[5]));
	normalLight l6(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[7]),.NR(LEDR[5]),.lightOn(LEDR[6]));
	normalLight l7(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[8]),.NR(LEDR[6]),.lightOn(LEDR[7]));
	normalLight l8(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[9]),.NR(LEDR[7]),.lightOn(LEDR[8]));
	normalLight l9(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(1'b0),   .NR(LEDR[8]),.lightOn(LEDR[9]));
	
	always @(*)
		case(ps)
			player2: ns = player2;
			player1: ns = player1;
			none: if(LEDR[9] && left) ns = player2;
			else if(LEDR[1] && right) ns = player1;
			else ns = none;
		endcase
		assign HEX0 = ps;
		
	always @(posedge CLOCK_50)
		if(SW[9])
			ps <= none;
		else
			ps <= ns;
endmodule