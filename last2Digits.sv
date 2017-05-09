// Top-level module that defines the I/Os for the DE-1 SoC board

module last2Digits (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
   output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
   output [9:0] LEDR;
   input [3:0] KEY;
   input [9:0] SW;
	wire notOut1, notOut2, notOut3, notOut4, notOut5, notOut6, 
	andOut1, andOut2;
	
	// Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;

	// Logic to check if SW[3]..SW[0] match your bottom digit,
	// and SW[7]..SW[4] match the next.
	// Result should drive LEDR[0].
	not n1 (notOut1, SW[0]);
	not n2 (notOut2, SW[3]);
	
	and addUp1 (andOut1, notOut1, SW[1], SW[2], notOut2);
	
	not n3 (notOut3, SW[4]);
	not n4 (notOut4, SW[5]);
	not n5 (notOut5, SW[6]);
	not n6 (notOut6, SW[7]);
	
	and addUp2 (andOut2, notOut3, notOut4, notOut5, notOut6);
	
	and andOut3 (LEDR[0], andOut1, andOut2);

endmodule

module last2Digits_testbench();
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire [9:0] LEDR;
	reg [3:0] KEY;
	reg [9:0] SW;

	last2Digits dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
	.SW);

// Try all combinations of inputs.
	integer i;
		initial begin
		SW[9] = 1'b0;
		SW[8] = 1'b0;
		for(i = 0; i <256; i++) begin
			SW[7:0] = i; #10;
		end
	end
endmodule