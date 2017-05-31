`timescale 1ns / 1ps

module to7seg(
	input CLK100MHZ,
	input [3:0] dig0, dig1, dig2, dig3, dig4, dig5, dig6,
	output reg [7:0] an,
   output reg dp,
	output reg [6:0] seg
	);
	
	reg [13:0] count;
	reg [3:0] dec;
	
	always@(posedge CLK100MHZ)
	begin
		if(count[13:11]==3'b111)
			count = 14'b0;
		else
			count = count + 1;
	end
	
	always@(posedge CLK100MHZ)
	begin
		case (count[13:11])
			4'd0:
			begin
				dec=dig0;
				an=8'b10111111;
				dp=0;
			end
			4'd1:
			begin
				dec=dig1;
				an=8'b11011111;
				dp=1;
			end
			4'd2:
			begin
				dec=dig2;
				an=8'b11101111;
			end
			4'd3:
			begin
				dec=dig3;
				an=8'b11110111;
			end
			4'd4:
			begin
				dec=dig4;
				an=8'b11111011;
			end
			4'd5:
			begin
				dec=dig5;
				an=8'b11111101;
			end
			4'd6:
			begin
				dec=dig6;
				an=8'b11111110;
			end
		endcase
		
		case (dec)
			4'd0: seg = 7'b1000000;
			4'd1: seg = 7'b1111001;
			4'd2: seg = 7'b0100100;
			4'd3: seg = 7'b0110000;
			4'd4: seg = 7'b0011001;
			4'd5: seg = 7'b0010010;
			4'd6: seg = 7'b0000010;
			4'd7: seg = 7'b1111000;
			4'd8: seg = 7'b0000000;
			4'd9: seg = 7'b0011000;
		endcase
	end

endmodule
