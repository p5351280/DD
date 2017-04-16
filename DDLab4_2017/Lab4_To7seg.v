`timescale 1ns / 1ps

module Lab4_To7seg(count, din, d7segp, d7segv);
	input [2:0]count;
	input [3:0]din;
	output reg [7:0]d7segp;
	output reg [6:0]d7segv;
	
	always @ (*)
	begin
		case (count)
			3'd0 : d7segp <= 8'b11111110;
			3'd1 : d7segp <= 8'b11111101;
			3'd2 : d7segp <= 8'b11111011;
			3'd3 : d7segp <= 8'b11110111;
			3'd4 : d7segp <= 8'b11101111;
			3'd5 : d7segp <= 8'b11011111;
			3'd6 : d7segp <= 8'b10111111;
			3'd7 : d7segp <= 8'b01111111;
			default : d7segp <= 8'b11111111;
		endcase
	
		case (din)
			4'd0 : d7segv <= 7'b1000000;
			4'd1 : d7segv <= 7'b1111001;
			4'd2 : d7segv <= 7'b0100100;
			4'd3 : d7segv <= 7'b0110000;
			4'd4 : d7segv <= 7'b0011001;
			4'd5 : d7segv <= 7'b0010010;
			4'd6 : d7segv <= 7'b0000010;
			4'd7 : d7segv <= 7'b1111000;
			4'd8 : d7segv <= 7'b0000000;
			4'd9 : d7segv <= 7'b0010000;
			default : d7segv <= 7'b1111111;
		endcase
	end
endmodule
