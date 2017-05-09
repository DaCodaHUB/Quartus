module add4bits (A, B, out, stop, E);
	input stop, E;
	input [3:0] A, B;
	//input clk, Reset;
	output reg [3:0] out;
	wire [3:0]C, S;
	
	adder a1 (A[0],B[0], E,C[0],S[0], E);
	adder a2 (A[1],B[1],C[0],C[1],S[1], E);
	adder a3 (A[2],B[2],C[1],C[2],S[2], E);
	adder a4 (A[3],B[3],C[2],C[3],S[3], E);
	
	always @(*)
		if (stop == 1'b1) out = A;
		else out = S;
	
endmodule