module score (Clock, Reset, onPoint, out, stop);
	input Clock, Reset, stop;
	input [1:0] onPoint;
	reg [4:0] ps, ns;
	output reg [4:0] out;
	wire [4:0] up2, up1, down2;
	
	add5bits a1 (ps, 5'b00010, up2, stop, 1'b0);
	add5bits a2 (ps, 5'b00001, up1, stop, 1'b0);
	add5bits a3 (ps, 5'b00010, down2, stop, 1'b1);
	
	always @(*) begin
		 case (onPoint)
			2'b10: ns = up2;
			2'b01: ns = up1;
			2'b11: ns = down2;
			default: ns = ps;
		 endcase
	end
	
	assign out = ps;
	
	always @(posedge Clock)
		if (Reset) 
			ps <= 5'b0;
		else
			ps <= ns;
endmodule

module score_testbench();
	reg clk, Reset;
	reg [1:0] test;
	wire [4:0] Out;

	score dut(clk, Reset, test, Out, stop);
	
	parameter CLOCK_PERIOD = 100;
	
	initial clk = 1; 
	always begin 
		#(CLOCK_PERIOD/2); 
		clk = ~clk; 
	end 
	
	initial begin 
		Reset <= 1; @(posedge clk); 
		Reset <= 0; @(posedge clk); 
						@(posedge clk); 
		test <= 2'b10;
						@(posedge clk);
						@(posedge clk);					
		test <= 2'b10;
						@(posedge clk);
						@(posedge clk);
		test <= 2'b10;
						@(posedge clk);
						@(posedge clk);					
		test <= 2'b10;
						@(posedge clk);
						@(posedge clk);
		test <= 2'b10;
						@(posedge clk); 
						@(posedge clk);
		Reset <= 1; @(posedge clk); 
		Reset <= 0; @(posedge clk); 
						@(posedge clk); 
		test <= 2'b11;
						@(posedge clk);
						@(posedge clk);					
		test <= 2'b11;
						@(posedge clk);
						@(posedge clk);
		test <= 2'b11;
						@(posedge clk);
						@(posedge clk);					
		test <= 2'b11;
						@(posedge clk);
						@(posedge clk);
		test <= 2'b11;
						@(posedge clk); 
						@(posedge clk);
		Reset <= 1; @(posedge clk); 
		Reset <= 0; @(posedge clk); 
						@(posedge clk); 
		test <= 2'b01;
						@(posedge clk);
						@(posedge clk);					
		test <= 2'b01;
						@(posedge clk);
						@(posedge clk);
		test <= 2'b01;
						@(posedge clk);
						@(posedge clk);					
		test <= 2'b01;
						@(posedge clk);
						@(posedge clk);
		test <= 2'b01;
						@(posedge clk); 
						@(posedge clk);
		$stop; 
	end
endmodule