module cla_64bit( a, b, cin, sum, cout);



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

