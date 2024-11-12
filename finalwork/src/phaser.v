module phaser(
    input clk,
    input bclk,
    input reset_n,
    input signed [15:0] input_sample,
    input [2:0]gain_para,
    input en,
    input wr,
    input [2:0]freq_para,
    output reg signed [15:0] output_sample
    
);
parameter TAPS = 5;
wire signed [15:0] all_pass_outputs[TAPS-1:0]; // 存储5个全通滤波器的输出
reg [5:0]gain;
reg [8:0]wdata;
wire [15:0]mixed_audio;
wire [11:0] DDS_out;
wire signed [15:0] dds_p;
//wire signed [15:0] extended_DDS_out; // 扩展到16位以容纳可能的溢出
//reg signed [15:0] signed_constant = 16'b0000100000000000; // 定义为16位有符号数
reg signed [15:0] output_sample_0;
wire signed[15:0]wet_sample;
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

//assign extended_DDS_out= {5{DDS_out[11]},DDS_out[10:0]};
//assign DDS_ABS = DDS_out + 12'b100000000000;
// 参数定义分频因子
parameter DIV_FACTOR = 12500;
// 计数器寄存器
reg [15:0] counter = 0;

// 输出时钟信号
reg clk_out_reg = 0;

// 时钟分频逻辑
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // 异步复位：计数器和输出时钟信号重置为0
        counter <= 0;
        clk_out_reg <= 0;
    end else begin
        // 计数器达到分频因子时翻转输出时钟信号
        if (counter == (DIV_FACTOR - 1)) begin
            counter <= 0;
            clk_out_reg <= ~clk_out_reg;
        end else begin
            counter <= counter + 1;
        end
    end
end
 DDS_p  dds(
    .clk(bclk),
    .rstn(reset_n),
    .wr(wr),
    .waddr(16'b0000000000110000),
    .wdata(wdata),
    .dout(dds_p),
    .out_valid()
);
    // 5个全通滤波器实例
    genvar i;
    generate
        for (i = 0; i < TAPS; i = i + 1) begin : allpass_filters
            allpass_filter filter_instance (
                .clk(clk),
                .reset(!reset_n),
                .input_sample((i == 0) ? input_sample : all_pass_outputs[i-1]),
                .feedback_coefficient(dds_p),
                .output_sample(all_pass_outputs[i])
            );
        end
    endgenerate
    //实例化增益模块
    gains gain_inst (
        .clk(bclk),
        .reset_n(reset_n),
        .integer_input(all_pass_outputs[TAPS-1]), // 延时后的音频数据
        .decimal_input(gain),         // 增益参数
        .result_output(wet_sample)   // 增益处理后的结果
    );

    // 实例化加法模块（用于叠加信号）
    adder add_inst (
        .clk(clk),
        .reset_n(reset_n),
        .a(input_sample),
        .b(wet_sample), // 使用增益处理后的数据
        .sum(mixed_audio)
    );

    // 混合原始信号和经过全通滤波器处理的信号
    always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        output_sample  <= 16'd0;
    end else begin
        // 直接使用混合后的音频数据作为中间输出
        //output_sample_0 <= mixed_audio;
        if (en) begin
            output_sample <= mixed_audio; // 使能为1时，输出模块的输出
        end else begin
            output_sample <= input_sample; // 使能为0时，输出输入信号
        end
    end
end
endmodule