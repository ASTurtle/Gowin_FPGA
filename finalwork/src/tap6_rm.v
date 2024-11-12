module tap_6_rm
               (
                clk,
                clk_enable,
                eff,
                en,
                reset,
                filter_in,
                filter_out
                );

  input   clk; 
  input   clk_enable; 
  input   reset;
  input   [111:0]eff;
  input   en;
  input   signed [15:0] filter_in; //sfix16_En15
  output  signed [15:0] filter_out; //sfix16_En15

////////////////////////////////////////////////////////////////
//Module Architecture: tap_6high_pass
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  assign coeff1 = eff[111:96]; //sfix16_En15
  assign coeff2 = eff[95:80]; //sfix16_En15
  assign coeff3 = eff[79:64]; //sfix16_En15
  assign coeff4 = eff[63:48]; //sfix16_En15
  assign coeff5 = eff[47:32]; //sfix16_En15
  assign coeff6 = eff[31:16]; //sfix16_En15
  assign coeff7 = eff[15:0]; //sfix16_En15

  // Signals
  reg  signed [15:0] delay_pipeline [0:6] ; // sfix16_En15
  wire signed [30:0] product7; // sfix31_En31
  wire signed [31:0] mul_temp; // sfix32_En32
  wire signed [30:0] product6; // sfix31_En31
  wire signed [16:0] mulpwr2_temp; // sfix17_En15
  wire signed [30:0] product5; // sfix31_En31
  wire signed [31:0] mul_temp_1; // sfix32_En32
  wire signed [30:0] product4; // sfix31_En31
  wire signed [31:0] mul_temp_2; // sfix32_En32
  wire signed [30:0] product3; // sfix31_En31
  wire signed [31:0] mul_temp_3; // sfix32_En32
  wire signed [30:0] product2; // sfix31_En31
  wire signed [16:0] mulpwr2_temp_1; // sfix17_En15
  wire signed [33:0] product1_cast; // sfix34_En31
  wire signed [30:0] product1; // sfix31_En31
  wire signed [31:0] mul_temp_4; // sfix32_En32
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
  wire signed [15:0] output_typeconvert; // sfix16_En15
  reg  signed [15:0] output_register; // sfix16_En15

  // Block Statements
  always @( posedge clk or posedge reset)
    begin: Delay_Pipeline_process
      if (reset == 1'b1) begin
        delay_pipeline[0] <= 0;
        delay_pipeline[1] <= 0;
        delay_pipeline[2] <= 0;
        delay_pipeline[3] <= 0;
        delay_pipeline[4] <= 0;
        delay_pipeline[5] <= 0;
        delay_pipeline[6] <= 0;
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
        end
      end
    end // Delay_Pipeline_process


  assign mul_temp = delay_pipeline[6] * coeff7;
  assign product7 = (mul_temp[31:0] + mul_temp[1])>>>1;

  assign mulpwr2_temp = (delay_pipeline[5]==16'b1000000000000000) ? $signed({1'b0, delay_pipeline[5]}) : -delay_pipeline[5];

  assign product6 = $signed({mulpwr2_temp[16:0], 14'b00000000000000});

  assign mul_temp_1 = delay_pipeline[4] * coeff5;
  assign product5 = (mul_temp_1[31:0] + mul_temp_1[1])>>>1;

  assign mul_temp_2 = delay_pipeline[3] * coeff4;
  assign product4 = (mul_temp_2[31:0] + mul_temp_2[1])>>>1;

  assign mul_temp_3 = delay_pipeline[2] * coeff3;
  assign product3 = (mul_temp_3[31:0] + mul_temp_3[1])>>>1;

  assign mulpwr2_temp_1 = (delay_pipeline[1]==16'b1000000000000000) ? $signed({1'b0, delay_pipeline[1]}) : -delay_pipeline[1];

  assign product2 = $signed({mulpwr2_temp_1[16:0], 14'b00000000000000});

  assign product1_cast = $signed({{3{product1[30]}}, product1});

  assign mul_temp_4 = delay_pipeline[0] * coeff1;
  assign product1 = (mul_temp_4[31:0] + mul_temp_4[1])>>>1;

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

  assign output_typeconvert = (sum6[31:0] + {sum6[16], {15{~sum6[16]}}})>>>16;

   always @ (posedge clk or posedge reset)
    begin: Output_Register_process
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
        if (en == 1'b1) begin
          output_register <= output_typeconvert;
        end else begin
            output_register <= filter_in;
        end 
      end 
    end // Output_Register_process

  // Assignment Statements
  assign filter_out = output_register;
endmodule  // tap_6high_pass