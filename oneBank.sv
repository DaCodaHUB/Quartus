module oneBank (Clock, Reset, speed, start, out, stop);
	input Clock, Reset, stop, start;
	input [1:0] speed;
	output reg [4:0] out;
	wire up;
	wire [2:0] inc, speed;
	wire [4:0] lights;

	cyber c (Clock, Reset, start, up, stop);
	decoder d (inc, lights);
	
	incLight i (Clock, Reset, up, speed, inc);
	
	assign out = lights;
endmodule

module oneBank_testbench();
	reg clk, Reset, stop;
	reg [8:0] addOn;
	wire [4:0] Out;

	oneBank dut (clk, Reset, speed, addOn, Out, stop);
	
	parameter CLOCK_PERIOD = 100;
	
	initial clk = 1; 
	always begin 
		#(CLOCK_PERIOD/2); 
		clk = ~clk; 
	end 
	
	initial begin 
		Reset <= 1;					 @(posedge clk); 
		Reset <= 0;				  	 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
	   addOn <= 9'b100000000; 	 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk);
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk);
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
										 @(posedge clk); 
		$stop; 
	end
endmodule