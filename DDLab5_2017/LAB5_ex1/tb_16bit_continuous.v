`timescale 1ns / 1ps

module fulladder_test;

//data type declaration

reg [15:0] a, b;
reg cin;
wire [15:0] sum;
wire cout;
_16bit_adder_continuous DUT(sum, cout, a, b, cin);

// behavior description



initial
begin
	
	$dumpfile("16bit_adder_continuous.vcd"); //繪製波形檔
	$dumpvars;

	a = 16'b1111111100000000;
	b = 16'b1111111111111111;
	cin = 1'b1;
end

always #1
begin
a = ( a << 1 | cin );
$monitor("%4dns monitor: = a=%d b=%d cin=%d sum=%d cout=%d",$stime, a, b, cin, sum, cout);
end

always #2 b = b >> 2;
always #3 cin = ~cin ;
initial #15 $finish;

endmodule