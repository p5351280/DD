`timescale 1ns / 1ps
module FFT_main(
    input clk, 
	 input rst,
	 
	 output reg [15:0] led,
    /*output rfd,
    output busy,
    output dv,
    output done,*/
	 output a,
	 output b,
	 output c,
	 output d,
    output e,
    output f,
    output g,
    //output dp,
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
reg [17:0] counter; 
reg [2:0] state;
reg [6:0] seg_number,seg_data;
reg [7:0] scan;

wire signed [15:0] data_in [0:31];
reg signed [15:0] fft_in;
wire rfd,busy,edone,done,dv;
 


reg signed [31:0] re_temp,im_temp;
reg signed [32:0] sum,out_sum;
reg [4:0] data_cnt;
////////////////////////////////////////////
wire signed [21:0] xk_re,xk_im;
reg [4:0] out_index;
wire [4:0] xk_index,xn_index;
//////////////////////////////////////////////




assign data_in[0] = 16'h00FB;  
assign data_in[1] = 16'hFF03; 
assign data_in[2] = 16'h00FB;  
assign data_in[3] = 16'hFF03;
assign data_in[4] = 16'h00FB;  
assign data_in[5] = 16'hFF03; 
assign data_in[6] = 16'h00FB;  
assign data_in[7] = 16'hFF03; 
assign data_in[8] = 16'h00FB;  
assign data_in[9] = 16'hFF03; 
assign data_in[10] = 16'h00FB;  
assign data_in[11] = 16'hFF03; 
assign data_in[12] = 16'h00FB;  
assign data_in[13] = 16'hFF03; 
assign data_in[14] = 16'h00FB;  
assign data_in[15] = 16'hFF03; 
assign data_in[16] = 16'h00FB;  
assign data_in[17] = 16'hFF03;
assign data_in[18] = 16'h00FB;  
assign data_in[19] = 16'hFF03; 
assign data_in[20] = 16'h00FB;  
assign data_in[21] = 16'hFF03; 
assign data_in[22] = 16'h00FB;  
assign data_in[23] = 16'hFF03; 
assign data_in[24] = 16'h00FB;  
assign data_in[25] = 16'hFF03; 
assign data_in[26] = 16'h00FB;  
assign data_in[27] = 16'hFF03;
assign data_in[28] = 16'h00FB;  
assign data_in[29] = 16'hFF03; 
assign data_in[30] = 16'h00FB;  
assign data_in[31] = 16'hFF03;  


fft fft(
  .clk(clk), // input clk
  .ce(1'b1), // input ce
  .start(1'b1), // input start
  .unload(1'b1), // input unload
  .xn_re(fft_in), // input [15 : 0] xn_re
  .xn_im(16'b0), // input [15 : 0] xn_im
  .fwd_inv(1'b1), // input fwd_inv
  .fwd_inv_we(1'b1), // input fwd_inv_we
  .rfd(rfd), // output rfd
  .xn_index(xn_index), // output [3 : 0] xn_index
  .busy(busy), // output busy
  .edone(edone), // output edone
  .done(done), // output done
  .dv(dv), // output dv
  .xk_index(xk_index), // output [3 : 0] xk_index
  .xk_re(xk_re), // output [20 : 0] xk_re
  .xk_im(xk_im) // output [20 : 0] xk_im
);
/*
assign  a = rfd; 
assign  b = busy;
assign  c = dv;
assign  d = done;
*/
 
//assign {d7,d6,d5,d4,d3,d2,d1,d0} = xk_im;
always@(posedge clk)begin
	if(rst) begin
		 out_sum <= 0; 
		 out_index <= 0;
		 led  <= 0;
		 re_temp <=0;
		 im_temp <=0;
		 sum <=0;
   end
   else begin
///////////////////////////////////////////////	
		re_temp <= (xk_re*xk_re)>>12;
		im_temp <= (xk_im*xk_im)>>12; 
		sum <= re_temp + im_temp;	
		
///////////////////////////////////////////////
	   if(dv) begin	
			out_sum <= out_sum>sum ? out_sum : sum;
			out_index <= out_sum<sum ? xk_index : out_index;		
		end
		else begin
			out_sum  <= 0 ;
			out_index <= 0;		
		end
		//led <= xk_re; 
		led[10:5] <=0;
		if(out_index>0)
			led[4:0] <=out_index;
		led[15:11] <=0;
		//led[3:0] <= data_cnt;
		//led[15:8] <= xn_index;
		
	end
end


//wtite down your code here
always@(posedge clk)begin
  //number <= {sw5,sw4,sw3,sw2,sw1,sw0};
  if(out_index>0)
		number <= {7'b0,led[4:0]} * 12'd100 / 12'd32;
end

always@(posedge clk)begin
  if(rst) begin
		  
  end
  else begin
		if(rfd) begin
			data_cnt <= data_cnt + 1;
			fft_in <= data_in[data_cnt];
		end
		else begin
			data_cnt <= 0;
			fft_in   <= 0;
		end
		
  end
end


//8顆7-segment顯示 
assign {d7,d6,d5,d4,d3,d2,d1,d0} = scan;
always@(posedge clk) begin
   counter <=(counter<=100000) ? (counter +1) : 0;
   state <= (counter==100000) ? (state + 1) : state;
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
	  seg_number <= number/10;
	  scan <= 8'b1111_1101;
	end
	0:begin
	  seg_number <= number%10;
	  scan <= 8'b1111_1110;
	end
	default: state <= state;
  endcase  
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
