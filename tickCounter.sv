module tickCounter (Clock, Reset, speed, tick);
	input  Clock, Reset;
	input  [1:0] speed;
	reg [15:0] counter_up_time;
	output reg tick;

	always @ (posedge Clock)
	begin
		if (Reset)
			counter_up_time<=0;
		else 
			case (speed)
				2'b00: begin
							if (counter_up_time<29999) begin
								tick = 1'b0;
								counter_up_time<=counter_up_time+1;
							end
							else begin
								counter_up_time<=0;
								tick = 1'b1;
							end
						end
				2'b01: begin
							if (counter_up_time<24999) begin
								tick = 1'b0;
								counter_up_time<=counter_up_time+1;
							end
							else begin
								counter_up_time<=0;
								tick = 1'b1;
							end
						end
				2'b10: begin
							if (counter_up_time<19999) begin
								tick = 1'b0;
								counter_up_time<=counter_up_time+1;
							end
							else begin
								counter_up_time<=0;
								tick = 1'b1;
							end
						end
				2'b11: begin
							if (counter_up_time<14999) begin
								tick = 1'b0;
								counter_up_time<=counter_up_time+1;
							end
							else begin
								counter_up_time<=0;
								tick = 1'b1;
							end
						end
			endcase
		end
endmodule