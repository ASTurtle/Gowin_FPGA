module audio_fft #
(
    parameter FFT_POINTS = 1024, // FFT点数
    parameter DATA_WIDTH = 16    // 数据宽度
)
(
    input wire clk,                // 时钟信号
    input wire rst,                // 复位信号
    input wire start,              // 开始信号
    input wire signed [DATA_WIDTH-1:0] audio_data, // 音频数据输入
    output wire [DATA_WIDTH-1:0] freq_data_real, // 频谱数据实部输出
    output wire [DATA_WIDTH-1:0] freq_data_imag, // 频谱数据虚部输出（虽然我们不使用它）
    output wire fft_done           // FFT完成信号
);

    // FFT IP核实例化
    FFT_Top #(
        .FFT_POINTS(FFT_POINTS),
        .DATA_WIDTH(DATA_WIDTH)
    ) fft_inst (
        .clk(clk),
        .rst(rst),
        .start(start),
        .xn_re(audio_data),       // 实部输入
        .xn_im(0),                 // 虚部输入（设为0）
        .clk_en(1'b1),             // 时钟使能
        .rst_n(1'b1),              // 复位使能
        .busy(fft_done),           // FFT完成信号
        .xk_re(freq_data_real),    // 实部输出
        .xk_im(freq_data_imag)     // 虚部输出
    );

    // 其他控制逻辑（如启动条件、数据流控制等）可以根据需要添加

endmodule