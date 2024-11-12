module echo
#(
parameter DATA_WIDTH=16
)
(
    input clk,
    input reset_n,
    input [(DATA_WIDTH-1):0]audio_data_0,
    input [5:0]gain,//增益参数
    output reg[(DATA_WIDTH-1):0]echo_data,
    output wire Almost_Full,
    output  wire Almost_Empty
);
  // 内部信号定义
    wire [(DATA_WIDTH-1):0] gain_result;
    wire [(DATA_WIDTH-1):0] mixed_audio;
    wire [(DATA_WIDTH-1):0] delayed_audio;
    

    
    // 实例化增益模�?
    gains  gain_inst (
        .clk(clk),
        .reset_n(reset_n),
        .integer_input(delayed_audio),
        .decimal_input(gain),
        .result_output(gain_result)
    );

    // 实例化延时模�?
    delay  delay_inst (
        .clk(clk),
        .reset_n(reset_n),
        .delay_num(12'd4096),
        .in(audio_data_0),
        .out(delayed_audio),
        .fifoFull(Almost_Full),
        .Almost_Empty(Almost_Empty)
    );

    // 实例化加�?/减法模块（用于叠加信号）
    add_sub  add_inst (
        .clk(clk),
        .reset_n(reset_n),
        .a(audio_data_0),
        .b(gain_result),
        .op(1'b0), // 设置为加�?
        .result(mixed_audio)
    );

    // 根据 in_valid 信号选择输出
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
           
            echo_data <= {DATA_WIDTH{1'b0}};
        end else  begin
      
            echo_data <= mixed_audio;
        end
    end

endmodule