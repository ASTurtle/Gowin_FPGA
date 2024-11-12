module compute #(
    parameter FILTER_IN_BITS = 16,
    parameter FILTER_OUT_BITS = 16,
    parameter NUMBER_OF_TAPS = 64,
    parameter COEFF_BITS = 16,
    parameter COEFF_FRAC_BITS = 16
) (
    input clk,
    input rst,
    input clk_enable,

    input signed [FILTER_IN_BITS-1:0] delay_filter_in,  // 来自 delay_pipeline 的输入多路复用器，即特定时间的样本。有符号整数 16 位。范围：[-32768, 32768 - 1]

    input signed [COEFF_BITS-1:0] coeff,  // 来自 coeffs_control 的乘法多路复用器，即特定槽位的系数。有符号定点数 16 位，18 位小数。范围：[-0.125, 0.125 - 3.814697265625e-06]

    input phase_min,  // 来自 phase_check 的 phase_min 信号

    output signed [FILTER_OUT_BITS-1:0] filter_out  // 输出
);
  localparam PRODUCT_BITS = FILTER_IN_BITS + COEFF_BITS;

  // 有符号定点数 32.16。范围：[-32768, 32768 - 1.52587890625e-05]
  wire signed [PRODUCT_BITS-1:0] product = delay_filter_in * coeff;

  // 有符号定点数 34.16。范围：[-131072, 131072 - 1.52587890625e-05]
  wire signed [PRODUCT_BITS-1 + 2:0] sign_extended_product = $signed(
      {{2{product[PRODUCT_BITS-1]}}, product}
  );
  reg signed [PRODUCT_BITS-1 + 2:0] acc_out;
  wire signed [PRODUCT_BITS-1 + 2:0] next_value_to_add = acc_out;

  // 有符号定点数 35.16。范围：[-262144, 262144 - 1.52587890625e-05]
  wire signed [PRODUCT_BITS-1 + 3:0] add_temp = sign_extended_product + next_value_to_add;

  // 有符号定点数 34.16。范围：[-131072, 131072 - 1.52587890625e-05]
  wire signed [PRODUCT_BITS-1 + 2:0] acc_sum = add_temp[PRODUCT_BITS-1 + 2:0];  // 去掉加法结果的溢出位

  wire signed [PRODUCT_BITS-1 + 2:0] acc_in = (phase_min == 1) ? sign_extended_product : acc_sum;

  reg signed [PRODUCT_BITS-1 + 2:0] acc_final;

  // 当 clk_enable 为高电平时，在时钟上升沿将 acc_in 推送到 acc_out
  always @(posedge clk or posedge rst) begin
    if (rst == 1) begin
      acc_out <= 0;
    end else begin
      if (clk_enable == 1) begin
        acc_out <= acc_in;
      end
    end
  end

  // 计算最终和（当 phase_min 为 1 时，表示一个新的循环开始，此时将 acc_final 更新）
  always @(posedge clk or posedge rst) begin
    if (rst == 1) begin
      acc_final <= 0;
    end else begin
      if (phase_min == 1) begin
        acc_final <= acc_out;
      end
    end
  end

  localparam ACC_FINAL_BITS = PRODUCT_BITS + 2;  // = FILTER_IN_BITS + COEFF_BITS + 2
  localparam ACC_FINAL_SIGN_BIT = ACC_FINAL_BITS - 1;  // 符号位的位置
  localparam ACC_FINAL_CHECK_BIT_HIGH = ACC_FINAL_SIGN_BIT - 1; // 检查区域高位的位置
  localparam ACC_FINAL_CHECK_BIT_LOW = COEFF_FRAC_BITS + FILTER_OUT_BITS; // 检查区域低位的位置
  localparam ACC_FINAL_CHECK_BITS = ACC_FINAL_CHECK_BIT_HIGH - ACC_FINAL_CHECK_BIT_LOW + 1; // 检查区域的位数

  localparam ACC_FINAL_CONVERTED_HIGH_BIT = COEFF_FRAC_BITS + FILTER_OUT_BITS - 1;
  localparam ACC_FINAL_CONVERTED_LOW_BIT = COEFF_FRAC_BITS;

  assign filter_out =
      // 正溢出 => 保持在最大有符号整数（饱和）
      ((acc_final[ACC_FINAL_SIGN_BIT] == 0) & (acc_final[ACC_FINAL_CHECK_BIT_HIGH:ACC_FINAL_CHECK_BIT_LOW] != {(ACC_FINAL_CHECK_BITS){1'b0}})) ? {1'b0, {(FILTER_OUT_BITS-1){1'b1}}} : // 01111...111
      // 负溢出 => 保持在最小有符号整数（饱和）
      ((acc_final[ACC_FINAL_SIGN_BIT] == 1) & (acc_final[ACC_FINAL_CHECK_BIT_HIGH:ACC_FINAL_CHECK_BIT_LOW] != {(ACC_FINAL_CHECK_BITS){1'b1}})) ? {1'b1, {(FILTER_OUT_BITS-1){1'b0}}} : // 10000...000
      // 如果没有溢出，通过截断多余位进行向下取整
      acc_final[ACC_FINAL_CONVERTED_HIGH_BIT:ACC_FINAL_CONVERTED_LOW_BIT];
endmodule  // compute