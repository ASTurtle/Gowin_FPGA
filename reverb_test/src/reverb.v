module reverb
#(
parameter DATA_WIDTH=32
)
(
    input clk,
    input reset_n,
    input [(DATA_WIDTH-1):0]audio_data_0,
    input [3:0]gain,//增益参数
    output reg[(DATA_WIDTH-1):0]reverb_data
);
  // 内部信号定义
    wire [(DATA_WIDTH-1):0] delayed_audio;
    wire [(DATA_WIDTH-1):0] gain_result;
    wire [(DATA_WIDTH-1):0] mixed_audio;

    // 实例化增益模块
    gains  gain_inst (
//        .clk(clk),
//        .reset_n(reset_n),
        .integer_input(delayed_audio),
        .decimal_input(gain),
        .result_output(gain_result)
    );

    // 实例化延时模块
    delay  delay_inst (
        .clk(clk),
        .reset_n(reset_n),
        .in(audio_data_0),
        .out(delayed_audio)
    );

    // 实例化加法/减法模块（用于叠加信号）
    add_sub  add_inst (
        .clk(clk),
        .reset_n(reset_n),
        .a(audio_data_0),
        .b(gain_result),
        .op(1'b0), // 设置为加法
        .result(mixed_audio)
    );

    // 根据 in_valid 信号选择输出
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
           
            reverb_data <= {DATA_WIDTH{1'b0}};
        end else  begin
      
            reverb_data <= mixed_audio;
        end
    end

endmodule