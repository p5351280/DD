`timescale 1ns/1ps
module lab(CLK, RST, in_a, in_b, Product, Product_Valid);
					// in_a * in_b = Product
					// in_a is Multiplicand , in_b is Multiplier
input 			CLK, RST;
input 	[7:0]	in_a;	// Multiplicand
input 	[7:0]	in_b;	// Multiplier
output 	[15:0]  Product;
output  		Product_Valid;

reg 	[15:0]	Mplicand;
reg 	[7:0]	Mplier;
reg 	[15:0]	Product;
reg 			Product_Valid;
reg 	[5:0]	Counter ;
reg				sign;	//isSigned

//Counter
always @(posedge CLK or posedge RST)
begin
	if(RST)
		Counter <=6'b0;
	else
		Counter <= Counter + 6'b1;

end

//Product
always @(posedge CLK or posedge RST)
begin
	if(RST) begin
		Product  <= 16'b0;
		Mplicand <= 16'b0;
		Mplier   <= 8'b0;
	end 
	else if(Counter == 6'd0) begin
	/* write down your design below */
		Product	 	<= 16'b0;
		if(in_a[7]==1'b1)	//if Multiplicand is negative
			Mplicand <= {8'b0, (~in_a)+8'b1};	//change it into two's complement
		else	//if Multiplicand is positive
			Mplicand <= {8'b0, in_a};	//just change it into sixteen bits
		if(in_b[7]==1'b1)	//if Mpltiplier is negative
			Mplier <= (~in_b)+8'b1;	//change it into two's complement
		else	//if Mplier is positive
			Mplier <= in_b;	//just assign it to Mplier
		sign <= in_a[7]^in_b[7];	//the result's sign = Mplicand sign xor Mplier sign

	/* write down your design upon */
	end 
	else if(Counter <=6'd8) 
	begin
	/* write down your design below */
		if(Mplier[0] == 1'b1)	//if Mplier[0] == 1
			Product <= Mplicand+Product;	//Product += Mplicand
		Mplicand <= Mplicand<<1;	//Mplicand left shift
		Mplier <= Mplier>>1;	//Mplier right shift

	/* write down your design upon */
	end 
	else begin
	/* write down your design below */
		if(sign)	//if result is negative
		begin
			Product <= ~Product+16'b1;	//change it into two's complement
			sign <= 1'b0;
		end
		else	//else
			Product 	<= Product;	//is the answer
	/* write down your design upon */		
		Mplicand	<= Mplicand;
		Mplier 		<= Mplier;
	end
end

//Product_Valid
always @(posedge CLK or posedge RST)
begin
	if(RST)
		Product_Valid <=1'b0;
	else if(Counter==6'd9)
		Product_Valid <=1'b1;
	else
		Product_Valid <=1'b0;
end

endmodule
