module echo
#(
parameter DATA_WIDTH=16
)
(
    input clk,
    input bclk,
    input reset_n,
    input [(DATA_WIDTH-1):0]audio_data_0,
    input [5:0]gain, // 增益参数
    output reg [(DATA_WIDTH-1):0]echo_data
);

    // 内部信号定义
    wire [(DATA_WIDTH-1):0] gain_result;
    wire [DATA_WIDTH:0] mixed_audio;
    wire [(DATA_WIDTH-1):0] delayed_audio;
    wire [11:0] delay_num;
    assign delay_num = 12'd4000; // 延时长度

     //实例化延时模块
    delay delay_inst (
        .clk(bclk),
        .reset_n(reset_n),
        .delay_num(delay_num),
        .in(gain_result),
        .out(delayed_audio)
    );

     //实例化增益模块
    gains gain_inst (
        .clk(clk),
        .reset_n(reset_n),
        .integer_input(mixed_audio), // 延时后的音频数据
        .decimal_input(gain),         // 增益参数
        .result_output(gain_result)   // 增益处理后的结果
    );

    // 实例化加法模块（用于叠加信号）
    adder add_inst (
        .clk(clk),
        .reset_n(reset_n),
        .a(audio_data_0),
        .b(delayed_audio), // 使用增益处理后的数据
        .sum(mixed_audio)
    );


    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            echo_data <= {DATA_WIDTH{1'b0}};
        end else begin
            echo_data <= mixed_audio; // 直接使用混合后的音频数据作为输出
        end
    end

endmodule