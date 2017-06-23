`timescale 1ns / 1ps

module Lab7_main(
	input [7:0] a, b,
	input rst, opa, ops, opm, clk,
	
	output [6:0] sledctl,
	output [7:0] spctl
	);

	reg signed [15:0] result;
	reg [1:0]op;
	
	ctl7seg ctl7seg1(.clk(clk), .a(a), .b(b), .result(result), .op(op), .sledctl(sledctl), .spctl(spctl));
	
	always@(posedge clk)
	begin
        case({rst, opa, ops, opm})
            4'b1000 : op=0;
            4'b0100 : op=1;
            4'b0010 : op=2;
            4'b0001 : op=3;
        endcase

        case(op)
            2'b01 : result=a+b;
            2'b10 : result=a-b;
            2'b11 : result=a*b;
            default : result = 16'b0;
        endcase
	end
endmodule