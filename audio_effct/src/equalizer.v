module equalizer #(
    parameter FILTER_IN_BITS = 16,
    parameter FILTER_OUT_BITS = 16,
    parameter NUMBER_OF_FILTERS = 10,
    parameter GAIN_BITS = 4,
    parameter GAIN_FRAC_BITS = 0,
    parameter COUNTER_MIN = 6'b000000,
    parameter COUNTER_MAX = 6'b001111,
    parameter COUNTER_BITS = $clog2(COUNTER_MAX),

    parameter NUMBER_OF_TAPS = 11,
    parameter COEFF_BITS = 16,
    parameter COEFF_FRAC_BITS = 15,

    parameter FILTER_COEFFS_TXT = "C:/Users/Asus/Desktop/eq_10_11tap.txt"
) (
    // 系统信号端口
    input clk,
    input clk_enable,
    input rst,
    input en,
    input amplifier_enable,
    input [NUMBER_OF_FILTERS*GAIN_BITS-1:0] amplifier_gains,
    // 滤波器模块端口
    input signed [FILTER_IN_BITS-1:0] filter_in,  // 有符号整数 16 位。范围：[-32768, 32768 - 1]
    output reg signed [FILTER_OUT_BITS-1:0] filter_out // 有符号整数 16 位。范围：[-32768, 32768 - 1]
);

  // 参数区域
  // endregion 参数

  // 计数器区域
  wire [COUNTER_BITS-1:0] current_count;
  wire phase_min;

  counter #(
      .COUNTER_MIN(COUNTER_MIN),
      .COUNTER_MAX(COUNTER_MAX)
  ) counter_inst (
      .clk(clk),
      .clk_enable(clk_enable),
      .rst(rst),

      .current_count(current_count),
      .phase_min(phase_min)
  );
  // endregion 计数器

  // 放大器区域
  wire [NUMBER_OF_FILTERS*FILTER_IN_BITS-1:0] amplified_filter_ins;
  wire [FILTER_IN_BITS-1:0] v_amplified_filter_ins[0:NUMBER_OF_FILTERS-1];

  amplifier #(
      .NUMBER_OF_FILTERS(NUMBER_OF_FILTERS),
      .GAIN_BITS(GAIN_BITS),
      .GAIN_FRAC_BITS(GAIN_FRAC_BITS),
      .FILTER_IN_BITS(FILTER_IN_BITS)
  ) amplifier_inst (
      .en(amplifier_enable),
      .gains(amplifier_gains),
      .filter_in(filter_in),
      .amplified_filter_ins(amplified_filter_ins)
  );
  // endregion 放大器

  // 延迟管道区域
  wire signed [FILTER_IN_BITS-1:0] delay_filter_in[0:NUMBER_OF_FILTERS-1];
  // endregion 延迟管道

  // 系数区域
  reg [COEFF_BITS*NUMBER_OF_TAPS-1:0] coeffs[0:NUMBER_OF_FILTERS-1];
  wire signed [COEFF_BITS-1:0] coeff[0:NUMBER_OF_FILTERS-1];

  initial begin
    // 从文本文件中读取每个滤波器的系数
    $readmemb(FILTER_COEFFS_TXT, coeffs);
  end
  // endregion 系数

  // 计算区域
  wire signed [FILTER_OUT_BITS-1:0] filtered_out[0:NUMBER_OF_FILTERS-1];
  wire [NUMBER_OF_FILTERS*FILTER_OUT_BITS-1:0] filtered_outs;
  // endregion 计算

  // 生成滤波器区域
    reg signed [FILTER_OUT_BITS-1:0] filter_out;
  generate
    genvar filter_index;
    for (
        filter_index = 0; filter_index < NUMBER_OF_FILTERS; filter_index = filter_index + 1
    ) begin : gen_filters

      // 放大器生成区域
      assign v_amplified_filter_ins[filter_index] = amplified_filter_ins[(filter_index+1)*FILTER_IN_BITS-1:filter_index*FILTER_IN_BITS];
      // endregion 放大器生成

      // 计算生成区域
      assign filtered_outs[(filter_index+1)*FILTER_OUT_BITS-1:filter_index*FILTER_OUT_BITS] = filtered_out[filter_index];
      // endregion 计算生成

      // 滤波器生成区域
      filter #(
          .FILTER_IN_BITS(FILTER_IN_BITS),
          .FILTER_OUT_BITS(FILTER_OUT_BITS),
          .COUNTER_BITS(COUNTER_BITS),
          .NUMBER_OF_TAPS(NUMBER_OF_TAPS),
          .COEFF_BITS(COEFF_BITS),
          .COEFF_FRAC_BITS(COEFF_FRAC_BITS)
      ) filter_inst (
          .clk(clk),
          .rst(rst),
          .clk_enable(clk_enable),
          .phase_min(phase_min),
          .amplified_filter_in(v_amplified_filter_ins[filter_index]),
          .current_count(current_count),
          .coeffs_feed(coeffs[filter_index]),
          .filtered_out(filtered_out[filter_index])
      );

      // endregion 滤波器生成
    end
  endgenerate
  // endregion 生成滤波器

  integer filter_out_index;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      filter_out <= 0;
    end else begin
  if(en)begin
      filter_out = filtered_out[0];
      for (
          filter_out_index = 1;
          filter_out_index < NUMBER_OF_FILTERS;
          filter_out_index = filter_out_index + 1
      ) begin
        filter_out = filter_out + filtered_out[filter_out_index];
      end
  end else begin
      filter_out <= filter_in;
        end
    end
  end
endmodule  // equalizer