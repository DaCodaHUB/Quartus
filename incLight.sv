module incLight (Clock, Reset, start, speed, out);
	input Clock, Reset, start;
	input [1:0] speed;
	reg [2:0] ps;
	output reg [2:0] out;
	wire tick;
	//wire tick = 1'b1;
	
	assign out = ps;
	
	tickCounter t (Clock, Reset, speed, tick);

	always @ (posedge Clock)
		if (Reset) 
			ps <= 5;
		else if (tick && ps < 5)
				ps <= ps + 1;
		else if (start && tick && ps == 5)
				ps <= 0;

endmodule

module incLight_testbench();
	reg clk, Reset, test, fast;
	wire [2:0] Out;

	incLight dut(clk, Reset, test, fast, Out);
	
	parameter CLOCK_PERIOD = 100;
	
	initial clk = 1; 
	always begin 
		#(CLOCK_PERIOD/2); 
		clk = ~clk; 
	end 
	
	initial begin 
		Reset <= 1;		 @(posedge clk); 	
		Reset <= 0; 	 @(posedge clk);
		                @(posedge clk); 
							 @(posedge clk); 
							 @(posedge clk); 
							 @(posedge clk); 
							 @(posedge clk); 
		test <= 1;		 @(posedge clk);
		test <= 0;		 @(posedge clk);
							 @(posedge clk);
							 @(posedge clk);
							 @(posedge clk);
							 @(posedge clk);
		$stop; 
	end
endmodule