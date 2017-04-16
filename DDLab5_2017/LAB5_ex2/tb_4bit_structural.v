`timescale 1ns / 1ps

module fulladder_test;

//data type declaration

reg [3:0] a, b;
reg cin;
wire [3:0] sum;
wire cout;
_4bit_adder_structural DUT(sum, cout, a, b, cin);

// behavior description



initial
begin
	
	$dumpfile("4bit_RCA_structural.vcd"); //繪製波形檔
	$dumpvars;

	a = 4'b1111;
	b = 4'b1111;
	cin = 1'b1;
end

always #1
begin
a = a << 1;
$monitor("%4dns monitor: = a=%d b=%d cin=%d sum=%d cout=%d",$stime, a, b, cin, sum, cout);
end

always #2 
begin
b = b << 1;
cin = ~cin ;
end

initial #4 $finish;

endmodule