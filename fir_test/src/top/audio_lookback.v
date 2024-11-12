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
    wire ONE ;
    assign ONE = 1'b1;
    wire ONE_0;
    assign ONE_0 =1'b1;
wire ONE_1;
    assign ONE_1=1'b1;
wire ONE_2;
    assign ONE_2=1'b1;
wire ONE_3;
    assign ONE_3=1'b1;
wire ONE_4;
    assign ONE_4=1'b1;
wire ONE_5;
    assign ONE_5=1'b1;
wire ONE_6;
    assign ONE_6=1'b1;
wire ONE_7;
    assign ONE_7=1'b1;
wire ONE_8;
    assign ONE_8=1'b1;
	
    Gowin_PLL Gowin_PLL(
        .clkout0(I2S_MCLK), //output clkout0
        .clkin(clk) //input clkin
    );
	
 	wire Init_DONE;
	WM8960_Init WM8960_Init(
		.Clk(clk),
		.Rst_n(reset_n),
		.I2C_Init_Done(Init_Done),
		.i2c_sclk(iic_0_scl),
		.i2c_sdat(iic_0_sda)
	);
	
	assign led = Init_DONE;
	
	reg adcfifo_read;
	wire [DATA_WIDTH - 1:0] adcfifo_readdata;
//    wire [DATA_WIDTH-1:0] filter_data_out;
//    reg [DATA_WIDTH-1:0] filter_data_in;
    wire [(DATA_WIDTH-1)/2:0] filter_data_out_1;  //1前16位,2后16位
    reg [(DATA_WIDTH-1)/2:0] filter_data_in_1;
    wire [(DATA_WIDTH-1)/2:0] filter_data_out_2;
    reg [(DATA_WIDTH-1)/2:0] filter_data_in_2;
	wire adcfifo_empty;
	reg dacfifo_write;
	reg [DATA_WIDTH - 1:0] dacfifo_writedata;
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
//			filter_data_in <= adcfifo_readdata;
//            dacfifo_writedata <= filter_data_out;
            filter_data_in_1 <= adcfifo_readdata[15:0];
            dacfifo_writedata[15:0] <= filter_data_out_1;
             filter_data_in_2 <= adcfifo_readdata[31:16];
            dacfifo_writedata[31:16] <= filter_data_out_2;


		end
		else begin
			dacfifo_write <= 1'd0;
		end
	end
//    filter_0 filter_0(
//                .fclk(clk),
//                .reset(reset_n),
//                .filter_in(filter_data_in),
//                .filter_out(filter_data_out)
//);
 Advanced_FIR_Filter_Top filter_1(
  .clk(clk),
  .rstn(reset_n),
  .fir_rfi_o(ONE),
  .fir_valid_i(ONE_0),
  .fir_sync_i(ONE_1),
  .fir_data_i(filter_data_in_1),
  .fir_valid_o(ONE_2),
  .fir_sync_o(ONE_3),
  .fir_data_o(filter_data_out_1)
)
;
 Advanced_FIR_Filter_Top filter_2(
  .clk(clk),
  .rstn(reset_n),
  .fir_rfi_o(ONE_4),
  .fir_valid_i(ONE_5),
  .fir_sync_i(ONE_6),
  .fir_data_i(filter_data_in_2),
  .fir_valid_o(ONE_7),
  .fir_sync_o(ONE_8),
  .fir_data_o(filter_data_out_2)
)
;
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
