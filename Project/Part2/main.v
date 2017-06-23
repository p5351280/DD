`timescale 1ns / 1ps
module Part2(
    input btnu, 
	 input btnl,
	 input btnc,
	 input btnr,
	 input btnd,
	 input clk,

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
    output d7
    );

reg [11:0] number;
reg [30:0] counter; 
reg [2:0] state;
reg [6:0] seg_number,seg_data;
reg [7:0] scan;
reg [30:0] freq;
reg [1:0] choose;
reg temp;
initial freq<=30'd60000000;

always@(posedge clk) begin
	if(btnl) choose <= 0;
	else if(btnr) choose <= 1;
	else if(btnc) choose <= 2;
	else choose <= choose;
end

always@(posedge clk) begin
	case({btnu, btnd}) 
		2'b10: begin
			if(temp)	freq<= (freq>8000000)?freq-30'd8000000:freq;
			temp = 0;
		end
		2'b01: begin
			if(temp)	freq<= (freq<1073741824)?freq+30'd10000000:freq;
			temp = 0;
		end
		default: temp=1;
	endcase
end

//8顆7-segment顯示 
assign {d7,d6,d5,d4,d3,d2,d1,d0} = scan;
always@(posedge clk) begin
	if(choose == 0) begin
		counter <=(counter<=freq) ? (counter +1) : 0;
		state <= (counter==freq) ? (state + 1) : state;
		case(state)
		7:begin	 
			seg_number <= 0;
			scan <= 8'b0111_1111;
		end
		6:begin
			seg_number <= 0;
			scan <= 8'b1011_1111;
		end
		5:begin
			seg_number <= 0;
			scan <= 8'b1101_1111;
		end
		4:begin
			seg_number <= 0;
			scan <= 8'b1110_1111;
		end
		3:begin
			seg_number <= 0;
			scan <= 8'b1111_0111;
		end
		2:begin
			seg_number <= 0;
			scan <= 8'b1111_1011;
		end
		1:begin
			seg_number <= 0;
			scan <= 8'b1111_1101;
		end
		0:begin
			seg_number <= 0;
			scan <= 8'b1111_1110;
		end
		default: state <= state;
		endcase  
  end
  else if(choose == 1) begin
		counter <=(counter<=freq) ? (counter +1) : 0;
		state <= (counter==freq) ? (state - 1) : state;
		case(state)
		7:begin	 
			seg_number <= 0;
			scan <= 8'b0111_1111;
		end
		6:begin
			seg_number <= 0;
			scan <= 8'b1011_1111;
		end
		5:begin
			seg_number <= 0;
			scan <= 8'b1101_1111;
		end
		4:begin
			seg_number <= 0;
			scan <= 8'b1110_1111;
		end
		3:begin
			seg_number <= 0;
			scan <= 8'b1111_0111;
		end
		2:begin
			seg_number <= 0;
			scan <= 8'b1111_1011;
		end
		1:begin
			seg_number <= 0;
			scan <= 8'b1111_1101;
		end
		0:begin
			seg_number <= 0;
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
	16'd9:seg_data <= 7'b001_1000;
	default: seg_number <= seg_number;
  endcase
end 
endmodule
