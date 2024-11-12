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
	reg unsigned [2:0]inte_deci_num =3'b010;
    Gowin_PLL Gowin_PLL(
        .clkout0(I2S_MCLK), //output clkout0
        .clkin(clk), //input clkin
        .clkout1(standard_clk)
    );
	reg[15:0]sample_filter_in_0,sample_filter_in_1;
    wire[15:0]sample_filter_out_0,sample_filter_out_1;
 	wire Init_Done;
    wire [31:0]filtered_data_out;
	WM8960_Init WM8960_Init(
		.Clk(clk),
		.Rst_n(reset_n),
		.I2C_Init_Done(Init_Done),
		.i2c_sclk(iic_0_scl),
		.i2c_sdat(iic_0_sda)
	);
	
	assign led = filtered_data_out[2];
	
	reg adcfifo_read;
	wire [DATA_WIDTH - 1:0] adcfifo_readdata,sample_data_out;
	wire adcfifo_empty;

	reg dacfifo_write;
	reg [DATA_WIDTH - 1:0] dacfifo_writedata,sample_data_in;
	wire dacfifo_full;
	

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
			sample_data_in<= adcfifo_readdata;
            dacfifo_writedata<=filtered_data_out;
		end
		else begin
			dacfifo_write <= 1'd0;
		end
	end
    sample_switch #(
    
	)sampe_switch(
        .clk(clk),
        .reset_n(reset_n),
        .clk_enable(1'b1),
        .sample_clk(standard_clk),
        .inte_deci_num(inte_deci_num),
        .data_in(sample_data_in),
        .sample_in(dacfifo_write),
        .data_out(sample_data_out),
        .factor_clk(factor_clk),
        .filtered_data_out(filtered_data_out)
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
