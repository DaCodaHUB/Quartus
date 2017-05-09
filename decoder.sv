module decoder (bin_in, dec_out);
	input [2:0] bin_in  ;
	output reg [4:0] dec_out ;

	always @ (bin_in)
	begin
		dec_out = 8'b0;
		case (bin_in)
			0 : dec_out = 5'b00001;
			1 : dec_out = 5'b00010;
			2 : dec_out = 5'b00100;
			3 : dec_out = 5'b01000;
			4 : dec_out = 5'b10000;
			5 : dec_out = 5'b00000;
//			5 : dec_out = 8'b00100000;
//			6 : dec_out = 8'b01000000;
//			7 : dec_out = 8'b10000000;
			default: dec_out = 5'bX;
		endcase
	end
endmodule