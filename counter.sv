module counter (Clock, Reset, out, stop);
	input Clock, Reset, stop;
	reg [3:0] ps, ns;
	output reg [3:0] out;
	wire [3:0] up;
	
	add4bits a1 (ps, 4'b020, up2, count, 1'b0);
	add4bits a2 (ps, 4'b001, up1, count, 1'b0);
	add4bits a3 (ps, 4'b001, down1, count, 1'b1);
	
	always @(*)
		if (lastLED && defeat)
			ns = up;
		else
			ns = ps;
	
	assign out = ps;
	
	always @(posedge Clock)
		if (Reset) 
			ps <= 3'b0;
		else
			ps <= ns;
endmodule