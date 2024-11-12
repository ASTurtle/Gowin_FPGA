/////////////////////
//资源占用更多但噪声更小/
/////////////////////
module rm_filter (
    input clk,
    input clk_enable,
    input reset,
    input [111:0] eff,
    input en,
    input signed [15:0] filter_in,
    output signed [15:0] filter_out
);

  // Coefficients
  wire signed [15:0] coeff1 = eff[111:96];
  wire signed [15:0] coeff2 = eff[95:80];
  wire signed [15:0] coeff3 = eff[79:64];
  wire signed [15:0] coeff4 = eff[63:48];
  wire signed [15:0] coeff5 = eff[47:32];
  wire signed [15:0] coeff6 = eff[31:16];
  wire signed [15:0] coeff7 = eff[15:0];

  // Delay pipeline
  reg signed [15:0] delay_pipeline [0:6];
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      for (integer i = 0; i < 7; i = i + 1) begin
        delay_pipeline[i] <= 0;
      end
    end else if (clk_enable) begin
      delay_pipeline[0] <= filter_in;
      for (integer i = 1; i < 7; i = i + 1) begin
        delay_pipeline[i] <= delay_pipeline[i-1];
      end
    end
  end

  // Multiplications
  wire signed [31:0] product1 = delay_pipeline[0] * coeff1;
  wire signed [31:0] product2 = delay_pipeline[1] * coeff2;
  wire signed [31:0] product3 = delay_pipeline[2] * coeff3;
  wire signed [31:0] product4 = delay_pipeline[3] * coeff4;
  wire signed [31:0] product5 = delay_pipeline[4] * coeff5;
  wire signed [31:0] product6 = delay_pipeline[5] * coeff6;
  wire signed [31:0] product7 = delay_pipeline[6] * coeff7;

  // Summation
  wire signed [32:0] sum1 = product1 + product2;
  wire signed [32:0] sum2 = product3 + product4;
  wire signed [32:0] sum3 = product5 + product6;
  wire signed [32:0] sum4 = sum1 + sum2;
  wire signed [32:0] sum5 = sum4 + sum3;
  wire signed [32:0] sum6 = sum5 + product7;

  // Output register
  reg signed [15:0] output_register;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      output_register <= 0;
    end else if (en) begin
      output_register <= sum6[31:16];
    end else begin
      output_register <= filter_in;
    end
  end

  // Output assignment
  assign filter_out = output_register;

endmodule