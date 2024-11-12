`timescale 1 ns / 1 ns

module filter_lowpass
               (
                clk,
                clk_enable,
                reset_n,
                filter_in,
                filter_out
                );

  input   clk; 
  input   clk_enable; 
  input   reset_n; 
  input   signed [15:0] filter_in; //sfix16_En15
  output  signed [15:0] filter_out; //sfix16_En15

////////////////////////////////////////////////////////////////
//Module Architecture: filterlowp
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [15:0] coeff1 = 16'b1111101110001000; //sfix16_En15
  parameter signed [15:0] coeff2 = 16'b0011011100010001; //sfix16_En15
  parameter signed [15:0] coeff3 = 16'b0100100011101111; //sfix16_En15
  parameter signed [15:0] coeff4 = 16'b0011011100010001; //sfix16_En15
  parameter signed [15:0] coeff5 = 16'b1111101110001000; //sfix16_En15

  // Signals
  reg  signed [15:0] delay_pipeline [0:4] ; // sfix16_En15
  wire signed [30:0] product5; // sfix31_En30
  wire signed [31:0] mul_temp; // sfix32_En30
  wire signed [30:0] product4; // sfix31_En30
  wire signed [31:0] mul_temp_1; // sfix32_En30
  wire signed [30:0] product3; // sfix31_En30
  wire signed [31:0] mul_temp_2; // sfix32_En30
  wire signed [30:0] product2; // sfix31_En30
  wire signed [31:0] mul_temp_3; // sfix32_En30
  wire signed [31:0] product1_cast; // sfix32_En30
  wire signed [30:0] product1; // sfix31_En30
  wire signed [31:0] mul_temp_4; // sfix32_En30
  wire signed [31:0] sum1; // sfix32_En30
  wire signed [31:0] add_signext; // sfix32_En30
  wire signed [31:0] add_signext_1; // sfix32_En30
  wire signed [32:0] add_temp; // sfix33_En30
  wire signed [31:0] sum2; // sfix32_En30
  wire signed [31:0] add_signext_2; // sfix32_En30
  wire signed [31:0] add_signext_3; // sfix32_En30
  wire signed [32:0] add_temp_1; // sfix33_En30
  wire signed [31:0] sum3; // sfix32_En30
  wire signed [31:0] add_signext_4; // sfix32_En30
  wire signed [31:0] add_signext_5; // sfix32_En30
  wire signed [32:0] add_temp_2; // sfix33_En30
  wire signed [31:0] sum4; // sfix32_En30
  wire signed [31:0] add_signext_6; // sfix32_En30
  wire signed [31:0] add_signext_7; // sfix32_En30
  wire signed [32:0] add_temp_3; // sfix33_En30
  wire signed [15:0] output_typeconvert; // sfix16_En15
  reg  signed [15:0] output_register; // sfix16_En15

  // Block Statements
  always @( posedge clk or negedge reset_n)
    begin: Delay_Pipeline_process
      if (reset_n == 1'b0) begin
        delay_pipeline[0] <= 0;
        delay_pipeline[1] <= 0;
        delay_pipeline[2] <= 0;
        delay_pipeline[3] <= 0;
        delay_pipeline[4] <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          delay_pipeline[0] <= filter_in;
          delay_pipeline[1] <= delay_pipeline[0];
          delay_pipeline[2] <= delay_pipeline[1];
          delay_pipeline[3] <= delay_pipeline[2];
          delay_pipeline[4] <= delay_pipeline[3];
        end
      end
    end // Delay_Pipeline_process


  assign mul_temp = delay_pipeline[4] * coeff5;
  assign product5 = mul_temp[30:0];

  assign mul_temp_1 = delay_pipeline[3] * coeff4;
  assign product4 = mul_temp_1[30:0];

  assign mul_temp_2 = delay_pipeline[2] * coeff3;
  assign product3 = mul_temp_2[30:0];

  assign mul_temp_3 = delay_pipeline[1] * coeff2;
  assign product2 = mul_temp_3[30:0];

  assign product1_cast = $signed({{1{product1[30]}}, product1});

  assign mul_temp_4 = delay_pipeline[0] * coeff1;
  assign product1 = mul_temp_4[30:0];

  assign add_signext = product1_cast;
  assign add_signext_1 = $signed({{1{product2[30]}}, product2});
  assign add_temp = add_signext + add_signext_1;
  assign sum1 = add_temp[31:0];

  assign add_signext_2 = sum1;
  assign add_signext_3 = $signed({{1{product3[30]}}, product3});
  assign add_temp_1 = add_signext_2 + add_signext_3;
  assign sum2 = add_temp_1[31:0];

  assign add_signext_4 = sum2;
  assign add_signext_5 = $signed({{1{product4[30]}}, product4});
  assign add_temp_2 = add_signext_4 + add_signext_5;
  assign sum3 = add_temp_2[31:0];

  assign add_signext_6 = sum3;
  assign add_signext_7 = $signed({{1{product5[30]}}, product5});
  assign add_temp_3 = add_signext_6 + add_signext_7;
  assign sum4 = add_temp_3[31:0];

  assign output_typeconvert = (sum4[30:0] + {sum4[15], {14{~sum4[15]}}})>>>15;

  always @ (posedge clk or negedge reset_n)
    begin: Output_Register_process
      if (reset_n == 1'b0) begin
        output_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          output_register <= output_typeconvert;
        end
      end
    end // Output_Register_process

  // Assignment Statements
  assign filter_out = output_register;
endmodule  // filterlowp
