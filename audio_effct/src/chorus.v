module chorus
#(
parameter DATA_WIDTH=16
)
(
    input clk,
    input bclk,
    input en,
    input reset_n,
    input [(DATA_WIDTH-1):0]audio_data_0,
    input [2:0]gain_para, // 增益参数
    input  wr, 
    input [2:0]freq_para,
    output reg [(DATA_WIDTH-1):0]chorus_data
);
 // 内部信号定义
    reg[5:0]gain;
    reg [8:0]wdata;
    parameter waddr=8'b00110000;
    reg [(DATA_WIDTH-1):0]chorus_data_0;
    wire [(DATA_WIDTH-1):0] gain_result;
    wire [DATA_WIDTH:0] mixed_audio;
    wire [(DATA_WIDTH-1):0] delayed_audio;
    wire signed[12:0] delay_num;
    wire signed [12:0]DDS_out;
    wire signed [12:0]DDS_0;
    assign DDS_0 ={{DDS_out[12]},{DDS_out[12]},{DDS_out[12]},DDS_out[11:2]};
    wire signed [12:0]delay_origin =13'b0101110111000;
    assign delay_num = (delay_origin+DDS_0); // 延时长    
     //实例化延模块
delay_changable#(
		
	)delay_chorus (
        .clk(bclk),
        .rst_n(reset_n),
       .delay(delay_num[11:0]),
        //.delay(12'b101110111000),
        .inputData(audio_data_0),
        .outputData(delayed_audio),
        .delayFull()
    );
    DDS_Top DDS_cho(
    .clk(bclk),
    .rstn(reset_n),
    .wr(wr),
    .waddr(waddr),
    .wdata(wdata),
    .dout(DDS_out),
    .out_valid(out_valid)
       );

     //实例化增益模块
    gains gain_inst (
        .clk(clk),
        .reset_n(reset_n),
        .integer_input(delayed_audio), // 延时后的音频数据
        .decimal_input(gain),         // 增益参数
        .result_output(gain_result)   // 增益处理后的结果
    );

    // 实例化加法模块（用于叠加信号）
    adder add_inst (
        .clk(clk),
        .reset_n(reset_n),
        .a(audio_data_0),
        .b(gain_result), // 使用增益处理后的数据
        .sum(mixed_audio)
    );

    always@(*)
        case(gain_para)
            0:gain = 6'b000000;
            1:gain = 6'b000100;
            2:gain = 6'b001000;
            3:gain = 6'b001100;
            4:gain = 6'b010000;
            5:gain = 6'b010100;
            6:gain = 6'b011000;
            7:gain = 6'b011100; 
        endcase
     always@(*)
        case(freq_para)
            0:wdata = 9'b000000001;
            1:wdata = 9'b000000010;
            2:wdata = 9'b000000100;
            3:wdata = 9'b000001000;
            4:wdata = 9'b000010000;
            5:wdata = 9'b000100000;
            6:wdata = 9'b001000000;
            7:wdata = 9'b010000000;  
        endcase
    always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        chorus_data <= 16'd0;
    end else begin
        if (en) begin
            chorus_data <= mixed_audio; // 使能为1时，输出原模块的输出
        end else begin
            chorus_data <= audio_data_0; // 使能为0时，输出输入信号
        end
    end
end


endmodule