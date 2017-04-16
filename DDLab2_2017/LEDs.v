`timescale 1ns / 1ps

//LEDs

module LEDs(
		input clk100mhz,
		input rst,
		output led0,
		output led1,
		output led2,
		output led3,
		output led4,
		output led5,
		output led6,
		output led7
		
    );
	 
reg [31:0] count;
reg [7:0] Light;
reg led0,led1,led2,led3,led4,led5,led6,led7;


always@(posedge clk100mhz )	 
begin
		if(rst)begin
			count  <= 32'd0;
			Light <= 8'b1;
		end
		else if(count  == 32'd15_000_000) begin
			count  <= 32'd0;
			if(Light == 8'b11111111)
				Light <= 8'b1;
			else
				Light <= Light + 8'b1;
			{led7,led6,led5,led4,led3,led2,led1,led0} <= Light;
		end
		else
			count  <=  count + 1'b1;
end


endmodule
