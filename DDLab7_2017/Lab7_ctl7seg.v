`timescale 1ns / 1ps

module ctl7seg(
	input clk,
	input [7:0] a, b,
	input [15:0] result,
	input [1:0] op,
	
	output [7:0] spctl,
	output [6:0] sledctl
	);
	
	reg [7:0] spctl;
	reg [6:0] sledctl;
	reg [11:0] count;
	reg [4:0] tmpin;
	reg dr;
	
	always@(posedge clk)
	begin
		case (count)
			12'b111111111111 : count <= 12'b0;
			default : count <= count +1;
		endcase
	end
	

	always@(posedge clk)
	begin
		if(op==0)
		begin
			dr=0;
			case (count[11:9])
			3'b000 : tmpin = b % 10;
			3'b001 : tmpin = b / 10 % 10;
			3'b010 : tmpin = b / 100;
			3'b100 : tmpin = a % 10;
			3'b101 : tmpin = a / 10 % 10;
			3'b110 : tmpin = a / 100;
			default : tmpin = 4'b1111;
			endcase
			
		end
		if(op==1)
		begin
			dr=1;
			case (count[11:9])
			3'b000 : tmpin = result % 10;
			3'b001 : tmpin = result / 10 % 10;
			3'b010 : tmpin = result / 100 % 10;
			3'b011 : tmpin = result / 1000 % 10;
			3'b100 : tmpin = result / 10000;
			default : tmpin = 4'b1111;
			endcase
		end
	end
	
	always@(posedge clk)
	begin
		case(tmpin)
		0 : sledctl <= 7'b1000000;
		1 : sledctl <= 7'b1111001;
		2 : sledctl <= 7'b0100100;
		3 : sledctl <= 7'b0110000;
		4 : sledctl <= 7'b0011001;
		5 : sledctl <= 7'b0010010;
		6 : sledctl <= 7'b0000010;
		7 : sledctl <= 7'b1111000;
		8 : sledctl <= 7'b0000000;
		9 : sledctl <= 7'b0010000;
		default : sledctl <= 7'b1111111;
	endcase
	
	case({dr,count[11:9]})
		4'b1000 : spctl <= 8'b11111110;
		4'b1001 : spctl <= 8'b11111101;
		4'b1010 : spctl <= 8'b11111011;
		4'b1011 : spctl <= 8'b11110111;
		4'b1100 : spctl <= 8'b11101111;
		4'b0000 : spctl <= 8'b11111110;
		4'b0001 : spctl <= 8'b11111101;
		4'b0010 : spctl <= 8'b11111011;
		4'b0100 : spctl <= 8'b11101111;
		4'b0101 : spctl <= 8'b11011111;
		4'b0110 : spctl <= 8'b10111111;
		default : spctl <= 8'b11111111;
	endcase
end
endmodule
