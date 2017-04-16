`timescale 1ns / 1ps

module SEGMENT(
		input clk100mhz,
		input rst,
		output ca,
		output cd,
		output cg,
		
		output an0,
		output an1,
		output an2,
		output an3,
		output an4,
		output an5,
		output an6,
		output an7
    );
	 
reg [31:0] count;
reg [7:0] an;
reg [2:0] seg;
reg ca,cd,cg;
reg an7,an6,an5,an4,an3,an2,an1,an0;


always@(posedge clk100mhz )	 
begin
		if(rst)begin
			count  <= 32'd0;
			an  <= 8'b11111110;
			seg <= 3'b110;
		end
		else if(count  == 32'd10_000_000) begin
				if(an == 8'b00000000)begin
					an  <= 8'b11111110;
					if(seg == 3'b011)
						seg <= 3'b110;
					else
						seg  <= (seg<<1)+1'b1;
				end
				else
					an  <= an-1'b1;
			{an7,an6,an5,an4,an3,an2,an1,an0} <= an;
			{cd,cg,ca} <= seg;
			count  <=  32'd0;
		end
		else
			count  <=  count + 1'b1;
end


endmodule
