module traffic (clk, reset, w, out); 
	output reg [2:0] out; 
	input clk, reset;
	input [1:0] w; 

	reg [2:0] ps; // Present State 
	reg [2:0] ns; // Next State
 
	// State encoding. 
	parameter [2:0] A = 3'b101, B = 3'b001, C = 3'b010, D = 3'b100; 
	
	// Next State logic 
	always @(*) 
	case (w)
		2'b00: begin
					if (ps == A) ns = C;
					else ns = A;
				end
		2'b01: begin
					if (ps == B) ns = C;
					else if (ps == C) ns = D;
					else ns = B;
				end
		2'b10: begin
					if (ps == D) ns = C;
					else if (ps == C) ns = B;
					else	ns = D;
				end
		default: ns = 2'bxx; 
	endcase 
	
	assign out = ps;
	
	// DFFs 
	always @(posedge clk) 
	if (reset) 
		ps <= C;
	else 
		ps <= ns; 
		
endmodule

//module traffic_testbench();
//	wire [2:0] out;
//	reg clk, reset;
//	reg [1:0] w;
//	
//	traffic dut (clk, reset, w, out);
//	
//	// Set up the clock.
//	parameter CLOCK_PERIOD=100;
//	initial clk=1;
//	always begin
//		#(CLOCK_PERIOD/2);
//		clk = ~clk;
//	end
//	
//	// Set up the inputs to the design. Each line is a clock cycle.
//	initial begin
//		reset <= 1; w <= 2'b00;		@(posedge clk);
//		reset <= 0; 				 	@(posedge clk);
//						w <= 2'b10; 	@(posedge clk);											
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//						w <= 2'b01; 	@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//						w <= 2'b00; 	@(posedge clk);
//											@(posedge clk);
//						w <= 2'b01;		@(posedge clk);
//						w <= 2'b10;		@(posedge clk);
//											@(posedge clk);
//						w <= 2'b00; 	@(posedge clk);
//		$stop; // End the simulation.
//	end
//endmodule