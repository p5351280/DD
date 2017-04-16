`timescale 1ns / 1ps

module full_adder(sum, cout, a, b, cin);

//data type declaration
input a, b, cin;
output sum, cout;
// behavior description

wire x,y,z;
xor i1(x,a,b);
xor i2(sum,x,cin);
and i3(y,x,cin);
and i4(z,a,b);
or i5(cout,y,z);

endmodule

module _4bit_adder_structural(sum, cout, a, b, cin);

//data type declaration
output [3:0]sum;
output cout;
input [3:0]a, b;
input cin;
// behavior description

full_adder fa0(.sum(sum[0]),.cout(c0),.a(a[0]),.b(b[0]),.cin(cin));
full_adder fa1(.sum(sum[1]),.cout(c1),.a(a[1]),.b(b[1]),.cin(c0));
full_adder fa2(.sum(sum[2]),.cout(c2),.a(a[2]),.b(b[2]),.cin(c1));
full_adder fa3(.sum(sum[3]),.cout(cout),.a(a[3]),.b(b[3]),.cin(c2));

endmodule