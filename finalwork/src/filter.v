// 定义一个名为filter的模块，用于实现滤波器功能
module filter #(
    // 定义参数，包括输入/输出位数、计数器位数、抽头数量和系数位数等
    parameter FILTER_IN_BITS = 16,
    parameter FILTER_OUT_BITS = 16,
    parameter COUNTER_BITS = 6,
    parameter NUMBER_OF_TAPS = 64,
    parameter COEFF_BITS = 16,
    parameter COEFF_FRAC_BITS = 16
) (
    // 定义输入输出端口，包括时钟、复位、使能信号等
    input clk, // 时钟信号
    input rst, // 复位信号
    input clk_enable, // 时钟使能信号

    // delay_pipeline相关信号
    input phase_min, // 相位最小信号
    input signed [FILTER_IN_BITS-1:0] amplified_filter_in, // 放大后的滤波器输入信号

    // 系数相关信号
    input [COUNTER_BITS-1:0] current_count, // 当前计数器值
    input [COEFF_BITS*NUMBER_OF_TAPS-1:0] coeffs_feed, // 系数输入信号

    // 滤波器输出信号
    output signed [FILTER_OUT_BITS-1:0] filtered_out // 滤波后的输出信号
);

  // 系数处理部分
  wire signed [COEFF_BITS-1:0] coeff; // 单个系数输出

  // 实例化coeffs模块，用于处理系数
  coeffs #(
      .COUNTER_BITS(COUNTER_BITS),
      .NUMBER_OF_TAPS(NUMBER_OF_TAPS),
      .COEFF_BITS(COEFF_BITS)
  ) coeffs_inst (
      .current_count(current_count),
      .coeffs(coeffs_feed),
      .coeff(coeff) // 输出当前抽头对应的系数
  );

  // 延迟管道部分
  wire signed [FILTER_IN_BITS-1:0] delay_filter_in; // 延迟后的输入信号

  // 实例化delay_pipeline模块，用于实现输入信号的延迟
  delay_pipeline #(
      .FILTER_IN_BITS(FILTER_IN_BITS),
      .FILTER_OUT_BITS(FILTER_OUT_BITS),
      .COUNTER_BITS(COUNTER_BITS),
      .NUMBER_OF_TAPS(NUMBER_OF_TAPS)
  ) delay_pipeline_inst (
      .clk(clk),
      .rst(rst),
      .phase_min(phase_min),
      .current_count(current_count),
      .filter_in(amplified_filter_in),
      .delay_filter_in(delay_filter_in) // 输出延迟后的输入信号
  );

  // 计算部分
  // 实例化compute模块，用于根据系数和延迟后的输入信号计算滤波器的输出
  compute #(
      .FILTER_IN_BITS(FILTER_IN_BITS),
      .FILTER_OUT_BITS(FILTER_OUT_BITS),
      .NUMBER_OF_TAPS(NUMBER_OF_TAPS),
      .COEFF_BITS(COEFF_BITS),
      .COEFF_FRAC_BITS(COEFF_FRAC_BITS)
  ) compute_inst (
      .clk(clk),
      .rst(rst),
      .clk_enable(clk_enable),
      .delay_filter_in(delay_filter_in),
      .coeff(coeff),
      .phase_min(phase_min),
      .filter_out(filtered_out) // 输出滤波后的信号
  );

endmodule // 结束filter模块的定义