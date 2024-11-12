module remote_filter#(
    parameter DATA_WIDTH = 32,// 数据位宽
    parameter NUMBER_OF_TAPS=7,
     parameter FILTER_IN_BITS = 16,
    parameter FILTER_OUT_BITS = 16,
    parameter COUNTER_MIN = 6'b000000,
    parameter COUNTER_MAX = 6'b111111,
    parameter COEFF_FRAC_BITS = 16,////滤波器的小数位数
    parameter COEFF_BITS = 16,//滤波器系数
    parameter COUNTER_BITS = $clog2(COUNTER_MAX)
)(
    input clk,
    input reset_n,
    input wire[DATA_WIDTH-1:0] filter_in,
    input wire[(COEFF_BITS*NUMBER_OF_TAPS)-1:0]eff,
    input en,
    output reg[DATA_WIDTH-1:0] filter_out
);
//reg [(eff_width*taps_num)-1:0]eff_fir;
wire [31:0]filter_out_0;

counter #(
      .COUNTER_MIN(COUNTER_MIN),
      .COUNTER_MAX(COUNTER_MAX)
  ) counter (
      .clk(clk),
      .clk_enable(en),
      .rst(!reset_n),
      .current_count(current_count),
      .phase_min(phase_min)
  );
filter #(
          .FILTER_IN_BITS(FILTER_IN_BITS),
          .FILTER_OUT_BITS(FILTER_OUT_BITS),
          .COUNTER_BITS(COUNTER_BITS),
          .NUMBER_OF_TAPS(NUMBER_OF_TAPS),
          .COEFF_BITS(COEFF_BITS),
          .COEFF_FRAC_BITS(COEFF_FRAC_BITS)
      ) filter_0 (
          .clk(clk),
          .rst(!reset_n),
          .clk_enable(en),
          .phase_min(phase_min),
          .amplified_filter_in(filter_in[15:0]),
          .current_count(current_count),
          .coeffs_feed(eff),
          .filtered_out(filter_out_0[15:0])
      );
filter #(
          .FILTER_IN_BITS(FILTER_IN_BITS),
          .FILTER_OUT_BITS(FILTER_OUT_BITS),
          .COUNTER_BITS(COUNTER_BITS),
          .NUMBER_OF_TAPS(NUMBER_OF_TAPS),
          .COEFF_BITS(COEFF_BITS),
          .COEFF_FRAC_BITS(COEFF_FRAC_BITS)
      ) filter_1 (
          .clk(clk),
          .rst(!reset_n),
          .clk_enable(en),
          .phase_min(phase_min),
          .amplified_filter_in(filter_in[31:16]),
          .current_count(current_count),
          .coeffs_feed(eff),
          .filtered_out(filter_out_0[31:16])
      );
always@(posedge clk or negedge reset_n)
	if(!reset_n)
		filter_out <= 32'd0;
	else if(en)begin
        filter_out <= filter_out_0;
    end else begin
        filter_out <= filter_in;
 end
endmodule