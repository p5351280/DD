`timescale 1ns / 1ps

module FFT_Main(
	input CLK100MHZ,
	input vauxp3,
	input vauxn3,
	output reg [15:0] LED,
	output [7:0] an,
	output dp,
	output [6:0] seg
	);

	wire enable;  
	wire adcok;
	wire [15:0] adcout;
	
	reg [32:0] dec;
	reg [23:0] count;
	reg [3:0] dig0, dig1, dig2, dig3, dig4, dig5, dig6;

	adc adc (.DADDR_IN(8'h13), //迄ADC隤芣航敺ort交憿靽∟ 雿蔭詨澆exys4摰辣
			.DCLK_IN(CLK100MHZ), 
			.DEN_IN(enable), 
			.DI_IN(), 
			.DWE_IN(), 
			.BUSY_OUT(),
			.VAUXP3(vauxp3), //憿靽∟甇扔
			.VAUXN3(vauxn3), //憿靽∟鞎扔
			.VN_IN(), 
			.VP_IN(), 
			.ALARM_OUT(), 
			.DO_OUT(adcout), //訾閮頛詨 6-bit 函瘚桅 勗椰啣^-1, 2^-2, 2^-3, ... , 2^-16
			.RESET_IN(),
			.EOC_OUT(enable),
			.CHANNEL_OUT(),
			.DRDY_OUT(adcok));
				
	to7seg to7seg (.CLK100MHZ(CLK100MHZ),
					.dig0(dig0), // 10^0
					.dig1(dig1), // 10^-1
					.dig2(dig2), // 10^-2
					.dig3(dig3), // 10^-3
					.dig4(dig4), // 10^-4
					.dig5(dig5), // 10^-5
					.dig6(dig6), // 10^-6
					.an(an),
					.dp(dp),
					.seg(seg));
	
	always@(posedge CLK100MHZ) //ADC result to LED
	begin
		if(count[23]==1)
			LED <= adcout; //撠DC箔6-bit靽∟湔頛詨蚯ED
	end
		
	always@(posedge CLK100MHZ)
	begin
		if(count[23]==1)
		begin
			dec <= (((adcout >> 4) * 250000) >> 10);
		end
		else if(count==24'b0)
		begin
		
			// Write your convert here
			dig6 = dec %10;
			dig5 = dec /10 %10;
			dig4 = dec /100 %10;
			dig3 = dec /1000 %10;
			dig2 = dec /10000 %10;
			dig1 = dec /100000 %10;
			dig0 = 0;
		end
	end
	
	always@(posedge CLK100MHZ)
	begin
		if(count[23]==1)
			count <= 24'b0;
		else
			count <= count + 1;
	end
endmodule
