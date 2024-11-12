module distortion_effect(
    input wire clk,
    input wire reset_n,
    input wire signed [15:0] audio_in,
    output reg signed [15:0] audio_out
);

// 非线性失真函数的查找表
reg [15:0] distortion_lut[0:1024];
reg  [15:0] abs_audio_in;// 输入信号电平
// 失真处理中的临时变量，需要在always块外声明
reg signed [15:0] clipped_input;

// 初始化查找表
integer i; // 将integer类型的变量i声明移到模块的顶部
initial begin
    for (i = 0; i < 1024; i = i + 1) begin
        // 使用distortion_level参数来调整失真程度
        distortion_lut[i] = (i * i ) >> 4; // 一个简单的非线性映射，使用右移代替除法以提高性能
    end
end
// 失真处理
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        audio_out <= 16'd0;
    end else begin
        // 将输入信号限制在查找表的范围内，并修正条件判断逻辑
        abs_audio_in <= audio_in < 0 ? -audio_in : audio_in;
        clipped_input = (audio_in > 16'h007F) ? 16'h007F : (audio_in < -16'h0080) ? -16'h0080 : audio_in;
        // 通过查找表应用非线性失真
        audio_out <= distortion_lut[abs_audio_in[11:2] + 16'h0080]; // 加上16'h0080以将负数索引转换为正数
    end
end

endmodule