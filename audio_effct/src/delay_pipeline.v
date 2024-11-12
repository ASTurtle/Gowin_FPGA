module delay_pipeline #(
    parameter FILTER_IN_BITS = 16,
    parameter FILTER_OUT_BITS = 16,
    parameter COUNTER_BITS = 6,
    parameter NUMBER_OF_TAPS = 64
) (
    input clk,
    input rst,

    input phase_min,  // 来自计数器的 phase_min 信号，用于触发新的 filter_in 样本移入
    input [COUNTER_BITS-1:0] current_count,  // 来自计数器的 current_count 信号，用于选择特定时间延迟的 filter_in

    input signed [FILTER_IN_BITS-1:0] filter_in,  // 来自滤波器的 filter_in 信号

    output signed [FILTER_OUT_BITS-1:0] delay_filter_in  // 与 filter_in 数据类型相同。有符号整数 16 位。范围：[-32768, 32768 - 1]
);

  localparam NUMBER_OF_PIPE = NUMBER_OF_TAPS;
  integer pipe_index;

  // 存储来自滤波器模块的当前和过去的 filter_in 值
  // 与 filter_in 数据类型相同。有符号整数 16 位。范围：[-32768, 32768 - 1]
  reg signed [FILTER_IN_BITS-1:0] delay_pipeline[0:NUMBER_OF_PIPE-1];

  always @(posedge clk or posedge rst) begin
    if (rst == 1) begin
      // 重置移位寄存器
      for (pipe_index = 0; pipe_index < NUMBER_OF_PIPE; pipe_index = pipe_index + 1) begin
        delay_pipeline[pipe_index] <= 0;
      end
    end else begin
      // 如果 phase_min 被触发，则移位以存储新的 filter_in 值
      if (phase_min == 1) begin
        // 将新样本加载到第一级
        delay_pipeline[0] <= filter_in;
        // 通过管道移位数据
        for (pipe_index = 1; pipe_index < NUMBER_OF_PIPE; pipe_index = pipe_index + 1) begin
          delay_pipeline[pipe_index] <= delay_pipeline[pipe_index-1];
        end
      end
    end
  end

  // 多路复用器
  // current_count 遍历任何 delay_pipeline，即当前和过去的输入样本
  // delay_filter_in 返回 current_count 索引处的每个 delay_pipeline，即特定延迟时间的输入样本
  assign delay_filter_in = delay_pipeline[current_count];

endmodule  // delay_pipeline