module compressor (
    input wire clk,          // 时钟信号
    input wire reset_n,      // 复位信号
    input signed [15:0] audio_in,  // 输入音频信号
    input en,                // 使能信号
    input [2:0]thre_para,
    output reg signed [15:0] audio_out // 输出音频信号
);

// 参数定义
parameter RATIO = 2;         // 压缩比,压缩比率定义了超过阈值的信号将被压缩多少。例如，一个4:1的压缩比意味着每增加4dB的输入信号，输出信号只增加1dB。
parameter ATTACK_TIME = 10;  // 攻击时间,压缩器开始响应输入信号超过阈值的时间。攻击时间越短，压缩器对信号的快速峰值反应越快。
parameter RELEASE_TIME = 50; // 释放时间,压缩器在输入信号电平低于阈值后，增益恢复到未压缩状态所需的时间。释放时间越长，压缩器在信号电平下降后增益恢复得越慢。
reg [13:0]threshold;
always@(*)
        case(thre_para)
            0:threshold = 14'd5000;
            1:threshold = 14'd6000;
            2:threshold = 14'd7000;
            3:threshold = 14'd8000;
            4:threshold = 14'd9000;
            5:threshold = 14'd10000;
            6:threshold = 14'd11000;
            7:threshold = 14'd12000;            
        endcase
// 内部变量
reg signed [15:0] gain;       // 当前增益
reg signed [15:0] input_level;// 输入信号电平
reg [15:0] attack_counter;    // 攻击计时器
reg [15:0] release_counter;   // 释放计时器
reg compression_active;       // 压缩激活标志
reg signed[15:0]audio_out;
wire signed[15:0]audio_out_0;
// 初始化
initial begin
    gain = 16'd32767; // 默认增益
    input_level = 0;
    attack_counter = 0;
    release_counter = 0;
    compression_active = 0;
end
gains gain_inst (
        .clk(clk),
        .reset_n(reset_n),
        .integer_input(audio_in), // 延时后的音频数据
        .decimal_input(gain[15:10]),         // 增益参数
        .result_output(audio_out_0)   // 增益处理后的结果
    );

// 音频信号处理
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // 复位逻辑
        gain <= 16'd32767;
        input_level <= 0;
        attack_counter <= 0;
        release_counter <=0;
        compression_active <= 0;
    end else begin
        // 计算输入信号电平
        input_level <= audio_in < 0 ? -audio_in : audio_in;
        // 检测是否超过阈值并激活压缩
        if (input_level > threshold ) begin
            compression_active <= 1;
            attack_counter <= ATTACK_TIME;
        end

        // 攻击阶段：快速减少增益
        if (compression_active && attack_counter > 0) begin
            gain <= gain - (gain / RATIO);
            attack_counter <= attack_counter - 1;
        end

        // 释放阶段：慢速恢复增益
        if (compression_active && input_level < threshold) begin
            release_counter <= release_counter + 1;
            if (release_counter >= RELEASE_TIME) begin
                 //gain <= gain + (1000/ RATIO);
                gain <= gain + ((16'd32767 - (gain< 0 ? -gain : gain))/ RATIO);
                release_counter <=  release_counter-1;
                if (gain >= 16'd32767) compression_active <= 0;
            end
        end
    end
end
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        audio_out <= 0;
    end else if (en) begin
        audio_out <= audio_out_0;
    end else begin
        audio_out <= audio_in;
    end
end

endmodule