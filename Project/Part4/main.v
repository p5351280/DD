`timescale 1ns / 1ps
module Part4(
    input btnu, 
	 input btnl,
	 input btnc,
	 input btnr,
	 input btnd,
	 input clk,
	 input [15:0] sw,
	 input cpu_resetn,
	 
	 output a,
	 output b,
	 output c,
	 output d,
    output e,
    output f,
    output g,
	 
    output d0,
    output d1,
    output d2,
    output d3,
    output d4,
    output d5,
    output d6,	 	 
    output d7,
	 
	 output RGB1_Red,
	 output RGB1_Green,
	 output RGB1_Blue
    );

reg [11:0] number;
reg [30:0] counter; 
reg [15:0] incounter;
reg [2:0] state;
reg [2:0] instate;
reg [6:0] seg_number,seg_data;
reg [7:0] scan;
reg [30:0] freq;
reg [32:0] ans;
reg [1:0] choose;
reg temp;
reg temp2;
reg confirm;
reg [14:0] count_div;
reg [9:0] red;
reg [9:0] blue;
reg [9:0] green;
reg Red_OUT1;
reg Green_OUT2;
reg Blue_OUT3;
initial begin
	freq<=30'd60000000;
	choose <= 0;
	ans <= 32'd19970801;
end

always@(posedge clk) begin
	case({btnu, btnd}) 
		2'b10: begin
			if(temp)	freq<= (freq>8000000)?freq-30'd8000000:freq;
			temp = 0;
		end
		2'b01: begin
			if(temp)	freq<= (freq<900000000)?freq+30'd10000000:freq;
			temp = 0;
		end
		default: temp=1;
	endcase
	if(btnc && temp) begin
		choose <= choose^1;
		temp = 0;
	end

end

//8顆7-segment顯示 
assign {d7,d6,d5,d4,d3,d2,d1,d0} = scan;
always@(posedge clk) begin
	if(choose == 0) begin
		counter <=(counter<=freq) ? (counter +1) : 0;
		state <= (counter==freq) ? (state + 1) : state;
		if(btnl && temp2) begin
			state <= state+1;
			temp2=0;
		end
		else if(btnr && temp2) begin
			state <= state-1;
			temp2=0;
		end
		if(!btnl && !btnr)
			temp2=1;
		
		if(sw[15]) begin
			ans <= 32'd20170622;
		end
		if(sw[15]==0) begin
			ans <= 32'd19970801;
		end
		
		case(state)
		7:begin	 
			incounter <=(incounter<=1000) ? (incounter +1) : 0;
			instate <= (incounter==1000) ? (instate + 1) : instate;
			case(instate)
				3'd0:begin
					seg_number <= ans/10000000;
					scan <= 8'b0111_1111;
				end
				3'd1:begin
					seg_number <= ans/1000000%10;
					scan <= 8'b1011_1111;
				end
				3'd2:begin
					seg_number <= ans/100000%10;
					scan <= 8'b1101_1111;
				end
				3'd3:begin
					seg_number <= ans/10000%10;
					scan <= 8'b1110_1111;
				end
				3'd4:begin
					seg_number <= ans/1000%10;
					scan <= 8'b1111_0111;
				end
				3'd5:begin
					seg_number <= ans/100%10;
					scan <= 8'b1111_1011;
				end
				3'd6:begin
					seg_number <= ans/10%10;
					scan <= 8'b1111_1101;
				end
				3'd7:begin
					seg_number <= ans%10;
					scan <= 8'b1111_1110;
				end
				default
					instate <= 0;
			endcase
		end
		6:begin
			incounter <=(incounter<=1000) ? (incounter +1) : 0;
			instate <= (incounter==1000) ? (instate + 1) : instate;
			case(instate)
				3'd0:begin
					seg_number <= ans/10000000;
					scan <= 8'b1011_1111;
				end
				3'd1:begin
					seg_number <= ans/1000000%10;
					scan <= 8'b1101_1111;
				end
				3'd2:begin
					seg_number <= ans/100000%10;
					scan <= 8'b1110_1111;
				end
				3'd3:begin
					seg_number <= ans/10000%10;
					scan <= 8'b1111_0111;
				end
				3'd4:begin
					seg_number <= ans/1000%10;
					scan <= 8'b1111_1011;
				end
				3'd5:begin
					seg_number <= ans/100%10;
					scan <= 8'b1111_1101;
				end
				3'd6:begin
					seg_number <= ans/10%10;
					scan <= 8'b1111_1110;
				end
				default
					instate <= 0;
			endcase
		end
		5:begin
			incounter <=(incounter<=1000) ? (incounter +1) : 0;
			instate <= (incounter==1000) ? (instate + 1) : instate;
			case(instate)
				3'd0:begin
					seg_number <= ans/10000000;
					scan <= 8'b1101_1111;
				end
				3'd1:begin
					seg_number <= ans/1000000%10;
					scan <= 8'b1110_1111;
				end
				3'd2:begin
					seg_number <= ans/100000%10;
					scan <= 8'b1111_0111;
				end
				3'd3:begin
					seg_number <= ans/10000%10;
					scan <= 8'b1111_1011;
				end
				3'd4:begin
					seg_number <= ans/1000%10;
					scan <= 8'b1111_1101;
				end
				3'd5:begin
					seg_number <= ans/100%10;
					scan <= 8'b1111_1110;
				end
				default
					instate <= 0;
			endcase
		end
		4:begin
			incounter <=(incounter<=1000) ? (incounter +1) : 0;
			instate <= (incounter==1000) ? (instate + 1) : instate;
			case(instate)
				3'd0:begin
					seg_number <= ans/10000000;
					scan <= 8'b1110_1111;
				end
				3'd1:begin
					seg_number <= ans/1000000%10;
					scan <= 8'b1111_0111;
				end
				3'd2:begin
					seg_number <= ans/100000%10;
					scan <= 8'b1111_1011;
				end
				3'd3:begin
					seg_number <= ans/10000%10;
					scan <= 8'b1111_1101;
				end
				3'd4:begin
					seg_number <= ans/1000%10;
					scan <= 8'b1111_1110;
				end
				default
					instate <= 0;
			endcase
		end
		3:begin
			incounter <=(incounter<=1000) ? (incounter +1) : 0;
			instate <= (incounter==1000) ? (instate + 1) : instate;
			case(instate)
				3'd0:begin
					seg_number <= ans/10000000;
					scan <= 8'b1111_0111;
				end
				3'd1:begin
					seg_number <= ans/1000000%10;
					scan <= 8'b1111_1011;
				end
				3'd2:begin
					seg_number <= ans/100000%10;
					scan <= 8'b1111_1101;
				end
				3'd3:begin
					seg_number <= ans/10000%10;
					scan <= 8'b1111_1110;
				end
				default
					instate <= 0;
			endcase
		end
		2:begin
			incounter <=(incounter<=1000) ? (incounter +1) : 0;
			instate <= (incounter==1000) ? (instate + 1) : instate;
			case(instate)
				3'd0:begin
					seg_number <= ans/10000000;
					scan <= 8'b1111_1011;
				end
				3'd1:begin
					seg_number <= ans/1000000%10;
					scan <= 8'b1111_1101;
				end
				3'd2:begin
					seg_number <= ans/100000%10;
					scan <= 8'b1111_1110;
				end
				default
					instate <= 0;
			endcase
		end
		1:begin
			incounter <=(incounter<=1000) ? (incounter +1) : 0;
			instate <= (incounter==1000) ? (instate + 1) : instate;
			case(instate)
				3'd0:begin
					seg_number <= ans/10000000;
					scan <= 8'b1111_1101;
				end
				3'd1:begin
					seg_number <= ans/1000000%10;
					scan <= 8'b1111_1110;
				end
				default
					instate <= 0;
			endcase
		end
		0:begin
			seg_number <= ans/10000000;
			scan <= 8'b1111_1110;
		end
		default: state <= state;
		endcase  
  end
  else
		scan <= 8'b1111_1111;
end  

//7-segment 輸出數字解碼
assign {g,f,e,d,c,b,a} = seg_data; 
//assign {g,f,e,d} = 0; 
always@(posedge clk) begin  
  case(seg_number)
	16'd0:seg_data <= 7'b100_0000;
	16'd1:seg_data <= 7'b111_1001;
	16'd2:seg_data <= 7'b010_0100;
	16'd3:seg_data <= 7'b011_0000;
	16'd4:seg_data <= 7'b001_1001;
	16'd5:seg_data <= 7'b001_0010;
	16'd6:seg_data <= 7'b000_0010;
	16'd7:seg_data <= 7'b111_1000;
	16'd8:seg_data <= 7'b000_0000;
	16'd9:seg_data <= 7'b001_0000;
	default: seg_number <= seg_number;
  endcase
end 

//---------------------LED---------------------//
always@(posedge clk)	
begin
	count_div <= (count_div<=510) ? count_div + 14'd1 : 14'd0;
	Red_OUT1 <= (count_div<=red) ? 1 : 0;
	Green_OUT2 <= (count_div<=green) ? 1 : 0;
	Blue_OUT3 <= (count_div<=blue) ? 1 : 0;
end

always@(clk) begin
	red <= sw[4:0]*255/31;
	green <= sw[9:5]*255/31;
	blue <= sw[14:10]*255/31;
end

assign RGB1_Red = (state == 4'd0) ? Red_OUT1 : (state == 4'd1)? Red_OUT1 : Red_OUT1;
assign RGB1_Green = (state == 4'd0) ? Green_OUT2 : (state == 4'd1)? Green_OUT2 : Green_OUT2;
assign RGB1_Blue = (state == 4'd0) ? Blue_OUT3 : (state == 4'd1)? Blue_OUT3 : Blue_OUT3; 

endmodule
