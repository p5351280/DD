`timescale 1ns / 1ps

module Lab4_main(clk, rst, ca, cb, cc, cd, ce, cf, cg, an0, an1, an2, an3, an4, an5, an6, an7);
	input clk, rst;
	output ca, cb, cc, cd, ce, cf, cg, an0, an1, an2, an3, an4, an5, an6, an7;
	wire [3:0]dout;
	reg [29:0]count;
	
	Lab4_Design lab4(.in2(count[28]), .in1(count[27]), .in0(count[26]), .out(dout));
	Lab4_To7seg lab4to7seg(.count(count[28:26]), .din(dout), .d7segp({an0, an1, an2, an3, an4, an5, an6, an7}), .d7segv({cg, cf, ce, cd, cc, cb, ca}));

	always @ (posedge clk)
	begin
		count<=count+1'b1;
		
		if(count[29]==1'b1||rst)	count<=30'b0;
	end

endmodule
