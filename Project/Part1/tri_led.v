`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:53:16 05/30/2016 
// Design Name: 
// Module Name:    tri_led 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module tri_led(
	 clk100mhz,
	 btnc,
	 btnu,
	 btnl,
	 btnr,
	 btnd,
	 RGB1_Red,
	 RGB1_Green,
	 RGB1_Blue,
	 led
);


input clk100mhz;
input btnc;
input btnu;
input btnl;
input btnr;
input btnd;
output RGB1_Red;
output RGB1_Green;
output RGB1_Blue;
output [3:0] led;
reg [14:0] count_div;
reg [3:0] state;

reg [9:0] red;
reg [9:0] blue;
reg [9:0] green;
reg [1:0] op;
reg [1:0] ud;
reg [14:0] led;
reg Red_OUT1;
reg Green_OUT2;
reg Blue_OUT3;
reg temp;
reg temp2;
reg [14:0]light;

initial begin
	light<=700;
end
always@(posedge clk100mhz) begin
	case({btnl, btnc, btnr})
		3'b100 : op=1;
		3'b010 : op=2;
		3'b001 : op=3;
		default : begin
			op=0;
			temp=1;
		end
	endcase
	if(temp) begin
		case(op)
			2'd1 : state <= (state < 4'd6) ? state+4'd1 : state;
			2'd2 : state <= 4'b0011;
			2'd3 : state <= (state > 4'd0) ? state-4'd1 : state;
			default : state <= state;
		endcase
		if(op) temp=0;
	end
	case({btnu, btnd})
		2'b10 : ud=1;
		2'b01 : ud=2;
		default : begin
			ud=0;
			temp2=1;
		end
	endcase
	if(temp2) begin
		case(ud)
			2'd1 : light<=(light>15'd510)?light-200:light;
			2'd2 : light<=(light<15'd16384)?light+200:light;
			default:light<=light;
		endcase
		if(ud) temp2=0;
	end
	led <= light;
end

always@(posedge clk100mhz)	
begin
	count_div <= (count_div<=light) ? count_div + 14'd1 : 14'd0;
	Red_OUT1 <= (count_div<=red) ? 1 : 0;
	Green_OUT2 <= (count_div<=green) ? 1 : 0;
	Blue_OUT3 <= (count_div<=blue) ? 1 : 0;
end

always@(clk100mhz) begin
	case(state)
		4'd0:begin
			red <= 9'd255;
			green <= 9'd0;
			blue <= 9'd0;
		end
		4'd1:begin
			red <= 9'd255;
			green <= 9'd165;
			blue <= 9'd0;
		end
 		4'd2:  begin
			red <= 9'd255;
			green <= 9'd255;
			blue <= 9'd0;
		end
		4'd3:  begin
			red <= 9'd255;
			green <= 9'd255;
			blue <= 9'd255;
		end
		4'd4:  begin
			red <= 9'd0;
			green <= 9'd255;
			blue <= 9'd0;
		end
		4'd5:  begin
			red <= 9'd0;
			green <= 9'd0;
			blue <= 9'd255;
		end
		4'd6:  begin
			red <= 9'd160;
			green <= 9'd32;
			blue <= 9'd240;
		end
	endcase
end

assign RGB1_Red = (state == 4'd0) ? Red_OUT1 : (state == 4'd1)? Red_OUT1 : Red_OUT1;
assign RGB1_Green = (state == 4'd0) ? Green_OUT2 : (state == 4'd1)? Green_OUT2 : Green_OUT2;
assign RGB1_Blue = (state == 4'd0) ? Blue_OUT3 : (state == 4'd1)? Blue_OUT3 : Blue_OUT3; 


endmodule
