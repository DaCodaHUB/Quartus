module Fred (HEX0, HEX1, HEX2, HEX3, LEDR, SW);
   output reg [6:0] HEX0, HEX1, HEX2, HEX3;
   output [9:0] LEDR;
   input [9:0] SW;
	
	assign LEDR[0] = (~SW[0] & SW[2] & SW[1]) | (~SW[2] & SW[0] & SW[1]) | 
	(~SW[1] & SW[0] & SW[2]);
	assign LEDR[1] = (~SW[3] & ~SW[0] & ~SW[1]) | (~SW[3] & ~SW[1] & SW[2]);
	
	always @(*)
		case (SW[2:0])
			3'b000: begin
						HEX3 = 7'b1111111;
					   HEX2 = 7'b0000000; // B 
					   HEX1 = 7'b0001000; // A 
					   HEX0 = 7'b1000010; // G 
					  end
			3'b001: begin 
						HEX3 = 7'b1111111;
						HEX2 = 7'b1000001; // U 
					   HEX1 = 7'b0010010; // S 
					   HEX0 = 7'b0000000; // B 
					  end
			3'b011: begin 
						HEX3 = 7'b1000000; // D 
			         HEX2 = 7'b1111001; // I 
					   HEX1 = 7'b1000110; // C 
					   HEX0 = 7'b0000110; // E 
					  end
			3'b100: begin 
						HEX3 = 7'b0000000; // B 
			         HEX2 = 7'b0001000; // A 
					   HEX1 = 7'b1000111; // L 
					   HEX0 = 7'b1000111; // L 
					  end
			3'b101: begin 
						HEX3 = 7'b1111111;
						HEX2 = 7'b1000110; // C 
					   HEX1 = 7'b0001000; // A 
					   HEX0 = 7'b1000111; // L 
					  end
			3'b110: begin
						HEX3 = 7'b0010010; // S 
			         HEX2 = 7'b1000000; // O 
					   HEX1 = 7'b1000001; // U 
					   HEX0 = 7'b0001100; // P 
					  end
			default: begin
						HEX3 = 7'bX;
			         HEX2 = 7'bX;
					   HEX1 = 7'bX;
					   HEX0 = 7'bX;
					  end
		endcase
endmodule

module Fred_testbench();
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire [9:0] LEDR;
	reg [3:0] KEY;
	reg [9:0] SW;

	Fred dut (.HEX0, .HEX1, .HEX2, .HEX3, .LEDR,	.SW);

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