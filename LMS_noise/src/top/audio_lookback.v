module audio_lookback(
		input clk,                    
		input reset_n,                                   
		inout iic_0_scl,              
		inout iic_0_sda,   
	    output led,
		
		input I2S_ADCDAT,
		input I2S_ADCLRC,
		input I2S_BCLK,
		output I2S_DACDAT,
		input I2S_DACLRC,
		output I2S_MCLK,
        output dacfifo_write,
 output wire constant_signal 

);
	
	parameter DATA_WIDTH        = 32;     
	
    Gowin_PLL Gowin_PLL(
        .clkout0(I2S_MCLK), //output clkout0
        .clkin(clk) //input clkin
    );
	
 	wire Init_Done;
	WM8960_Init WM8960_Init(
		.Clk(clk),
		.Rst_n(reset_n),
		.I2C_Init_Done(Init_Done),
		.i2c_sclk(iic_0_scl),
		.i2c_sdat(iic_0_sda)
	);
	
	assign led = Init_Done;
	
	reg adcfifo_read;
	wire [DATA_WIDTH - 1:0] adcfifo_readdata,audio_noise,random_bits;
	wire adcfifo_empty;
     reg [15:0] eq_1_in;
    wire[18:0]eq_1_out;
	reg dacfifo_write;
	reg [DATA_WIDTH - 1:0] dacfifo_writedata,audio_0;
    reg[15:0]fft_in,din_0,xin_0;
    wire[15:0]fft_out,yout_0,err_0;
	wire dacfifo_full;
	reg dacfifo_write;
    
//reg constant_signal;
//always @(posedge clk or negedge reset_n) begin
//    if (~reset_n) begin
//        constant_signal <= 1'b0; // 如果复位信号为高，则输出信号复位为0
//    end else begin
//        constant_signal <= 1'b1; // 否则，在每个时钟上升沿将输出信号设置为1
//    end
//end


reg signal_internal;  

always @(posedge clk or negedge reset_n) begin  
    if (~reset_n) begin  
        signal_internal <= 1'b0; // 复位状态  
    end else begin  
        signal_internal <= 1'b1; // 在时钟上升沿时设为1  
    end  
end  

assign constant_signal = signal_internal; // 连接内部信号到输出信号  


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
            audio_0 <= adcfifo_readdata;
        din_0 <= audio_noise[15:0];
        xin_0 <= adcfifo_readdata[15:0];
            dacfifo_writedata[15:0] <=yout_0;
		end
		else begin
			dacfifo_write <= 1'd0;
		end
	end



FFT_Top fft(
  .idx(),
  .xk_re(fft_out),
  .xk_im(),
  .sod(),
  .ipd(),
  .eod(),
  .busy(),
  .soud(),
  .opd(),
  .eoud(),
  .xn_re(fft_in),
  .xn_im(),
  .start(1'b1),
  .clk(dacfifo_write),
  .rst(!reset_n)
)
;
lms lms_0(
    .clk(clk),
    .rst_n(reset_n),
    .en(1'b1),
    .din(din_0),
    .xin(xin_0),
    .u(7'd8),
    .yout(yout_0),//无噪声
    .err(err_0),//两个信号差值
    .wout(wout_0),
    .update(update)  
);

noise_audio noise_audio (
    .clk(clk),
    .reset_n(reset_n),
    .input_audio(audio_0),
    .random_bits(random_bits),
    .noise_audio(audio_noise)
);






//Equalizer eq_1(
// .clk(clk),
//  .rstn(reset_n),
//  .ce(1'b1),
//  .in_valid(1'b1),
//  .din(eq_1_in),
//  .gainwe(1'b1),
//  .gainset(1'b1),
//  .gain(3'b011),
//  .in_ready(),
//  .out_valid(),
//  .dout(eq_1_out)
//)
//;

//Equalizer_Top eq_2(
//  .clk(),
//  .rstn(),
//  .ce(),
//  .in_valid(),
//  .din(),
//  .gainwe(),
//  .gainset(),
//  .gain(),
//  .in_ready(),
//  .out_valid(),
//  .dout()
//)
//;



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
