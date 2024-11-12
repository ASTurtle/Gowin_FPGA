module band_filter#(
    parameter FILTER_IN_BITS = 16,
    parameter FILTER_OUT_BITS = 16,
    parameter GAIN_BITS = 4,
    parameter COEFF_BITS = 16,
    parameter NUMBER_OF_TAPS = 16
)(
    input clk,
    input reset_n,
    input   clk_enable, 
    input signed [15:0] filter_in,
    input [NUMBER_OF_TAPS* COEFF_BITS-1:0]eff,
    output signed [15:0] filter_out
);
  wire signed [15:0] coeff1 = eff[255:240];  //sfix16_En15
  wire signed [15:0] coeff2 = eff[239:224];   //sfix16_En15
  wire signed [15:0] coeff3 = eff[223:208];   //sfix16_En15
  wire signed [15:0] coeff4 = eff[207:192];   //sfix16_En15
  wire signed [15:0] coeff5 = eff[191:176];   //sfix16_En15
  wire signed [15:0] coeff6 = eff[175:160];   //sfix16_En15
  wire signed [15:0] coeff7 = eff[159:144];    //sfix16_En15
  wire signed [15:0] coeff8 = eff[143:128];   //sfix16_En15
  wire signed [15:0] coeff9 = eff[127:112];    //sfix16_En15
  wire signed [15:0] coeff10 = eff[111:96]; //sfix16_En15
  wire signed [15:0] coeff11= eff[95:80]; //sfix16_En15
  wire signed [15:0] coeff12= eff[79:64]; //sfix16_En15
  wire signed [15:0] coeff13= eff[63:48]; //sfix16_En15
  wire signed [15:0] coeff14 = eff[47:32]; //sfix16_En15
  wire signed [15:0] coeff15 = eff[31:16]; //sfix16_En15
  wire signed [15:0] coeff16 = eff[15:0]; //sfix16_En15

