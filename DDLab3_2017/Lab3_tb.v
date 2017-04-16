`timescale 1ns/1ns	//告訴iverilog等模擬軟體，以前者(1ns)為單位，以後者(10ps)的時間，查看一次電路的行為。
`include "Lab3.v"

module testbench;	// 模組名稱
	reg CLK;		// 暫存器宣告
	reg [3:0]count;	
	wire [3:0]out;

	lab3 l3(.in2(count[2]), .in1(count[1]), .in0(count[0]), .out);
	
	always	#10 CLK=~CLK;	//每10個單位時間，CLK的值反相一次

	always @ (posedge CLK)
	begin
		count=count+1;
		
		if(count[3]==1'b1)	count<=4'b0;
	end
	
	always @ (posedge CLK)
	begin
		#5	$display ("count = %d, out = %d",count, out);
	end
	
	initial begin	//僅執行一次
		CLK=0;
		count=4'b111;
		#160 $finish;
	end
endmodule