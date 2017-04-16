
module cla_16bit( a , b , cin , s , cout);

	input [15:0] a, b;
	input cin;
	output [15:0] s;
	output cout;
	
	wire [15:0] g;
	wire [15:0] p;
	wire [15:0] c;
	wire [3:0] gG ,gP;
	wire [3:0] c_4_8_12;
	//write your design below
	gp_generator gp1(.a(a[3:0]), .b(b[3:0]), .p(p[3:0]), .g(g[3:0]));
	gp_generator gp2(.a(a[7:4]), .b(b[7:4]), .p(p[7:4]), .g(g[7:4]));
	gp_generator gp3(.a(a[11:8]), .b(b[11:8]), .p(p[11:8]), .g(g[11:8]));
	gp_generator gp4(.a(a[15:12]), .b(b[15:12]), .p(p[15:12]), .g(g[15:12]));
	
	carry_generator carry_gen_1(.p(p[3:0]), .g(g[3:0]), .cin(cin), .c(c[3:0]), .gG(gG[0]), .gP(gP[0]));
	carry_generator carry_gen_2(.p(p[7:4]), .g(g[7:4]), .cin(c_4_8_12[1]), .c(c[7:4]), .gG(gG[1]), .gP(gP[1]));
	carry_generator carry_gen_3(.p(p[11:8]), .g(g[11:8]), .cin(c_4_8_12[2]), .c(c[11:8]), .gG(gG[2]), .gP(gP[2]));
	carry_generator carry_gen_4(.p(p[15:12]), .g(g[15:12]), .cin(c_4_8_12[3]), .c(c[15:12]), .gG(gG[3]), .gP(gP[3]));

	carry_generator carry_gen_5(.p(gP), .g(gG), .cin(cin), .c(c_4_8_12), .cout(cout));

	sum_generator sum_3_0(.a(a[3:0]), .b(b[3:0]), .c(c[3:0]), .s(s[3:0]));
	sum_generator sum_7_4(.a(a[7:4]), .b(b[7:4]), .c(c[7:4]), .s(s[7:4]));
	sum_generator sum_11_8(.a(a[11:8]), .b(b[11:8]), .c(c[11:8]), .s(s[11:8]));
	sum_generator sum_15_12(.a(a[15:12]), .b(b[15:12]), .c(c[15:12]), .s(s[15:12]));

endmodule


//產生所需的小p小g
module gp_generator(a, b, p, g );
     input [3:0] a,b;
	 output [3:0] p,g;
	 
	 assign g[0] = a[0] & b[0];
	 assign p[0] = a[0] | b[0];

	 assign g[1] = a[1] & b[1]; 
	 assign p[1] = a[1] | b[1];

	 assign g[2] = a[2] & b[2];	 
	 assign p[2] = a[2] | b[2];

	 assign g[3] = a[3] & b[3];	 
	 assign p[3] = a[3] | b[3];
	 
endmodule

//產生所需的carry in 跟 大G大P
module carry_generator( p , g , cin , c ,gG ,gP ,cout);

	input [3:0] p, g;
	input cin;
	output [3:0] c;
	output gG, gP;
	output cout;
	
	assign gG = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);//G[3:0]
	assign gP = p[3] & p[2] & p[1] & p[0];//P[3:0]
	
	assign c[0] = cin;
	assign c[1] = g[0] | (p[0] & cin);
	assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
	assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
	assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);
				
endmodule

//求得最後結果
module sum_generator(a, b, c, s );

     input [3:0] a,b,c;
	 output [3:0] s;

	 assign s[0] = a[0] ^ b[0] ^ c[0];
	 assign s[1] = a[1] ^ b[1] ^ c[1];
	 assign s[2] = a[2] ^ b[2] ^ c[2];
	 assign s[3] = a[3] ^ b[3] ^ c[3];
	 
endmodule

