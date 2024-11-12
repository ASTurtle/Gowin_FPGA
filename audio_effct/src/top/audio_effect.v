module audio_effect(
		input clk,                    
		input reset_n,                                   
		inout iic_0_scl,              
		inout iic_0_sda, 
        input uart_rx,
        output led,
		input I2S_ADCDAT,
		input I2S_ADCLRC,
		input I2S_BCLK,
		output I2S_DACDAT,
		input I2S_DACLRC,
		output I2S_MCLK,
        output dacfifo_write, 
        output resample_data
);
//串口发送一次数据的顺序：回声，混响，合唱，压缩，相位，失真，均衡器，远程滤波       （自适应，插值抽取）
    wire [239:0]uart_cmd;
	wire [11:0] s1_hui;     //回声
    wire [11:0] s2_hun;     //混响
    wire [11:0] s3_he;      //合唱
    assign s1_hui = uart_cmd[239:228];
    assign s2_hun = uart_cmd[227:216];
    assign s3_he = uart_cmd[215:204];
    wire [7:0] p1_ys;     //压缩
    wire [11:0] p2_ph;     //相位
    wire [3:0] p3_diss;     //失真
    assign p1_ys = uart_cmd[203:196];
    assign p2_ph = uart_cmd[195:184];
    assign p3_diss = uart_cmd[183:180]; 
    assign eq = uart_cmd[179:136];
    assign lms_para=uart_cmd[135:128];
    assign inte_deci=uart_cmd[127:120];
    assign re_fil = uart_cmd[119:4];
    wire [43:0] eq;     //均衡器   
    wire [115:0] re_fil;     //远程滤波
    wire [7:0]inte_deci;
    wire [7:0]lms_para;
///////////////////////////////////////////////////////////////////////
	parameter DATA_WIDTH        = 32;  
    parameter HALF_DATA_WIDTH   = 16;     

    Gowin_PLL Gowin_PLL(
        .clkout0(I2S_MCLK), //output clkout0
        .clkin(clk), //input clkin
        .clkout1(standard_clk)
    );


	WM8960_Init WM8960_Init(
		.Clk(clk),
		.Rst_n(reset_n),
		.I2C_Init_Done(),
		.i2c_sclk(iic_0_scl),
		.i2c_sdat(iic_0_sda)
	);
	assign led = filtered_data_out[7];
	
	reg adcfifo_read;
	wire [DATA_WIDTH - 1:0] adcfifo_readdata,filtered_data_out,rm_filter_out,sample_data_out,resample_data;
	wire adcfifo_empty,factor_clk,standard_clk,out_valid,Init_Done;  
	reg dacfifo_write;
	reg [DATA_WIDTH - 1:0] dacfifo_writedata,sample_data_in,rm_filter_in;
	wire dacfifo_full;
    wire [HALF_DATA_WIDTH-1:0]rm_out_0,rm_out_1,lms_out_0,lms_out_1;
    reg [HALF_DATA_WIDTH-1:0]rm_in_0,rm_in_1,lms_in_0,lms_in_1;
    wire [HALF_DATA_WIDTH-1:0] echo_out_0,echo_out_1,ring_out_0,ring_out_1,eq_out_0,eq_out_1,reverb_out_0,reverb_out_1,chorus_out_0,chorus_out_1,compressor_out_0,compressor_out_1,dis_out_0,dis_out_1,phaser_out_0,phaser_out_1;
    reg [HALF_DATA_WIDTH-1:0]  echo_in_0,echo_in_1,ring_in_0,ring_in_1,eq_in_0,eq_in_1,reverb_in_0,reverb_in_1,chorus_in_0,chorus_in_1,compressor_in_0,compressor_in_1,dis_in_0,dis_in_1,phaser_in_0,phaser_in_1;
	always @ (posedge clk or negedge reset_n)
	begin
		if (~reset_n)
		begin
			adcfifo_read <= 1'b0;
		end
		else if (~adcfifo_empty)
		begin
			adcfifo_read <= 1'b1;
		end
		else
		begin
			adcfifo_read <= 1'b0;
		end
	end

	always @ (posedge clk or negedge reset_n)
	begin
		if(~reset_n)
			dacfifo_write <= 1'd0;
		else if(~dacfifo_full && (~adcfifo_empty)) begin
			dacfifo_write <= 1'd1;
            sample_data_in <= adcfifo_readdata;
