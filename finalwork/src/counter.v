module counter #(
    parameter COUNTER_MIN = 6'b000000,
    parameter COUNTER_MAX = 6'b111111
) (
    input clk,
    input clk_enable,
    input rst,

    output reg [$clog2(COUNTER_MAX)-1:0] current_count,  // 无符号整数 6 位。范围：[0, 64 - 1]
    output                               phase_min       // 布尔值
);

  always @(posedge clk or posedge rst) begin
    if (rst == 1) begin
      // 重置到最小计数值
      current_count <= COUNTER_MIN;
    end else begin
      if (clk_enable == 1) begin
        if (current_count >= COUNTER_MAX) begin
          // 溢出回到最小值
          current_count <= COUNTER_MIN;
        end else begin
          current_count <= current_count + 1;
        end
      end
    end
  end

  assign phase_min = ((current_count == COUNTER_MIN) && (clk_enable == 1)) ? 1 : 0;

endmodule