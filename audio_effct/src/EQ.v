module eq#(
   parameter FILTER_IN_BITS = 16,
    parameter FILTER_OUT_BITS = 16,
    parameter NUMBER_OF_FILTERS = 10,
    parameter GAIN_BITS = 4,
    parameter COEFF_BITS = 16,
    parameter NUMBER_OF_TAPS = 16,
    parameter FILTER_COEFFS_TXT = "C:/Users/Asus/Desktop/eq_10_11tap.txt"
)
(
    input clk,
    input en,
    input reset_n,
    input [NUMBER_OF_FILTERS*GAIN_BITS-1:0] gain,  // 增益值
    input signed [FILTER_IN_BITS-1:0] filter_in,  // 有符号整数 16 位。范围：[-32768, 32768 - 1]
    output reg signed [FILTER_OUT_BITS-1:0] filter_out  // 有符号整数 16 位。范围：[-32768, 32768 - 1]
);

  wire signed [FILTER_OUT_BITS-1:0] filtered_out[0:NUMBER_OF_FILTERS-1];
  wire [NUMBER_OF_FILTERS*FILTER_OUT_BITS-1:0] filtered_outs;
  reg [COEFF_BITS*NUMBER_OF_TAPS-1:0] coeffs[0:NUMBER_OF_FILTERS-1];
  reg signed [FILTER_OUT_BITS-1:0] gained_out[0:NUMBER_OF_FILTERS-1];

  // 从文本文件中读取每个滤波器的系数
  initial begin
    $readmemb(FILTER_COEFFS_TXT, coeffs);
  end

  generate
    genvar filter_index;
    for (filter_index = 0; filter_index < NUMBER_OF_FILTERS; filter_index = filter_index + 1) begin : gen_filters
      // 滤波器生成区域
      band_filter #(
          .FILTER_IN_BITS(FILTER_IN_BITS),
          .FILTER_OUT_BITS(FILTER_OUT_BITS),
          .NUMBER_OF_TAPS(NUMBER_OF_TAPS),
          .COEFF_BITS(COEFF_BITS)
      ) band_filter (
          .clk(clk),
          .reset_n(reset_n),
          .clk_enable(en),
          .filter_in(filter_in),
          .filter_out(filtered_out[filter_index]),
          .eff(coeffs[filter_index])
      );
    end
  endgenerate

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      filter_out <= 0;
    end else if (en) begin
      // 计算每个滤波器的增益输出
      for (integer i = 0; i < NUMBER_OF_FILTERS; i = i + 1) begin
        gained_out[i] <= filtered_out[i] * gain[i*GAIN_BITS +: GAIN_BITS];
      end

      // 将所有增益调整后的输出相加
      filter_out <= 0;
      for (integer i = 0; i < NUMBER_OF_FILTERS; i = i + 1) begin
        filter_out <= filter_out + gained_out[i];
      end
    end else begin
      filter_out <= filter_in;
    end
  end

endmodule