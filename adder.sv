module adder (A, B, CI, CO, S, E);
	input A,B,CI,E;
	output S,CO;
	wire Bs;

	assign Bs = B ^ E;
	assign CO = ( A & Bs ) |  ( CI & ( A | Bs ) );
	assign S = (A^Bs)^CI;
endmodule

module adder_testbench();
	wire Out, Cout;
	reg A, B, Cin;
	
	adder dut(A, B, Cin, Cout, Out);
	
	parameter d = 20;
	
	initial begin
		A = 0;
		B = 0;
		Cin = 0;
	end
	
	reg [3:0] i;
	initial begin
	#d; 
		for(i = 0; ~i[3]; i = i + 1) begin
			{A, B, Cin} = i[2:0];
			#d;
		end
	end
endmodule