module audio_loopback(
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
        //output reg shared_clk
        output dacfifo_write 
);
	
	parameter DATA_WIDTH        = 32;  
    parameter HALF_DATA_WIDTH        = 16;     
	wire [DATA_WIDTH-1:0] echo_out;
    reg [DATA_WIDTH-1:0] echo_in;
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
	wire [DATA_WIDTH - 1:0] adcfifo_readdata;
	wire adcfifo_empty;

	reg dacfifo_write;
	reg [DATA_WIDTH - 1:0] dacfifo_writedata;
	wire dacfifo_full;
	wire signed[5:0]gain_0;
    assign gain_0=6'b011111;
    wire signed[5:0]gain_1;
    assign gain_1=6'b011111;
    wire [HALF_DATA_WIDTH-1:0] echo_out_0;
    reg [HALF_DATA_WIDTH-1:0] echo_in_0;
    wire [HALF_DATA_WIDTH-1:0] echo_out_1;
    reg [HALF_DATA_WIDTH-1:0] echo_in_1;
     wire [HALF_DATA_WIDTH-1:0] lowp_0_out;
       reg [HALF_DATA_WIDTH-1:0] lowp_0_in;
 wire [HALF_DATA_WIDTH-1:0] lowp_1_out;
       reg [HALF_DATA_WIDTH-1:0] lowp_1_in;
        reg [HALF_DATA_WIDTH-1:0]audio_left;
        reg [HALF_DATA_WIDTH-1:0]audio_right;
         wire [HALF_DATA_WIDTH-1:0] fenli_audio;
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
//混响与回声       
			echo_in_0<= adcfifo_readdata[15:0];
            echo_in_1 <= adcfifo_readdata[31:16];
            lowp_0_in<= echo_out_0;
            dacfifo_writedata[15:0]<=lowp_0_out;
            lowp_1_in<= echo_out_1;
            dacfifo_writedata[31:16]<=lowp_1_out;

//          dacfifo_writedata<= adcfifo_readdata;

//分离人声，有点问题
//                     audio_left<= adcfifo_readdata[15:0];
//                       audio_right<= adcfifo_readdata[31:16];
//                      dacfifo_writedata[15:0]<=  fenli_audio;
//                         dacfifo_writedata[31:16]<=  fenli_audio;  

		end
		else begin
			dacfifo_write <= 1'd0;
		end
	end
 filter_lowpass lowp_0
               (
                .clk(clk),
                .clk_enable(1'b1),
                .reset_n(reset_n),
                .filter_in(lowp_0_in),
                .filter_out(lowp_0_out)
                );
filter_lowpass lowp_1
               (
                .clk(clk),
                .clk_enable(1'b1),
                .reset_n(reset_n),
                .filter_in(lowp_1_in),
                .filter_out(lowp_1_out)
               );







echo
#(
    .DATA_WIDTH(HALF_DATA_WIDTH)
)echo_0
(
     .clk(clk),
     .bclk(dacfifo_write),
     .reset_n(reset_n),
     .audio_data_0(echo_in_0),
     .gain(gain_0),
     .echo_data(echo_out_0)
);
echo
#(
    .DATA_WIDTH(HALF_DATA_WIDTH)
)echo_1
(
     .clk(clk),
     .bclk(dacfifo_write),
     .reset_n(reset_n),
     .audio_data_0(echo_in_1),
     .gain(gain_1),
     .echo_data(echo_out_1)
);

adder add_fenli (
        .clk(clk),
        .reset_n(reset_n),
        .a(audio_left),
        .b(~audio_right), // 使用增益处理后的数据
        .sum(fenli_audio)
    );


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
