`timescale 1 ns / 1 ns

module filter_0
               (
                fclk,
                reset,
                filter_in,
                filter_out
                );

  input   fclk; 
  input   reset; 
  input   unsigned [31:0] filter_in; //sfix32
  output  unsigned [31:0] filter_out; //sfix32

////////////////////////////////////////////////////////////////
//Module Architecture: filter
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter unsigned [31:0] coeff1 = 32'h0560B3C3; //sfix32_En31
  parameter unsigned [31:0] coeff2 = 32'hE8AE5E05; //sfix32_En31
  parameter unsigned [31:0] coeff3 = 32'hF7E3ED6A; //sfix32_En31
  parameter unsigned [31:0] coeff4 = 32'h27EDC865; //sfix32_En31
  parameter unsigned [31:0] coeff5 = 32'h4576BDA5; //sfix32_En31
  parameter unsigned [31:0] coeff6 = 32'h27EDC865; //sfix32_En31
  parameter unsigned [31:0] coeff7 = 32'hF7E3ED6A; //sfix32_En31
  parameter unsigned [31:0] coeff8 = 32'hE8AE5E05; //sfix32_En31
  parameter unsigned [31:0] coeff9 = 32'h0560B3C3; //sfix32_En31

  // Signals
  reg  unsigned [31:0] delay_pipeline [0:8] ; // sfix32
  wire unsigned [30:0] product9; // sfix31_En30
  wire unsigned [63:0] mul_temp; // sfix64_En31
  wire unsigned [30:0] product8; // sfix31_En30
  wire unsigned [63:0] mul_temp_1; // sfix64_En31
  wire unsigned [30:0] product7; // sfix31_En30
  wire unsigned [63:0] mul_temp_2; // sfix64_En31
  wire unsigned [30:0] product6; // sfix31_En30
  wire unsigned [63:0] mul_temp_3; // sfix64_En31
  wire unsigned [30:0] product5; // sfix31_En30
  wire unsigned [63:0] mul_temp_4; // sfix64_En31
  wire unsigned [30:0] product4; // sfix31_En30
  wire unsigned [63:0] mul_temp_5; // sfix64_En31
  wire unsigned [30:0] product3; // sfix31_En30
  wire unsigned [63:0] mul_temp_6; // sfix64_En31
  wire unsigned [30:0] product2; // sfix31_En30
  wire unsigned [63:0] mul_temp_7; // sfix64_En31
  wire unsigned [31:0] product1_cast; // sfix32_En30
  wire unsigned [30:0] product1; // sfix31_En30
  wire unsigned [63:0] mul_temp_8; // sfix64_En31
  wire unsigned [31:0] sum1; // sfix32_En30
  wire unsigned [31:0] add_signext; // sfix32_En30
  wire unsigned [31:0] add_signext_1; // sfix32_En30
  wire unsigned [32:0] add_temp; // sfix33_En30
  wire unsigned [31:0] sum2; // sfix32_En30
  wire unsigned [31:0] add_signext_2; // sfix32_En30
  wire unsigned [31:0] add_signext_3; // sfix32_En30
  wire unsigned [32:0] add_temp_1; // sfix33_En30
  wire unsigned [31:0] sum3; // sfix32_En30
  wire unsigned [31:0] add_signext_4; // sfix32_En30
  wire unsigned [31:0] add_signext_5; // sfix32_En30
  wire unsigned [32:0] add_temp_2; // sfix33_En30
  wire unsigned [31:0] sum4; // sfix32_En30
  wire unsigned [31:0] add_signext_6; // sfix32_En30
  wire unsigned [31:0] add_signext_7; // sfix32_En30
  wire unsigned [32:0] add_temp_3; // sfix33_En30
  wire unsigned [31:0] sum5; // sfix32_En30
  wire unsigned [31:0] add_signext_8; // sfix32_En30
  wire unsigned [31:0] add_signext_9; // sfix32_En30
  wire unsigned [32:0] add_temp_4; // sfix33_En30
  wire unsigned [31:0] sum6; // sfix32_En30
  wire unsigned [31:0] add_signext_10; // sfix32_En30
  wire unsigned [31:0] add_signext_11; // sfix32_En30
  wire unsigned [32:0] add_temp_5; // sfix33_En30
  wire unsigned [31:0] sum7; // sfix32_En30
  wire unsigned [31:0] add_signext_12; // sfix32_En30
  wire unsigned [31:0] add_signext_13; // sfix32_En30
  wire unsigned [32:0] add_temp_6; // sfix33_En30
  wire unsigned [31:0] sum8; // sfix32_En30
  wire unsigned [31:0] add_signext_14; // sfix32_En30
  wire unsigned [31:0] add_signext_15; // sfix32_En30
  wire unsigned [32:0] add_temp_7; // sfix33_En30
  wire unsigned [31:0] output_typeconvert; // sfix32
  reg  unsigned [31:0] output_register; // sfix32

  // Block Statements
  always @( posedge fclk or posedge reset)
    begin: Delay_Pipeline_process
      if (reset == 1'b1) begin
        delay_pipeline[0] <= 0;
        delay_pipeline[1] <= 0;
        delay_pipeline[2] <= 0;
        delay_pipeline[3] <= 0;
        delay_pipeline[4] <= 0;
        delay_pipeline[5] <= 0;
        delay_pipeline[6] <= 0;
        delay_pipeline[7] <= 0;
        delay_pipeline[8] <= 0;
      end
      else begin
          delay_pipeline[0] <= filter_in;
          delay_pipeline[1] <= delay_pipeline[0];
          delay_pipeline[2] <= delay_pipeline[1];
          delay_pipeline[3] <= delay_pipeline[2];
          delay_pipeline[4] <= delay_pipeline[3];
          delay_pipeline[5] <= delay_pipeline[4];
          delay_pipeline[6] <= delay_pipeline[5];
          delay_pipeline[7] <= delay_pipeline[6];
          delay_pipeline[8] <= delay_pipeline[7];
      end
    end // Delay_Pipeline_process


  assign mul_temp = delay_pipeline[8] * coeff9;
  assign product9 = (mul_temp[31:0] + mul_temp[1])>>>1;

  assign mul_temp_1 = delay_pipeline[7] * coeff8;
  assign product8 = (mul_temp_1[31:0] + mul_temp_1[1])>>>1;

  assign mul_temp_2 = delay_pipeline[6] * coeff7;
  assign product7 = (mul_temp_2[31:0] + mul_temp_2[1])>>>1;

  assign mul_temp_3 = delay_pipeline[5] * coeff6;
  assign product6 = (mul_temp_3[31:0] + mul_temp_3[1])>>>1;

  assign mul_temp_4 = delay_pipeline[4] * coeff5;
  assign product5 = (mul_temp_4[31:0] + mul_temp_4[1])>>>1;

  assign mul_temp_5 = delay_pipeline[3] * coeff4;
  assign product4 = (mul_temp_5[31:0] + mul_temp_5[1])>>>1;

  assign mul_temp_6 = delay_pipeline[2] * coeff3;
  assign product3 = (mul_temp_6[31:0] + mul_temp_6[1])>>>1;

  assign mul_temp_7 = delay_pipeline[1] * coeff2;
  assign product2 = (mul_temp_7[31:0] + mul_temp_7[1])>>>1;

  assign product1_cast = $unsigned({{1{product1[30]}}, product1});

  assign mul_temp_8 = delay_pipeline[0] * coeff1;
  assign product1 = (mul_temp_8[31:0] + mul_temp_8[1])>>>1;

  assign add_signext = product1_cast;
  assign add_signext_1 = $unsigned({{1{product2[30]}}, product2});
  assign add_temp = add_signext + add_signext_1;
  assign sum1 = add_temp[31:0];

  assign add_signext_2 = sum1;
  assign add_signext_3 = $unsigned({{1{product3[30]}}, product3});
  assign add_temp_1 = add_signext_2 + add_signext_3;
  assign sum2 = add_temp_1[31:0];

  assign add_signext_4 = sum2;
  assign add_signext_5 = $unsigned({{1{product4[30]}}, product4});
  assign add_temp_2 = add_signext_4 + add_signext_5;
  assign sum3 = add_temp_2[31:0];

  assign add_signext_6 = sum3;
  assign add_signext_7 = $unsigned({{1{product5[30]}}, product5});
  assign add_temp_3 = add_signext_6 + add_signext_7;
  assign sum4 = add_temp_3[31:0];

  assign add_signext_8 = sum4;
  assign add_signext_9 = $unsigned({{1{product6[30]}}, product6});
  assign add_temp_4 = add_signext_8 + add_signext_9;
  assign sum5 = add_temp_4[31:0];

  assign add_signext_10 = sum5;
  assign add_signext_11 = $unsigned({{1{product7[30]}}, product7});
  assign add_temp_5 = add_signext_10 + add_signext_11;
  assign sum6 = add_temp_5[31:0];

  assign add_signext_12 = sum6;
  assign add_signext_13 = $unsigned({{1{product8[30]}}, product8});
  assign add_temp_6 = add_signext_12 + add_signext_13;
  assign sum7 = add_temp_6[31:0];

  assign add_signext_14 = sum7;
  assign add_signext_15 = $unsigned({{1{product9[30]}}, product9});
  assign add_temp_7 = add_signext_14 + add_signext_15;
  assign sum8 = add_temp_7[31:0];

  assign output_typeconvert = ({{30{sum8[31]}}, sum8[31:0]} + {sum8[30], {29{~sum8[30]}}})>>>30;

  always @ (posedge fclk or posedge reset)
    begin: Output_Register_process
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
          output_register <= output_typeconvert;
      end
    end // Output_Register_process

  // Assignment Statements
  assign filter_out = output_register;
endmodule  // filter