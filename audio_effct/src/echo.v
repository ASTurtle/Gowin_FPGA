module echo
#(
parameter DATA_WIDTH=16
)
(
    input clk,
    input bclk,
    input reset_n,
    input [(DATA_WIDTH-1):0]audio_data_0,
    input en,
    input [2:0] delay_para,
    input [2:0] gain_para,
    output reg [(DATA_WIDTH-1):0]echo_data
);

    // 内部信号定义
    reg [(DATA_WIDTH-1):0]echo_data_0;
    wire [(DATA_WIDTH-1):0] gain_result;
    wire [DATA_WIDTH:0] mixed_audio;
    reg [5:0]gain;
    wire [(DATA_WIDTH-1):0] delayed_audio;
    reg [11:0] delay_num;    
    always@(*)
        case(delay_para)
            0:delay_num = 500;
            1:delay_num = 1000;
            2:delay_num = 1500;
            3:delay_num = 2000;
            4:delay_num = 2500;
            5:delay_num = 3000;
            6:delay_num = 3500;
            7:delay_num = 4000;
        endcase
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
     //实例化延时模块
    delay delay_echo (
        .clk(bclk),
        .reset_n(reset_n),
        .delay_num(delay_num),
        .in(audio_data_0),
        .out(delayed_audio)
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


   always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        echo_data <= 16'd0;
        echo_data_0 <= 16'd0;
    end else begin
    echo_data_0<=mixed_audio;
        if (en) begin
            echo_data <= echo_data_0; // 使能为1时，输出原模块的输出
        end else begin
            echo_data <= audio_data_0; // 使能为0时，输出输入信号
        end
    end
end

endmodule