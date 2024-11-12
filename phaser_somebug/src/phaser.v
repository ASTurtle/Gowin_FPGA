module phaser(
    input clk,
    input reset,
    input signed [15:0] input_sample,
    output reg signed [15:0] output_sample,
    output reg signed [15:0] dry_sample, // 未经处理的原始信号
    output reg signed [15:0] wet_sample // 经过Phaser处理的信号
);
    reg signed [15:0] lfo_phase; // LFO的当前相位
    reg signed [15:0] lfo_output; // LFO的输出，用于调制全通滤波器的反馈系数
    wire signed [15:0] all_pass_outputs[4:0]; // 存储5个全通滤波器的输出

   
wire signed [11:0] DDS_out;
   reg signed [15:0] DDS_ABS;
reg signed [15:0] extended_DDS_out; // 扩展到16位以容纳可能的溢出
reg signed [15:0] signed_constant = 16'b0000100000000000; // 定义为16位有符号数

always @* begin
if (DDS_out[11])begin
    // 将DDS_out扩展到16位，并保持符号位
    extended_DDS_out = {DDS_out[11], 4'b1111, DDS_out[10:0]};
end else begin
    extended_DDS_out = {DDS_out[11], 4'b0000, DDS_out[10:0]};
end
    // 计算DDS_ABS
    DDS_ABS = extended_DDS_out + signed_constant;
end
 DDS_Top  dds(
    .clk(clk),
    .rstn(!reset),
    .wr(wr),
    .waddr(waddr),
    .wdata(wdata),
    .dout(DDS_out),
    .out_valid(out_valid)
);
    // 5个全通滤波器实例
    genvar i;
    generate
        for (i = 0; i < 5; i = i + 1) begin : allpass_filters
            allpass_filter filter_instance (
                .clk(clk),
                .reset(reset),
                .input_sample((i == 0) ? input_sample : all_pass_outputs[i-1]),
                .feedback_coefficient(DDS_ABS>>2),
                .output_sample(all_pass_outputs[i])
            );
        end
    endgenerate

    // 混合原始信号和经过全通滤波器处理的信号
    always @(posedge clk) begin
        if (reset) begin
            output_sample <= 16'd0;
            dry_sample <= 16'd0;
            wet_sample <= 16'd0;
        end else begin
            dry_sample <= input_sample; // 原始信号
            wet_sample <= all_pass_outputs[4]; // 最后一个全通滤波器的输出
            output_sample <= (dry_sample + wet_sample); // 混合信号
        end
    end
endmodule