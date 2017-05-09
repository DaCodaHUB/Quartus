module add9bits (A, B, S, stop);
	input stop;
	input [8:0] A, B;
	//input clk, Reset;
	output reg [9:0] S;
	//output reg Overflow;
	wire [8:0]C;

	//Overflow = C[8];

	adder a1 (A[0],B[0],0,C[0],S[0],0);
	adder a2 (A[1],B[1],C[0],C[1],S[1],0);
	adder a3 (A[2],B[2],C[1],C[2],S[2],0);
	adder a4 (A[3],B[3],C[2],C[3],S[3],0);
	adder a5 (A[4],B[4],C[3],C[4],S[4],0);
	adder a6 (A[5],B[5],C[4],C[5],S[5],0);
	adder a7 (A[6],B[6],C[5],C[6],S[6],0);
	adder a8 (A[7],B[7],C[6],C[7],S[7],0);
	adder a9 (A[8],B[8],C[7],C[8],S[8],0);
	
	always @(*)
		if (stop == 1'b1) S[9] = 1'b0;
		else S[9] = C[8];

endmodule

module add9bits_testbench();
	wire Out;
	reg [9:0] A, B;
	
	add9bits dut(A, B, Out);
	
	parameter d = 20;
	
	initial begin
		A = 0;
		B = 0;
	end
	
	reg [20:0] i;
	initial begin
	#d; 
		for(i = 0; ~i[20]; i = i + 1) begin
			{A, B} = i[19:0];
			#d;
		end
	end
endmodule