////////////////////////////////////////////////////////////
              echo_in_0<= adcfifo_readdata[15:0];           
              reverb_in_0<= echo_out_0;           
              chorus_in_0 <=reverb_out_0;
              compressor_in_0<=chorus_out_0;
              phaser_in_0<=compressor_out_0;
              dis_in_0  <= phaser_out_0; 
              eq_in_0<= dis_out_0;
//              lms_in_0<=eq_out_0; 
//               rm_in_0<=lms_out_0;
               rm_in_0<=eq_out_0;
               dacfifo_writedata[15:0] <= rm_out_0;


                 echo_in_1<= adcfifo_readdata[31:16];
                 reverb_in_1<= echo_out_1;           
                 chorus_in_1 <=reverb_out_1;
                 compressor_in_1<=chorus_out_1;
                 phaser_in_1<=compressor_out_1;
                 dis_in_1  <= phaser_out_1; 
                 eq_in_1<= dis_out_1;
//                 lms_in_1<=eq_out_1; 
//                 rm_in_1<=lms_out_1;
                   rm_in_1<=eq_out_1; 
                 dacfifo_writedata[31:16] <= rm_out_1;			
		end
		else begin
			dacfifo_write <= 1'd0;
		end
	end
assign  resample_data =filtered_data_out;

compressor compressor_0(
    .clk(clk),
    .en(p1_ys[7:4]),
    .thre_para(p1_ys[3:0]),
    .reset_n(reset_n),
    .audio_in(compressor_in_0),
    .audio_out(compressor_out_0)
);
compressor compressor_1(
    .clk(clk),
    .en(p1_ys[7:4]),
    .thre_para(p1_ys[3:0]),
    .reset_n(reset_n),
    .audio_in(compressor_in_1),
    .audio_out(compressor_out_1)
);


distortion distortion_0(
    .clk(clk),
    .en(p3_diss[3:0]),
    .reset_n(reset_n),
    .audio_in(dis_in_0),
    .audio_out(dis_out_0)
);

distortion distortion_1(
    .clk(clk),
    .en(p3_diss[3:0]),
    .reset_n(reset_n),
    .audio_in(dis_in_1),
    .audio_out(dis_out_1)
);

echo
#(
    .DATA_WIDTH(HALF_DATA_WIDTH)
)echo_0
(
     .clk(clk),
     .bclk(dacfifo_write),
     .en(s1_hui[11:8]),
     .reset_n(reset_n),
     .audio_data_0(echo_in_0),
     .gain_para(s1_hui[7:4]),
     .delay_para(s1_hui[3:0]),
     .echo_data(echo_out_0)
);
echo
#(
    .DATA_WIDTH(HALF_DATA_WIDTH)
)echo_1
(
     .clk(clk),
     .bclk(dacfifo_write),
     .en(s1_hui[11:8]),
     .reset_n(reset_n),
     .audio_data_0(echo_in_1),
     .gain_para(s1_hui[7:4]),
     .delay_para(s1_hui[3:0]),
     .echo_data(echo_out_1)
);
reverb
#(
    .DATA_WIDTH(HALF_DATA_WIDTH)
)reverb_0
(
     .clk(clk),
     .bclk(dacfifo_write),
     .en(s2_hun[11:8]),
     .reset_n(reset_n),
     .audio_data_0(reverb_in_0),
     .gain_para(s2_hun[7:4]),
     .delay_para(s2_hun[3:0]),
     .reverb_data(reverb_out_0)
);

reverb
#(
    .DATA_WIDTH(HALF_DATA_WIDTH)
)reverb_1
(
     .clk(clk),
     .bclk(dacfifo_write),
     .en(s2_hun[11:8]),
     .reset_n(reset_n),
     .audio_data_0(reverb_in_1),
     .gain_para(s2_hun[7:4]),
     .delay_para(s2_hun[3:0]),
     .reverb_data(reverb_out_1)
);
chorus
#(
    .DATA_WIDTH(HALF_DATA_WIDTH)
)chorus_0
(
     .clk(clk),
     .bclk(dacfifo_write),
     .en(s3_he[11:8]),
     .freq_para(s3_he[3:0]),
     .gain_para(s3_he[7:4]),
     .wr(out_valid),
     .reset_n(reset_n),
     .audio_data_0(chorus_in_0),
     .chorus_data(chorus_out_0)
);
chorus
#(
    .DATA_WIDTH(HALF_DATA_WIDTH)
)chorus_1
(
     .clk(clk),
     .bclk(dacfifo_write),
     .en(s3_he[11:8]),
     .freq_para(s3_he[3:0]),
     .gain_para(s3_he[7:4]),
     .wr(out_valid),
     .reset_n(reset_n),
     .audio_data_0(chorus_in_1),
     .chorus_data(chorus_out_1)
);


