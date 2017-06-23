`timescale 1ns / 1ps
module Part3(
    input btnu, 
	 input btnl,
	 input btnc,
	 input btnr,
	 input btnd,
	 input clk,

	 output [15:0] led
    );

reg [11:0] number;
reg [30:0] counter; 
reg [3:0] state;
reg [6:0] seg_number,seg_data;
reg [15:0] scan;
reg [30:0] freq;
reg [1:0] choose;
reg temp;
initial begin
	freq<=30'd60000000;
	scan<=15'b1;
end;

always@(posedge clk) begin
	if(btnl) choose <= 0;
	else if(btnr) choose <= 1;
	else if(btnc) choose <= 2;
	else choose <= choose;
end

always@(posedge clk) begin
	case({btnu, btnd}) 
		2'b10: begin
			if(temp)	freq<= (freq>8000000)?freq-30'd8000000:freq;
			temp = 0;
		end
		2'b01: begin
			if(temp)	freq<= (freq<1073741824)?freq+30'd10000000:freq;
			temp = 0;
		end
		default: temp=1;
	endcase
end

assign led = scan;
always@(posedge clk) begin
	if(choose == 0) begin
		counter <=(counter<=freq) ? (counter +1) : 0;
		if(counter==freq) begin
			state <= state+1;
			if(state==0)
				scan <= 15'b1;
			else
				scan <= scan<<1;
		end
	end
	else if(choose == 1) begin
		counter <=(counter<=freq) ? (counter +1) : 0;
		if(counter==freq) begin
			state <= state-1;
			if(state==0)
				scan <= 16'b1000_0000_0000_0000;
			else
				scan <= scan>>1;
		end
	end
	else scan <= 15'b0;
end  


endmodule