// Signals
  reg  signed [15:0] delay_pipeline [0:15] ; // sfix16_En15
  wire signed [30:0] product16; // sfix31_En31
  wire signed [31:0] mul_temp; // sfix32_En33
  wire signed [30:0] product15; // sfix31_En31
  wire signed [31:0] mul_temp_1; // sfix32_En33
  wire signed [30:0] product14; // sfix31_En31
  wire signed [31:0] mul_temp_2; // sfix32_En33
  wire signed [30:0] product13; // sfix31_En31
  wire signed [31:0] mul_temp_3; // sfix32_En33
  wire signed [30:0] product12; // sfix31_En31
  wire signed [31:0] mul_temp_4; // sfix32_En33
  wire signed [30:0] product11; // sfix31_En31
  wire signed [31:0] mul_temp_5; // sfix32_En33
  wire signed [30:0] product10; // sfix31_En31
  wire signed [31:0] mul_temp_6; // sfix32_En33
  wire signed [30:0] product9; // sfix31_En31
  wire signed [31:0] mul_temp_7; // sfix32_En33
  wire signed [30:0] product8; // sfix31_En31
  wire signed [31:0] mul_temp_8; // sfix32_En33
  wire signed [30:0] product7; // sfix31_En31
  wire signed [31:0] mul_temp_9; // sfix32_En33
  wire signed [30:0] product6; // sfix31_En31
  wire signed [31:0] mul_temp_10; // sfix32_En33
  wire signed [30:0] product5; // sfix31_En31
  wire signed [31:0] mul_temp_11; // sfix32_En33
  wire signed [30:0] product4; // sfix31_En31
  wire signed [31:0] mul_temp_12; // sfix32_En33
  wire signed [30:0] product3; // sfix31_En31
  wire signed [31:0] mul_temp_13; // sfix32_En33
  wire signed [30:0] product2; // sfix31_En31
  wire signed [31:0] mul_temp_14; // sfix32_En33
  wire signed [33:0] product1_cast; // sfix34_En31
  wire signed [30:0] product1; // sfix31_En31
  wire signed [31:0] mul_temp_15; // sfix32_En33
  wire signed [33:0] sum1; // sfix34_En31
  wire signed [33:0] add_signext; // sfix34_En31
  wire signed [33:0] add_signext_1; // sfix34_En31
  wire signed [34:0] add_temp; // sfix35_En31
  wire signed [33:0] sum2; // sfix34_En31
  wire signed [33:0] add_signext_2; // sfix34_En31
  wire signed [33:0] add_signext_3; // sfix34_En31
  wire signed [34:0] add_temp_1; // sfix35_En31
  wire signed [33:0] sum3; // sfix34_En31
  wire signed [33:0] add_signext_4; // sfix34_En31
  wire signed [33:0] add_signext_5; // sfix34_En31
  wire signed [34:0] add_temp_2; // sfix35_En31
  wire signed [33:0] sum4; // sfix34_En31
  wire signed [33:0] add_signext_6; // sfix34_En31
  wire signed [33:0] add_signext_7; // sfix34_En31
  wire signed [34:0] add_temp_3; // sfix35_En31
  wire signed [33:0] sum5; // sfix34_En31
  wire signed [33:0] add_signext_8; // sfix34_En31
  wire signed [33:0] add_signext_9; // sfix34_En31
  wire signed [34:0] add_temp_4; // sfix35_En31
  wire signed [33:0] sum6; // sfix34_En31
  wire signed [33:0] add_signext_10; // sfix34_En31
  wire signed [33:0] add_signext_11; // sfix34_En31
  wire signed [34:0] add_temp_5; // sfix35_En31
  wire signed [33:0] sum7; // sfix34_En31
  wire signed [33:0] add_signext_12; // sfix34_En31
  wire signed [33:0] add_signext_13; // sfix34_En31
  wire signed [34:0] add_temp_6; // sfix35_En31
  wire signed [33:0] sum8; // sfix34_En31
  wire signed [33:0] add_signext_14; // sfix34_En31
  wire signed [33:0] add_signext_15; // sfix34_En31
  wire signed [34:0] add_temp_7; // sfix35_En31
  wire signed [33:0] sum9; // sfix34_En31
  wire signed [33:0] add_signext_16; // sfix34_En31
  wire signed [33:0] add_signext_17; // sfix34_En31
  wire signed [34:0] add_temp_8; // sfix35_En31
  wire signed [33:0] sum10; // sfix34_En31
  wire signed [33:0] add_signext_18; // sfix34_En31
  wire signed [33:0] add_signext_19; // sfix34_En31
  wire signed [34:0] add_temp_9; // sfix35_En31
  wire signed [33:0] sum11; // sfix34_En31
  wire signed [33:0] add_signext_20; // sfix34_En31
  wire signed [33:0] add_signext_21; // sfix34_En31
  wire signed [34:0] add_temp_10; // sfix35_En31
  wire signed [33:0] sum12; // sfix34_En31
  wire signed [33:0] add_signext_22; // sfix34_En31
  wire signed [33:0] add_signext_23; // sfix34_En31
  wire signed [34:0] add_temp_11; // sfix35_En31
  wire signed [33:0] sum13; // sfix34_En31
  wire signed [33:0] add_signext_24; // sfix34_En31
  wire signed [33:0] add_signext_25; // sfix34_En31
  wire signed [34:0] add_temp_12; // sfix35_En31
  wire signed [33:0] sum14; // sfix34_En31
  wire signed [33:0] add_signext_26; // sfix34_En31
  wire signed [33:0] add_signext_27; // sfix34_En31
  wire signed [34:0] add_temp_13; // sfix35_En31
  wire signed [33:0] sum15; // sfix34_En31
  wire signed [33:0] add_signext_28; // sfix34_En31
  wire signed [33:0] add_signext_29; // sfix34_En31
  wire signed [34:0] add_temp_14; // sfix35_En31
  wire signed [15:0] output_typeconvert; // sfix16_En15
  reg  signed [15:0] output_register; // sfix16_En15

 // Signals
  reg  signed [15:0] delay_pipeline [0:15] ; // sfix16_En15
  wire signed [30:0] product16; // sfix31_En31
  wire signed [31:0] mul_temp; // sfix32_En33
  wire signed [30:0] product15; // sfix31_En31
  wire signed [31:0] mul_temp_1; // sfix32_En33
  wire signed [30:0] product14; // sfix31_En31
  wire signed [31:0] mul_temp_2; // sfix32_En33
  wire signed [30:0] product13; // sfix31_En31
  wire signed [31:0] mul_temp_3; // sfix32_En33
  wire signed [30:0] product12; // sfix31_En31
  wire signed [31:0] mul_temp_4; // sfix32_En33
  wire signed [30:0] product11; // sfix31_En31
  wire signed [31:0] mul_temp_5; // sfix32_En33
  wire signed [30:0] product10; // sfix31_En31
  wire signed [31:0] mul_temp_6; // sfix32_En33
  wire signed [30:0] product9; // sfix31_En31
  wire signed [31:0] mul_temp_7; // sfix32_En33
  wire signed [30:0] product8; // sfix31_En31
  wire signed [31:0] mul_temp_8; // sfix32_En33
  wire signed [30:0] product7; // sfix31_En31
  wire signed [31:0] mul_temp_9; // sfix32_En33
  wire signed [30:0] product6; // sfix31_En31
  wire signed [31:0] mul_temp_10; // sfix32_En33
  wire signed [30:0] product5; // sfix31_En31
  wire signed [31:0] mul_temp_11; // sfix32_En33
  wire signed [30:0] product4; // sfix31_En31
  wire signed [31:0] mul_temp_12; // sfix32_En33
  wire signed [30:0] product3; // sfix31_En31
  wire signed [31:0] mul_temp_13; // sfix32_En33
  wire signed [30:0] product2; // sfix31_En31
  wire signed [31:0] mul_temp_14; // sfix32_En33
  wire signed [33:0] product1_cast; // sfix34_En31
  wire signed [30:0] product1; // sfix31_En31
  wire signed [31:0] mul_temp_15; // sfix32_En33
  wire signed [33:0] sum1; // sfix34_En31
  wire signed [33:0] add_signext; // sfix34_En31
  wire signed [33:0] add_signext_1; // sfix34_En31
  wire signed [34:0] add_temp; // sfix35_En31
  wire signed [33:0] sum2; // sfix34_En31
  wire signed [33:0] add_signext_2; // sfix34_En31
  wire signed [33:0] add_signext_3; // sfix34_En31
  wire signed [34:0] add_temp_1; // sfix35_En31
  wire signed [33:0] sum3; // sfix34_En31
  wire signed [33:0] add_signext_4; // sfix34_En31
  wire signed [33:0] add_signext_5; // sfix34_En31
  wire signed [34:0] add_temp_2; // sfix35_En31
  wire signed [33:0] sum4; // sfix34_En31
  wire signed [33:0] add_signext_6; // sfix34_En31
  wire signed [33:0] add_signext_7; // sfix34_En31
  wire signed [34:0] add_temp_3; // sfix35_En31
  wire signed [33:0] sum5; // sfix34_En31
  wire signed [33:0] add_signext_8; // sfix34_En31
  wire signed [33:0] add_signext_9; // sfix34_En31
  wire signed [34:0] add_temp_4; // sfix35_En31
  wire signed [33:0] sum6; // sfix34_En31
  wire signed [33:0] add_signext_10; // sfix34_En31
  wire signed [33:0] add_signext_11; // sfix34_En31
  wire signed [34:0] add_temp_5; // sfix35_En31
  wire signed [33:0] sum7; // sfix34_En31
  wire signed [33:0] add_signext_12; // sfix34_En31
  wire signed [33:0] add_signext_13; // sfix34_En31
  wire signed [34:0] add_temp_6; // sfix35_En31
  wire signed [33:0] sum8; // sfix34_En31
  wire signed [33:0] add_signext_14; // sfix34_En31
  wire signed [33:0] add_signext_15; // sfix34_En31
  wire signed [34:0] add_temp_7; // sfix35_En31
  wire signed [33:0] sum9; // sfix34_En31
  wire signed [33:0] add_signext_16; // sfix34_En31
  wire signed [33:0] add_signext_17; // sfix34_En31
  wire signed [34:0] add_temp_8; // sfix35_En31
  wire signed [33:0] sum10; // sfix34_En31
  wire signed [33:0] add_signext_18; // sfix34_En31
  wire signed [33:0] add_signext_19; // sfix34_En31
  wire signed [34:0] add_temp_9; // sfix35_En31
  wire signed [33:0] sum11; // sfix34_En31
  wire signed [33:0] add_signext_20; // sfix34_En31
  wire signed [33:0] add_signext_21; // sfix34_En31
  wire signed [34:0] add_temp_10; // sfix35_En31
  wire signed [33:0] sum12; // sfix34_En31
  wire signed [33:0] add_signext_22; // sfix34_En31
  wire signed [33:0] add_signext_23; // sfix34_En31
  wire signed [34:0] add_temp_11; // sfix35_En31
  wire signed [33:0] sum13; // sfix34_En31
  wire signed [33:0] add_signext_24; // sfix34_En31
  wire signed [33:0] add_signext_25; // sfix34_En31
  wire signed [34:0] add_temp_12; // sfix35_En31
  wire signed [33:0] sum14; // sfix34_En31
  wire signed [33:0] add_signext_26; // sfix34_En31
  wire signed [33:0] add_signext_27; // sfix34_En31
  wire signed [34:0] add_temp_13; // sfix35_En31
  wire signed [33:0] sum15; // sfix34_En31
  wire signed [33:0] add_signext_28; // sfix34_En31
  wire signed [33:0] add_signext_29; // sfix34_En31
  wire signed [34:0] add_temp_14; // sfix35_En31
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
        delay_pipeline[5] <= 0;
        delay_pipeline[6] <= 0;
        delay_pipeline[7] <= 0;
        delay_pipeline[8] <= 0;
        delay_pipeline[9] <= 0;
        delay_pipeline[10] <= 0;
        delay_pipeline[11] <= 0;
        delay_pipeline[12] <= 0;
        delay_pipeline[13] <= 0;
        delay_pipeline[14] <= 0;
        delay_pipeline[15] <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          delay_pipeline[0] <= filter_in;
          delay_pipeline[1] <= delay_pipeline[0];
          delay_pipeline[2] <= delay_pipeline[1];
          delay_pipeline[3] <= delay_pipeline[2];
          delay_pipeline[4] <= delay_pipeline[3];
          delay_pipeline[5] <= delay_pipeline[4];
          delay_pipeline[6] <= delay_pipeline[5];
          delay_pipeline[7] <= delay_pipeline[6];
          delay_pipeline[8] <= delay_pipeline[7];
          delay_pipeline[9] <= delay_pipeline[8];
          delay_pipeline[10] <= delay_pipeline[9];
          delay_pipeline[11] <= delay_pipeline[10];
          delay_pipeline[12] <= delay_pipeline[11];
          delay_pipeline[13] <= delay_pipeline[12];
          delay_pipeline[14] <= delay_pipeline[13];
          delay_pipeline[15] <= delay_pipeline[14];
        end
      end
    end // Delay_Pipeline_process


  assign mul_temp = delay_pipeline[15] * coeff16;
  assign product16 = ({{1{mul_temp[31]}}, mul_temp[31:0]} + {mul_temp[2], {1{~mul_temp[2]}}})>>>2;

  assign mul_temp_1 = delay_pipeline[14] * coeff15;
  assign product15 = ({{1{mul_temp_1[31]}}, mul_temp_1[31:0]} + {mul_temp_1[2], {1{~mul_temp_1[2]}}})>>>2;

  assign mul_temp_2 = delay_pipeline[13] * coeff14;
  assign product14 = ({{1{mul_temp_2[31]}}, mul_temp_2[31:0]} + {mul_temp_2[2], {1{~mul_temp_2[2]}}})>>>2;

  assign mul_temp_3 = delay_pipeline[12] * coeff13;
  assign product13 = ({{1{mul_temp_3[31]}}, mul_temp_3[31:0]} + {mul_temp_3[2], {1{~mul_temp_3[2]}}})>>>2;

  assign mul_temp_4 = delay_pipeline[11] * coeff12;
  assign product12 = ({{1{mul_temp_4[31]}}, mul_temp_4[31:0]} + {mul_temp_4[2], {1{~mul_temp_4[2]}}})>>>2;

  assign mul_temp_5 = delay_pipeline[10] * coeff11;
  assign product11 = ({{1{mul_temp_5[31]}}, mul_temp_5[31:0]} + {mul_temp_5[2], {1{~mul_temp_5[2]}}})>>>2;

  assign mul_temp_6 = delay_pipeline[9] * coeff10;
  assign product10 = ({{1{mul_temp_6[31]}}, mul_temp_6[31:0]} + {mul_temp_6[2], {1{~mul_temp_6[2]}}})>>>2;

  assign mul_temp_7 = delay_pipeline[8] * coeff9;
  assign product9 = ({{1{mul_temp_7[31]}}, mul_temp_7[31:0]} + {mul_temp_7[2], {1{~mul_temp_7[2]}}})>>>2;

  assign mul_temp_8 = delay_pipeline[7] * coeff8;
  assign product8 = ({{1{mul_temp_8[31]}}, mul_temp_8[31:0]} + {mul_temp_8[2], {1{~mul_temp_8[2]}}})>>>2;

  assign mul_temp_9 = delay_pipeline[6] * coeff7;
  assign product7 = ({{1{mul_temp_9[31]}}, mul_temp_9[31:0]} + {mul_temp_9[2], {1{~mul_temp_9[2]}}})>>>2;

  assign mul_temp_10 = delay_pipeline[5] * coeff6;
  assign product6 = ({{1{mul_temp_10[31]}}, mul_temp_10[31:0]} + {mul_temp_10[2], {1{~mul_temp_10[2]}}})>>>2;

  assign mul_temp_11 = delay_pipeline[4] * coeff5;
  assign product5 = ({{1{mul_temp_11[31]}}, mul_temp_11[31:0]} + {mul_temp_11[2], {1{~mul_temp_11[2]}}})>>>2;

  assign mul_temp_12 = delay_pipeline[3] * coeff4;
  assign product4 = ({{1{mul_temp_12[31]}}, mul_temp_12[31:0]} + {mul_temp_12[2], {1{~mul_temp_12[2]}}})>>>2;

  assign mul_temp_13 = delay_pipeline[2] * coeff3;
  assign product3 = ({{1{mul_temp_13[31]}}, mul_temp_13[31:0]} + {mul_temp_13[2], {1{~mul_temp_13[2]}}})>>>2;

  assign mul_temp_14 = delay_pipeline[1] * coeff2;
  assign product2 = ({{1{mul_temp_14[31]}}, mul_temp_14[31:0]} + {mul_temp_14[2], {1{~mul_temp_14[2]}}})>>>2;

  assign product1_cast = $signed({{3{product1[30]}}, product1});

  assign mul_temp_15 = delay_pipeline[0] * coeff1;
  assign product1 = ({{1{mul_temp_15[31]}}, mul_temp_15[31:0]} + {mul_temp_15[2], {1{~mul_temp_15[2]}}})>>>2;

  assign add_signext = product1_cast;
  assign add_signext_1 = $signed({{3{product2[30]}}, product2});
  assign add_temp = add_signext + add_signext_1;
  assign sum1 = add_temp[33:0];

  assign add_signext_2 = sum1;
  assign add_signext_3 = $signed({{3{product3[30]}}, product3});
  assign add_temp_1 = add_signext_2 + add_signext_3;
  assign sum2 = add_temp_1[33:0];

  assign add_signext_4 = sum2;
  assign add_signext_5 = $signed({{3{product4[30]}}, product4});
  assign add_temp_2 = add_signext_4 + add_signext_5;
  assign sum3 = add_temp_2[33:0];

  assign add_signext_6 = sum3;
  assign add_signext_7 = $signed({{3{product5[30]}}, product5});
  assign add_temp_3 = add_signext_6 + add_signext_7;
  assign sum4 = add_temp_3[33:0];

  assign add_signext_8 = sum4;
  assign add_signext_9 = $signed({{3{product6[30]}}, product6});
  assign add_temp_4 = add_signext_8 + add_signext_9;
  assign sum5 = add_temp_4[33:0];

  assign add_signext_10 = sum5;
  assign add_signext_11 = $signed({{3{product7[30]}}, product7});
  assign add_temp_5 = add_signext_10 + add_signext_11;
  assign sum6 = add_temp_5[33:0];

  assign add_signext_12 = sum6;
  assign add_signext_13 = $signed({{3{product8[30]}}, product8});
  assign add_temp_6 = add_signext_12 + add_signext_13;
  assign sum7 = add_temp_6[33:0];

  assign add_signext_14 = sum7;
  assign add_signext_15 = $signed({{3{product9[30]}}, product9});
  assign add_temp_7 = add_signext_14 + add_signext_15;
  assign sum8 = add_temp_7[33:0];

  assign add_signext_16 = sum8;
  assign add_signext_17 = $signed({{3{product10[30]}}, product10});
  assign add_temp_8 = add_signext_16 + add_signext_17;
  assign sum9 = add_temp_8[33:0];

  assign add_signext_18 = sum9;
  assign add_signext_19 = $signed({{3{product11[30]}}, product11});
  assign add_temp_9 = add_signext_18 + add_signext_19;
  assign sum10 = add_temp_9[33:0];

  assign add_signext_20 = sum10;
  assign add_signext_21 = $signed({{3{product12[30]}}, product12});
  assign add_temp_10 = add_signext_20 + add_signext_21;
  assign sum11 = add_temp_10[33:0];

  assign add_signext_22 = sum11;
  assign add_signext_23 = $signed({{3{product13[30]}}, product13});
  assign add_temp_11 = add_signext_22 + add_signext_23;
  assign sum12 = add_temp_11[33:0];

  assign add_signext_24 = sum12;
  assign add_signext_25 = $signed({{3{product14[30]}}, product14});
  assign add_temp_12 = add_signext_24 + add_signext_25;
  assign sum13 = add_temp_12[33:0];

  assign add_signext_26 = sum13;
  assign add_signext_27 = $signed({{3{product15[30]}}, product15});
  assign add_temp_13 = add_signext_26 + add_signext_27;
  assign sum14 = add_temp_13[33:0];

  assign add_signext_28 = sum14;
  assign add_signext_29 = $signed({{3{product16[30]}}, product16});
  assign add_temp_14 = add_signext_28 + add_signext_29;
  assign sum15 = add_temp_14[33:0];

  assign output_typeconvert = (sum15[31:0] + {sum15[16], {15{~sum15[16]}}})>>>16;

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
endmodule  // eq_myself_0




