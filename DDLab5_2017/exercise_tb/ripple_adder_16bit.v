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

module _16bit_adder_structural(sum, cout, a, b, cin);

//data type declaration
output [15:0]sum;
output cout;
input [15:0]a, b;
input cin;
// behavior description

full_adder fa0(.sum(sum[0]),.cout(c0),.a(a[0]),.b(b[0]),.cin(cin));
full_adder fa1(.sum(sum[1]),.cout(c1),.a(a[1]),.b(b[1]),.cin(c0));
full_adder fa2(.sum(sum[2]),.cout(c2),.a(a[2]),.b(b[2]),.cin(c1));
full_adder fa3(.sum(sum[3]),.cout(c3),.a(a[3]),.b(b[3]),.cin(c2));
full_adder fa4(.sum(sum[4]),.cout(c4),.a(a[4]),.b(b[4]),.cin(c3));
full_adder fa5(.sum(sum[5]),.cout(c5),.a(a[5]),.b(b[5]),.cin(c4));
full_adder fa6(.sum(sum[6]),.cout(c6),.a(a[6]),.b(b[6]),.cin(c5));
full_adder fa7(.sum(sum[7]),.cout(c7),.a(a[7]),.b(b[7]),.cin(c6));
full_adder fa8(.sum(sum[8]),.cout(c8),.a(a[8]),.b(b[8]),.cin(c7));
full_adder fa9(.sum(sum[9]),.cout(c9),.a(a[9]),.b(b[9]),.cin(c8));
full_adder fa10(.sum(sum[10]),.cout(c10),.a(a[10]),.b(b[10]),.cin(c9));
full_adder fa11(.sum(sum[11]),.cout(c11),.a(a[11]),.b(b[11]),.cin(c10));
full_adder fa12(.sum(sum[12]),.cout(c12),.a(a[12]),.b(b[12]),.cin(c11));
full_adder fa13(.sum(sum[13]),.cout(c13),.a(a[13]),.b(b[13]),.cin(c12));
full_adder fa14(.sum(sum[14]),.cout(c14),.a(a[14]),.b(b[14]),.cin(c13));
full_adder fa15(.sum(sum[15]),.cout(cout),.a(a[15]),.b(b[15]),.cin(c14));

endmodule