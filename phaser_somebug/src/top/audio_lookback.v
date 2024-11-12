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
		output I2S_MCLK
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
	wire [DATA_WIDTH - 1:0] adcfifo_readdata;
	wire adcfifo_empty;

	reg dacfifo_write;
	reg [DATA_WIDTH - 1:0] dacfifo_writedata;
	wire dacfifo_full;
	reg[15:0]phaser_in_0,phaser_in_1,hpfilter_in_0;
    wire[15:0]phaser_out_0,phaser_out_1,hpfilter_out_0;

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
			phaser_in_0<= adcfifo_readdata[15:0];
            dacfifo_writedata [15:0]<=phaser_out_0;
            phaser_in_1<= adcfifo_readdata[31:16];
            dacfifo_writedata [31:16]<=phaser_out_1;
//            hpfilter_in_0<= adcfifo_readdata[15:0];
//            dacfifo_writedata [15:0]<=hpfilter_out_0;
           // phaser_in_1<= adcfifo_readdata[31:16];
            //dacfifo_writedata [31:16]<=phaser_out_1;
		end
		else begin
			dacfifo_write <= 1'd0;
		end	end
 phaser phaser_0(
    .clk(clk),
    .reset(!reset_n),
    .input_sample(phaser_in_0),
    //.bclk(dacfifo_write),
    .output_sample(phaser_out_0),
    .dry_sample(),
    .wet_sample()
);
phaser phaser_1(
    .clk(clk),
    .reset(!reset_n),
    //.bclk(dacfifo_write),
    .input_sample(phaser_in_1),
    .output_sample(phaser_out_1),
    .dry_sample(),
    .wet_sample()

);
halfpass_filter halfpass_filter_0(
    .clk(clk),
    .clk_enable(1'b1),
    .reset_n(reset_n),
    .filter_in(hpfilter_in_0),
    .filter_out(hpfilter_out_0)
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
