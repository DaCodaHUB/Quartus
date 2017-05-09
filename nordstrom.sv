// Top-level module that defines the I/Os for the DE-1 SoC board

module nordstrom (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
   output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
   output [9:0] LEDR;
   input [3:0] KEY;
   input [9:0] SW;
	wire notOut1, notOut2, notOut3, notOut4, orOut1,
	orOut2, andOut1, andOut2, andOut3, andOut4, andOut5;
	
	// Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;

	not n1 (notOut1, SW[0]);
	not n2 (notOut2, SW[1]);
	not n3 (notOut3, SW[2]);
	not n4 (notOut4, SW[3]);
		
	and a1 (andOut1, notOut1, SW[1], SW[2]);
	and a2 (andOut2, SW[0], SW[1], notOut3);
	and a3 (andOut3, SW[0], notOut2, SW[2]);
	
	or o1 (orOut1, andOut1, andOut2);
	or o2 (orOut2, andOut2, andOut3);
	or o3 (LEDR[0], orOut1, orOut2);
	
	and a4 (andOut4, notOut2, notOut3, notOut4);
	and a5 (andOut5, SW[0], notOut2, notOut4);
	
	or o4 (LEDR[1], andOut4, andOut5);

endmodule

module nordstrom_testbench();
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire [9:0] LEDR;
	reg [3:0] KEY;
	reg [9:0] SW;

	nordstrom dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
	.SW);

// Try all combinations of inputs.
	integer i;
		initial begin
		SW[4] = 1'b0;
		SW[5] = 1'b0;
		SW[6] = 1'b0;
		SW[7] = 1'b0;
		SW[8] = 1'b0;
		SW[9] = 1'b0;
		for(i = 0; i <16; i++) begin
			SW[3:0] = i; #10;
		end
	end
endmodule