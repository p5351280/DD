module cla_64bit( a, b, cin, s, cout);

	input [63:0] a, b;
	input cin;
	output [63:0] s;
	output cout;

	wire [63:0] g;
	wire [63:0] p;
	wire [63:0] c;
	wire [15:0] gG_4 ,gP_4;
	wire [3:0] gG_16 ,gP_16;
	wire [15:0] c_4;
	wire [3:0] c_16;

	// g and p
	gp_generator gp1(.a(a[3:0]), .b(b[3:0]), .p(p[3:0]), .g(g[3:0]));
	gp_generator gp2(.a(a[7:4]), .b(b[7:4]), .p(p[7:4]), .g(g[7:4]));
	gp_generator gp3(.a(a[11:8]), .b(b[11:8]), .p(p[11:8]), .g(g[11:8]));
	gp_generator gp4(.a(a[15:12]), .b(b[15:12]), .p(p[15:12]), .g(g[15:12]));
	gp_generator gp5(.a(a[19:16]), .b(b[19:16]), .p(p[19:16]), .g(g[19:16]));
	gp_generator gp6(.a(a[23:20]), .b(b[23:20]), .p(p[23:20]), .g(g[23:20]));
	gp_generator gp7(.a(a[27:24]), .b(b[27:24]),  .p(p[27:24]), .g(g[27:24]));
	gp_generator gp8(.a(a[31:28]), .b(b[31:28]), .p(p[31:28]), .g(g[31:28]));
	gp_generator gp9(.a(a[35:32]), .b(b[35:32]), .p(p[35:32]), .g(g[35:32]));
	gp_generator gp10(.a(a[39:36]), .b(b[39:36]), .p(p[39:36]), .g(g[39:36]));
	gp_generator gp11(.a(a[43:40]), .b(b[43:40]), .p(p[43:40]), .g(g[43:40]));
	gp_generator gp12(.a(a[47:44]), .b(b[47:44]), .p(p[47:44]), .g(g[47:44]));
	gp_generator gp13(.a(a[51:48]), .b(b[51:48]), .p(p[51:48]), .g(g[51:48]));
	gp_generator gp14(.a(a[55:52]), .b(b[55:52]), .p(p[55:52]), .g(g[55:52]));
	gp_generator gp15(.a(a[59:56]), .b(b[59:56]), .p(p[59:56]), .g(g[59:56]));
	gp_generator gp16(.a(a[63:60]), .b(b[63:60]), .p(p[63:60]), .g(g[63:60]));

	// 4 a group
	GGP_generator GGP1(.p(p[3:0]), .g(g[3:0]), .gG(gG_4[0]), .gP(gP_4[0]));
	GGP_generator GGP2(.p(p[7:4]), .g(g[7:4]), .gG(gG_4[1]), .gP(gP_4[1]));
	GGP_generator GGP3(.p(p[11:8]), .g(g[11:8]), .gG(gG_4[2]), .gP(gP_4[2]));
	GGP_generator GGP4(.p(p[15:12]), .g(g[15:12]), .gG(gG_4[3]), .gP(gP_4[3]));
	GGP_generator GGP5(.p(p[19:16]), .g(g[19:16]), .gG(gG_4[4]), .gP(gP_4[4]));
	GGP_generator GGP6(.p(p[23:20]), .g(g[23:20]), .gG(gG_4[5]), .gP(gP_4[5]));
	GGP_generator GGP7(.p(p[27:24]), .g(g[27:24]), .gG(gG_4[6]), .gP(gP_4[6]));
	GGP_generator GGP8(.p(p[31:28]), .g(g[31:28]), .gG(gG_4[7]), .gP(gP_4[7]));
	GGP_generator GGP9(.p(p[35:32]), .g(g[35:32]), .gG(gG_4[8]), .gP(gP_4[8]));
	GGP_generator GGP10(.p(p[39:36]), .g(g[39:36]), .gG(gG_4[9]), .gP(gP_4[9]));
	GGP_generator GGP11(.p(p[43:40]), .g(g[43:40]), .gG(gG_4[10]), .gP(gP_4[10]));
	GGP_generator GGP12(.p(p[47:44]), .g(g[47:44]), .gG(gG_4[11]), .gP(gP_4[11]));
	GGP_generator GGP13(.p(p[51:48]), .g(g[51:48]), .gG(gG_4[12]), .gP(gP_4[12]));
	GGP_generator GGP14(.p(p[55:52]), .g(g[55:52]), .gG(gG_4[13]), .gP(gP_4[13]));
	GGP_generator GGP15(.p(p[59:56]), .g(g[59:56]), .gG(gG_4[14]), .gP(gP_4[14]));
	GGP_generator GGP16(.p(p[63:60]), .g(g[63:60]), .gG(gG_4[15]), .gP(gP_4[15]));

	// 16 a group
	GGP_generator GGGP1(.p(gP_4[3:0]), .g(gG_4[3:0]), .gG(gG_16[0]), .gP(gP_16[0]));
	GGP_generator GGGP2(.p(gP_4[7:4]), .g(gG_4[7:4]), .gG(gG_16[1]), .gP(gP_16[1]));
	GGP_generator GGGP3(.p(gP_4[11:8]), .g(gG_4[11:8]), .gG(gG_16[2]), .gP(gP_16[2]));
	GGP_generator GGGP4(.p(gP_4[15:12]), .g(gG_4[15:12]), .gG(gG_16[3]), .gP(gP_16[3]));

	// C_16
	carry__generator CG1(.p(gP_16[3:0]), .g(gG_16[3:0]), .cin(cin), .c(c_16[3:0]), .cout(cout));

	// C_4
	carry__generator CCG1(.p(gP_4[3:0]), .g(gG_4[3:0]), .cin(c_16[0]), .c(c_4[3:0]));
	carry__generator CCG2(.p(gP_4[7:4]), .g(gG_4[7:4]), .cin(c_16[1]), .c(c_4[7:4]));
	carry__generator CCG3(.p(gP_4[11:8]), .g(gG_4[11:8]), .cin(c_16[2]), .c(c_4[11:8]));
	carry__generator CCG4(.p(gP_4[15:12]), .g(gG_4[15:12]), .cin(c_16[3]), .c(c_4[15:12]));

	// C_1
	carry__generator final1(.p(p[3:0]), .g(g[3:0]), .cin(c_4[0]), .c(c[3:0]));
	carry__generator final2(.p(p[7:4]), .g(g[7:4]), .cin(c_4[1]), .c(c[7:4]));
	carry__generator final3(.p(p[11:8]), .g(g[11:8]), .cin(c_4[2]), .c(c[11:8]));
	carry__generator final4(.p(p[15:12]), .g(g[15:12]), .cin(c_4[3]), .c(c[15:12]));
	carry__generator final5(.p(p[19:16]), .g(g[19:16]), .cin(c_4[4]), .c(c[19:16]));
	carry__generator final6(.p(p[23:20]), .g(g[23:20]), .cin(c_4[5]), .c(c[23:20]));
	carry__generator final7(.p(p[27:24]), .g(g[27:24]), .cin(c_4[6]), .c(c[27:24]));
	carry__generator final8(.p(p[31:28]), .g(g[31:28]), .cin(c_4[7]), .c(c[31:28]));
	carry__generator final9(.p(p[35:32]), .g(g[35:32]), .cin(c_4[8]), .c(c[35:32]));
	carry__generator final10(.p(p[39:36]), .g(g[39:36]), .cin(c_4[9]), .c(c[39:36]));
	carry__generator final11(.p(p[43:40]), .g(g[43:40]), .cin(c_4[10]), .c(c[43:40]));
	carry__generator final12(.p(p[47:44]), .g(g[47:44]), .cin(c_4[11]), .c(c[47:44]));
	carry__generator final13(.p(p[51:48]), .g(g[51:48]), .cin(c_4[12]), .c(c[51:48]));
	carry__generator final14(.p(p[55:52]), .g(g[55:52]), .cin(c_4[13]), .c(c[55:52]));
	carry__generator final15(.p(p[59:56]), .g(g[59:56]), .cin(c_4[14]), .c(c[59:56]));
	carry__generator final16(.p(p[63:60]), .g(g[63:60]), .cin(c_4[15]), .c(c[63:60]));

	sum_generator sum_3_0(.a(a[3:0]), .b(b[3:0]), .c(c[3:0]), .s(s[3:0]));
	sum_generator sum_7_4(.a(a[7:4]), .b(b[7:4]), .c(c[7:4]), .s(s[7:4]));
	sum_generator sum_11_8(.a(a[11:8]), .b(b[11:8]), .c(c[11:8]), .s(s[11:8]));
	sum_generator sum_15_12(.a(a[15:12]), .b(b[15:12]), .c(c[15:12]), .s(s[15:12]));
	sum_generator sum_19_16(.a(a[19:16]), .b(b[19:16]), .c(c[19:16]), .s(s[19:16]));
	sum_generator sum_23_20(.a(a[23:20]), .b(b[23:20]), .c(c[23:20]), .s(s[23:20]));
	sum_generator sum_27_24(.a(a[27:24]), .b(b[27:24]), .c(c[27:24]), .s(s[27:24]));
	sum_generator sum_31_28(.a(a[31:28]), .b(b[31:28]), .c(c[31:28]), .s(s[31:28]));
	sum_generator sum_35_32(.a(a[35:32]), .b(b[35:32]), .c(c[35:32]), .s(s[35:32]));
	sum_generator sum_39_36(.a(a[39:36]), .b(b[39:36]), .c(c[39:36]), .s(s[39:36]));
	sum_generator sum_43_40(.a(a[43:40]), .b(b[43:40]), .c(c[43:40]), .s(s[43:40]));
	sum_generator sum_47_44(.a(a[47:44]), .b(b[47:44]), .c(c[47:44]), .s(s[47:44]));
	sum_generator sum_51_48(.a(a[51:48]), .b(b[51:48]), .c(c[51:48]), .s(s[51:48]));
	sum_generator sum_55_52(.a(a[55:52]), .b(b[55:52]), .c(c[55:52]), .s(s[55:52]));
	sum_generator sum_59_56(.a(a[59:56]), .b(b[59:56]), .c(c[59:56]), .s(s[59:56]));
	sum_generator sum_63_60(.a(a[63:60]), .b(b[63:60]), .c(c[63:60]), .s(s[63:60]));

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

//產生所需的大G大P
module GGP_generator(p, g, gG, gP);

	input [3:0] p, g;
	output gG, gP;
	
	assign gG = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);//G[3:0]
	assign gP = p[3] & p[2] & p[1] & p[0];//P[3:0]
					
endmodule

//產生所需的carry in
module carry__generator(p, g, cin, c, cout);
	
	input [3:0] p, g;
	input cin;
	output [3:0] c;
	output cout;

	assign c[0] = cin;
	assign c[1] = g[0] | (p[0] & cin);
	assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
	assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
	assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

endmodule


//求得最後結果
module sum_generator(a, b, c, s);

     input [3:0] a,b,c;
	 output [3:0] s;

	 assign s[0] = a[0] ^ b[0] ^ c[0];
	 assign s[1] = a[1] ^ b[1] ^ c[1];
	 assign s[2] = a[2] ^ b[2] ^ c[2];
	 assign s[3] = a[3] ^ b[3] ^ c[3];
	 
endmodule

