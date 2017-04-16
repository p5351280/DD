`timescale 1ns / 1ps

module Lab4_Design(in2, in1, in0, out);
	input in2, in1, in0;
	output reg [3:0]out;
	reg out3, out2, out1, out0;
	
	always @ (*)
	begin
		/** Calculated result from K Map (Start) **/
		out0=(!in0&in2);
		out1=(in0&in1)|(in0&in2)|(!in0&!in1&!in2);
		out2=(!in0&in2);
		out3=(in0&!in1&!in2)|(!in0&in1&!in2);
		/** Calculated result from K Map (End) **/
		
		out={out3, out2, out1, out0};
	end
endmodule