phaser phaser_0(
    .clk(clk),
    .bclk(dacfifo_write),
    .reset_n(reset_n),
    .en(p2_ph[11:8]),
    .freq_para(p2_ph[3:0]),
    .gain_para(p2_ph[7:4]),
    .wr(out_valid),
    .input_sample(phaser_in_0),
    .output_sample(phaser_out_0)
   
);
phaser phaser_1(
    .clk(clk),
    .bclk(dacfifo_write),
    .reset_n(reset_n),
    .en(p2_ph[11:8]),
    .freq_para(p2_ph[3:0]),
    .gain_para(p2_ph[7:4]),
    .wr(out_valid),
    .input_sample(phaser_in_1),
    .output_sample(phaser_out_1)
   
);
eq_crtl eq_crtl_0(
            .clk(clk),
            .en(eq[43:40]),
            .reset_n(reset_n),
            .gain_all(eq[39:0]),
            .data_in(eq_in_0),  
            .data_out(eq_out_0)
);
eq_crtl eq_crtl_1(
            .clk(clk),
            .en(eq[43:40]),
            .reset_n(reset_n),
            .gain_all(eq[39:0]),
            .data_in(eq_in_1),  
            .data_out(eq_out_1)
);

//lms_top lms_top_0(
//    .clk(clk),
//    .en(lms_para[7:4]),
//    .switch(lms_para[3:0]),
//    .reset_n(reset_n),
//    .audio_in(lms_in_0),
//    .audio_out(lms_out_0)
//);
//lms_top lms_top_1(
//    .clk(clk),
//    .en(lms_para[7:4]),
//    .switch(lms_para[3:0]),
//    .reset_n(reset_n),
//    .audio_in(lms_in_1),
//    .audio_out(lms_out_1)
//);

uart_cmd uart_1(
    .Clk(clk),
    .Rst_n(reset_n),
    .uart_rx(uart_rx),
    .my_uart_data(uart_cmd),
    .out_valid(out_valid)
);

tap_6_rm   tap_6_rm_0               
(
    .clk(clk),
    .reset(!reset_n),
    .clk_enable(re_fil[115:112]),
    .filter_in(rm_in_0),
    .eff(re_fil[111:0]),
    .en(re_fil[115:112]),
    .filter_out(rm_out_0)
);
tap_6_rm    tap_6_rm_1               
(
    .clk(clk),
    .reset(!reset_n),
    .clk_enable(re_fil[115:112]),
    .filter_in(rm_in_1),
    .eff(re_fil[111:0]),
    .en(re_fil[115:112]),
    .filter_out(rm_out_1)
);
sample_switch #(
    
	)sampe_switch(
        .clk(clk),
        .reset_n(reset_n),
        .clk_enable(inte_deci[7:4]),
        .sample_clk(standard_clk),
        .inte_deci_num(inte_deci[3:0]),
        .data_in(sample_data_in),
        .sample_in(dacfifo_write),
        .data_out(sample_data_out),
        .factor_clk(factor_clk),
        .filtered_data_out(filtered_data_out)
    );
////////////////////////寄掉的模块
//远程滤波器输入32位
//remote_filter remote_filter
//(
//    .clk(clk),
//    .reset_n(reset_n),
//    .filter_in(rm_filter_in),
//    .eff(re_fil[111:0]),
//    .en(re_fil[115:112]),
//    .filter_out(rm_filter_out)
//);
///////////////////




i2s_rx 
	#(
		.DATA_WIDTH(DATA_WIDTH) 
	)i2s_rx
	(
		.reset_n(reset_n),
		.bclk(I2S_BCLK),
		.adclrc(I2S_ADCLRC),
		.adcdat(I2S_ADCDAT),
		.adcfifo_rdclk(clk),
		.adcfifo_read(adcfifo_read),
		.adcfifo_empty(adcfifo_empty),
		.adcfifo_readdata(adcfifo_readdata)
	);
	
	i2s_tx
	#(
		 .DATA_WIDTH(DATA_WIDTH)
	)i2s_tx
	(
		 .reset_n(reset_n),
		 .dacfifo_wrclk(clk),
		 .dacfifo_wren(dacfifo_write),
		 .dacfifo_wrdata(dacfifo_writedata),
		 .dacfifo_full(dacfifo_full),
		 .bclk(I2S_BCLK),
		 .daclrc(I2S_DACLRC),
		 .dacdat(I2S_DACDAT)
	);
	 
endmodule
