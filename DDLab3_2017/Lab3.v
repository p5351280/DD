`timescale 1ns/1ns

module lab3(in2, in1, in0, out);
	input in2, in1, in0;		//宣告各個input 與output
	reg out3, out2, out1, out0;
	output [3:0]out;
	
	reg [3:0]out;
	
	always @ (*)
	begin
	/*   修改以下部分的程式   */
		out0=(!in2)|(in1&in0);
		out1=(!in2&in1&in0);
		out2=(!in2&in1&in0);
		out3=(!in1&in0)|(!in2&in1&!in0);
	/*   修改以上部分的程式   */	
		out={out3, out2, out1, out0};
		
	end
endmodule
