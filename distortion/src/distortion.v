module distortion(
    input wire clk,
    input wire reset_n,
    input wire signed [15:0] audio_in,
    output reg signed [15:0] audio_out
);

// 非线性失真函数的查找表
reg [15:0] distortion_lut[0:1024];
reg  [15:0] abs_audio_in;// 输入信号电平
reg[15:0]abs_audio_out;
reg sign_audio_n ;
// 初始化查找表
integer i; // 将integer类型的变量i声明移到模块的顶部
initial begin
    for (i = 0; i < 1024; i = i + 1) begin
        // 使用distortion_level参数来调整失真程度
        distortion_lut[i] = (i * i ) >> 5; // 一个简单的非线性映射，使用右移代替除法以提高性能
    end
end
// 失真处理
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        audio_out <= 16'd0;
    end 
    else begin
        // 将输入信号限制在查找表的范围内，并修正条件判断逻辑
        abs_audio_in <= audio_in < 0 ? -audio_in : audio_in;
        sign_audio_n<=audio_in[15];
        abs_audio_out<= distortion_lut[abs_audio_in[12:3]]; // 
       if (sign_audio_n) begin
        audio_out <= -abs_audio_out;
    end else begin
        audio_out <= abs_audio_out;
    end
    end
end

endmodule