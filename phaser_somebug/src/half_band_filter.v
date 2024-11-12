`timescale 1 ns / 1 ns

module halfpass_filter
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
//Module Architecture: halfpass_filter
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [15:0] coeff1 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff2 = 16'b1111111010110000; //sfix16_En15
  parameter signed [15:0] coeff3 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff4 = 16'b0000000001110101; //sfix16_En15
  parameter signed [15:0] coeff5 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff6 = 16'b1111111101110111; //sfix16_En15
  parameter signed [15:0] coeff7 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff8 = 16'b0000000010100000; //sfix16_En15
  parameter signed [15:0] coeff9 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff10 = 16'b1111111101000110; //sfix16_En15
  parameter signed [15:0] coeff11 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff12 = 16'b0000000011010111; //sfix16_En15
  parameter signed [15:0] coeff13 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff14 = 16'b1111111100000111; //sfix16_En15
  parameter signed [15:0] coeff15 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff16 = 16'b0000000100100000; //sfix16_En15
  parameter signed [15:0] coeff17 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff18 = 16'b1111111010110100; //sfix16_En15
  parameter signed [15:0] coeff19 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff20 = 16'b0000000110000000; //sfix16_En15
  parameter signed [15:0] coeff21 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff22 = 16'b1111111001000011; //sfix16_En15
  parameter signed [15:0] coeff23 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff24 = 16'b0000001000000111; //sfix16_En15
  parameter signed [15:0] coeff25 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff26 = 16'b1111110110011101; //sfix16_En15
  parameter signed [15:0] coeff27 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff28 = 16'b0000001011011000; //sfix16_En15
  parameter signed [15:0] coeff29 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff30 = 16'b1111110010001011; //sfix16_En15
  parameter signed [15:0] coeff31 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff32 = 16'b0000010001010011; //sfix16_En15
  parameter signed [15:0] coeff33 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff34 = 16'b1111101001010111; //sfix16_En15
  parameter signed [15:0] coeff35 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff36 = 16'b0000100000001001; //sfix16_En15
  parameter signed [15:0] coeff37 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff38 = 16'b1111001001111101; //sfix16_En15
  parameter signed [15:0] coeff39 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff40 = 16'b0010100010111001; //sfix16_En15
  parameter signed [15:0] coeff41 = 16'b0100000000000000; //sfix16_En15
  parameter signed [15:0] coeff42 = 16'b0010100010111001; //sfix16_En15
  parameter signed [15:0] coeff43 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff44 = 16'b1111001001111101; //sfix16_En15
  parameter signed [15:0] coeff45 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff46 = 16'b0000100000001001; //sfix16_En15
  parameter signed [15:0] coeff47 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff48 = 16'b1111101001010111; //sfix16_En15
  parameter signed [15:0] coeff49 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff50 = 16'b0000010001010011; //sfix16_En15
  parameter signed [15:0] coeff51 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff52 = 16'b1111110010001011; //sfix16_En15
  parameter signed [15:0] coeff53 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff54 = 16'b0000001011011000; //sfix16_En15
  parameter signed [15:0] coeff55 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff56 = 16'b1111110110011101; //sfix16_En15
  parameter signed [15:0] coeff57 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff58 = 16'b0000001000000111; //sfix16_En15
  parameter signed [15:0] coeff59 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff60 = 16'b1111111001000011; //sfix16_En15
  parameter signed [15:0] coeff61 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff62 = 16'b0000000110000000; //sfix16_En15
  parameter signed [15:0] coeff63 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff64 = 16'b1111111010110100; //sfix16_En15
  parameter signed [15:0] coeff65 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff66 = 16'b0000000100100000; //sfix16_En15
  parameter signed [15:0] coeff67 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff68 = 16'b1111111100000111; //sfix16_En15
  parameter signed [15:0] coeff69 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff70 = 16'b0000000011010111; //sfix16_En15
  parameter signed [15:0] coeff71 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff72 = 16'b1111111101000110; //sfix16_En15
  parameter signed [15:0] coeff73 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff74 = 16'b0000000010100000; //sfix16_En15
  parameter signed [15:0] coeff75 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff76 = 16'b1111111101110111; //sfix16_En15
  parameter signed [15:0] coeff77 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff78 = 16'b0000000001110101; //sfix16_En15
  parameter signed [15:0] coeff79 = 16'b0000000000000000; //sfix16_En15
  parameter signed [15:0] coeff80 = 16'b1111111010110000; //sfix16_En15
  parameter signed [15:0] coeff81 = 16'b0000000000000000; //sfix16_En15

  // Signals
  reg  signed [15:0] delay_pipeline [0:80] ; // sfix16_En15
  wire signed [30:0] product80; // sfix31_En31
  wire signed [31:0] mul_temp; // sfix32_En30
  wire signed [30:0] product78; // sfix31_En31
  wire signed [31:0] mul_temp_1; // sfix32_En30
  wire signed [30:0] product76; // sfix31_En31
  wire signed [31:0] mul_temp_2; // sfix32_En30
  wire signed [30:0] product74; // sfix31_En31
  wire signed [31:0] mul_temp_3; // sfix32_En30
  wire signed [30:0] product72; // sfix31_En31
  wire signed [31:0] mul_temp_4; // sfix32_En30
  wire signed [30:0] product70; // sfix31_En31
  wire signed [31:0] mul_temp_5; // sfix32_En30
  wire signed [30:0] product68; // sfix31_En31
  wire signed [31:0] mul_temp_6; // sfix32_En30
  wire signed [30:0] product66; // sfix31_En31
  wire signed [31:0] mul_temp_7; // sfix32_En30
  wire signed [30:0] product64; // sfix31_En31
  wire signed [31:0] mul_temp_8; // sfix32_En30
  wire signed [30:0] product62; // sfix31_En31
  wire signed [31:0] mul_temp_9; // sfix32_En30
  wire signed [30:0] product60; // sfix31_En31
  wire signed [31:0] mul_temp_10; // sfix32_En30
  wire signed [30:0] product58; // sfix31_En31
  wire signed [31:0] mul_temp_11; // sfix32_En30
  wire signed [30:0] product56; // sfix31_En31
  wire signed [31:0] mul_temp_12; // sfix32_En30
  wire signed [30:0] product54; // sfix31_En31
  wire signed [31:0] mul_temp_13; // sfix32_En30
  wire signed [30:0] product52; // sfix31_En31
  wire signed [31:0] mul_temp_14; // sfix32_En30
  wire signed [30:0] product50; // sfix31_En31
  wire signed [31:0] mul_temp_15; // sfix32_En30
  wire signed [30:0] product48; // sfix31_En31
  wire signed [31:0] mul_temp_16; // sfix32_En30
  wire signed [30:0] product46; // sfix31_En31
  wire signed [31:0] mul_temp_17; // sfix32_En30
  wire signed [30:0] product44; // sfix31_En31
  wire signed [31:0] mul_temp_18; // sfix32_En30
  wire signed [30:0] product42; // sfix31_En31
  wire signed [31:0] mul_temp_19; // sfix32_En30
  wire signed [30:0] product41; // sfix31_En31
  wire signed [30:0] product40; // sfix31_En31
  wire signed [31:0] mul_temp_20; // sfix32_En30
  wire signed [30:0] product38; // sfix31_En31
  wire signed [31:0] mul_temp_21; // sfix32_En30
  wire signed [30:0] product36; // sfix31_En31
  wire signed [31:0] mul_temp_22; // sfix32_En30
  wire signed [30:0] product34; // sfix31_En31
  wire signed [31:0] mul_temp_23; // sfix32_En30
  wire signed [30:0] product32; // sfix31_En31
  wire signed [31:0] mul_temp_24; // sfix32_En30
  wire signed [30:0] product30; // sfix31_En31
  wire signed [31:0] mul_temp_25; // sfix32_En30
  wire signed [30:0] product28; // sfix31_En31
  wire signed [31:0] mul_temp_26; // sfix32_En30
  wire signed [30:0] product26; // sfix31_En31
  wire signed [31:0] mul_temp_27; // sfix32_En30
  wire signed [30:0] product24; // sfix31_En31
  wire signed [31:0] mul_temp_28; // sfix32_En30
  wire signed [30:0] product22; // sfix31_En31
  wire signed [31:0] mul_temp_29; // sfix32_En30
  wire signed [30:0] product20; // sfix31_En31
  wire signed [31:0] mul_temp_30; // sfix32_En30
  wire signed [30:0] product18; // sfix31_En31
  wire signed [31:0] mul_temp_31; // sfix32_En30
  wire signed [30:0] product16; // sfix31_En31
  wire signed [31:0] mul_temp_32; // sfix32_En30
  wire signed [30:0] product14; // sfix31_En31
  wire signed [31:0] mul_temp_33; // sfix32_En30
  wire signed [30:0] product12; // sfix31_En31
  wire signed [31:0] mul_temp_34; // sfix32_En30
  wire signed [30:0] product10; // sfix31_En31
  wire signed [31:0] mul_temp_35; // sfix32_En30
  wire signed [30:0] product8; // sfix31_En31
  wire signed [31:0] mul_temp_36; // sfix32_En30
  wire signed [30:0] product6; // sfix31_En31
  wire signed [31:0] mul_temp_37; // sfix32_En30
  wire signed [30:0] product4; // sfix31_En31
  wire signed [31:0] mul_temp_38; // sfix32_En30
  wire signed [30:0] product2; // sfix31_En31
  wire signed [31:0] mul_temp_39; // sfix32_En30
  wire signed [33:0] sum1; // sfix34_En31
  wire signed [30:0] add_signext; // sfix31_En31
  wire signed [30:0] add_signext_1; // sfix31_En31
  wire signed [31:0] add_temp; // sfix32_En31
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
  wire signed [33:0] sum16; // sfix34_En31
  wire signed [33:0] add_signext_30; // sfix34_En31
  wire signed [33:0] add_signext_31; // sfix34_En31
  wire signed [34:0] add_temp_15; // sfix35_En31
  wire signed [33:0] sum17; // sfix34_En31
  wire signed [33:0] add_signext_32; // sfix34_En31
  wire signed [33:0] add_signext_33; // sfix34_En31
  wire signed [34:0] add_temp_16; // sfix35_En31
  wire signed [33:0] sum18; // sfix34_En31
  wire signed [33:0] add_signext_34; // sfix34_En31
  wire signed [33:0] add_signext_35; // sfix34_En31
  wire signed [34:0] add_temp_17; // sfix35_En31
  wire signed [33:0] sum19; // sfix34_En31
  wire signed [33:0] add_signext_36; // sfix34_En31
  wire signed [33:0] add_signext_37; // sfix34_En31
  wire signed [34:0] add_temp_18; // sfix35_En31
  wire signed [33:0] sum20; // sfix34_En31
  wire signed [33:0] add_signext_38; // sfix34_En31
  wire signed [33:0] add_signext_39; // sfix34_En31
  wire signed [34:0] add_temp_19; // sfix35_En31
  wire signed [33:0] sum21; // sfix34_En31
  wire signed [33:0] add_signext_40; // sfix34_En31
  wire signed [33:0] add_signext_41; // sfix34_En31
  wire signed [34:0] add_temp_20; // sfix35_En31
  wire signed [33:0] sum22; // sfix34_En31
  wire signed [33:0] add_signext_42; // sfix34_En31
  wire signed [33:0] add_signext_43; // sfix34_En31
  wire signed [34:0] add_temp_21; // sfix35_En31
  wire signed [33:0] sum23; // sfix34_En31
  wire signed [33:0] add_signext_44; // sfix34_En31
  wire signed [33:0] add_signext_45; // sfix34_En31
  wire signed [34:0] add_temp_22; // sfix35_En31
  wire signed [33:0] sum24; // sfix34_En31
  wire signed [33:0] add_signext_46; // sfix34_En31
  wire signed [33:0] add_signext_47; // sfix34_En31
  wire signed [34:0] add_temp_23; // sfix35_En31
  wire signed [33:0] sum25; // sfix34_En31
  wire signed [33:0] add_signext_48; // sfix34_En31
  wire signed [33:0] add_signext_49; // sfix34_En31
  wire signed [34:0] add_temp_24; // sfix35_En31
  wire signed [33:0] sum26; // sfix34_En31
  wire signed [33:0] add_signext_50; // sfix34_En31
  wire signed [33:0] add_signext_51; // sfix34_En31
  wire signed [34:0] add_temp_25; // sfix35_En31
  wire signed [33:0] sum27; // sfix34_En31
  wire signed [33:0] add_signext_52; // sfix34_En31
  wire signed [33:0] add_signext_53; // sfix34_En31
  wire signed [34:0] add_temp_26; // sfix35_En31
  wire signed [33:0] sum28; // sfix34_En31
  wire signed [33:0] add_signext_54; // sfix34_En31
  wire signed [33:0] add_signext_55; // sfix34_En31
  wire signed [34:0] add_temp_27; // sfix35_En31
  wire signed [33:0] sum29; // sfix34_En31
  wire signed [33:0] add_signext_56; // sfix34_En31
  wire signed [33:0] add_signext_57; // sfix34_En31
  wire signed [34:0] add_temp_28; // sfix35_En31
  wire signed [33:0] sum30; // sfix34_En31
  wire signed [33:0] add_signext_58; // sfix34_En31
  wire signed [33:0] add_signext_59; // sfix34_En31
  wire signed [34:0] add_temp_29; // sfix35_En31
  wire signed [33:0] sum31; // sfix34_En31
  wire signed [33:0] add_signext_60; // sfix34_En31
  wire signed [33:0] add_signext_61; // sfix34_En31
  wire signed [34:0] add_temp_30; // sfix35_En31
  wire signed [33:0] sum32; // sfix34_En31
  wire signed [33:0] add_signext_62; // sfix34_En31
  wire signed [33:0] add_signext_63; // sfix34_En31
  wire signed [34:0] add_temp_31; // sfix35_En31
  wire signed [33:0] sum33; // sfix34_En31
  wire signed [33:0] add_signext_64; // sfix34_En31
  wire signed [33:0] add_signext_65; // sfix34_En31
  wire signed [34:0] add_temp_32; // sfix35_En31
  wire signed [33:0] sum34; // sfix34_En31
  wire signed [33:0] add_signext_66; // sfix34_En31
  wire signed [33:0] add_signext_67; // sfix34_En31
  wire signed [34:0] add_temp_33; // sfix35_En31
  wire signed [33:0] sum35; // sfix34_En31
  wire signed [33:0] add_signext_68; // sfix34_En31
  wire signed [33:0] add_signext_69; // sfix34_En31
  wire signed [34:0] add_temp_34; // sfix35_En31
  wire signed [33:0] sum36; // sfix34_En31
  wire signed [33:0] add_signext_70; // sfix34_En31
  wire signed [33:0] add_signext_71; // sfix34_En31
  wire signed [34:0] add_temp_35; // sfix35_En31
  wire signed [33:0] sum37; // sfix34_En31
  wire signed [33:0] add_signext_72; // sfix34_En31
  wire signed [33:0] add_signext_73; // sfix34_En31
  wire signed [34:0] add_temp_36; // sfix35_En31
  wire signed [33:0] sum38; // sfix34_En31
  wire signed [33:0] add_signext_74; // sfix34_En31
  wire signed [33:0] add_signext_75; // sfix34_En31
  wire signed [34:0] add_temp_37; // sfix35_En31
  wire signed [33:0] sum39; // sfix34_En31
  wire signed [33:0] add_signext_76; // sfix34_En31
  wire signed [33:0] add_signext_77; // sfix34_En31
  wire signed [34:0] add_temp_38; // sfix35_En31
  wire signed [33:0] sum40; // sfix34_En31
  wire signed [33:0] add_signext_78; // sfix34_En31
  wire signed [33:0] add_signext_79; // sfix34_En31
  wire signed [34:0] add_temp_39; // sfix35_En31
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
        delay_pipeline[16] <= 0;
        delay_pipeline[17] <= 0;
        delay_pipeline[18] <= 0;
        delay_pipeline[19] <= 0;
        delay_pipeline[20] <= 0;
        delay_pipeline[21] <= 0;
        delay_pipeline[22] <= 0;
        delay_pipeline[23] <= 0;
        delay_pipeline[24] <= 0;
        delay_pipeline[25] <= 0;
        delay_pipeline[26] <= 0;
        delay_pipeline[27] <= 0;
        delay_pipeline[28] <= 0;
        delay_pipeline[29] <= 0;
        delay_pipeline[30] <= 0;
        delay_pipeline[31] <= 0;
        delay_pipeline[32] <= 0;
        delay_pipeline[33] <= 0;
        delay_pipeline[34] <= 0;
        delay_pipeline[35] <= 0;
        delay_pipeline[36] <= 0;
        delay_pipeline[37] <= 0;
        delay_pipeline[38] <= 0;
        delay_pipeline[39] <= 0;
        delay_pipeline[40] <= 0;
        delay_pipeline[41] <= 0;
        delay_pipeline[42] <= 0;
        delay_pipeline[43] <= 0;
        delay_pipeline[44] <= 0;
        delay_pipeline[45] <= 0;
        delay_pipeline[46] <= 0;
        delay_pipeline[47] <= 0;
        delay_pipeline[48] <= 0;
        delay_pipeline[49] <= 0;
        delay_pipeline[50] <= 0;
        delay_pipeline[51] <= 0;
        delay_pipeline[52] <= 0;
        delay_pipeline[53] <= 0;
        delay_pipeline[54] <= 0;
        delay_pipeline[55] <= 0;
        delay_pipeline[56] <= 0;
        delay_pipeline[57] <= 0;
        delay_pipeline[58] <= 0;
        delay_pipeline[59] <= 0;
        delay_pipeline[60] <= 0;
        delay_pipeline[61] <= 0;
        delay_pipeline[62] <= 0;
        delay_pipeline[63] <= 0;
        delay_pipeline[64] <= 0;
        delay_pipeline[65] <= 0;
        delay_pipeline[66] <= 0;
        delay_pipeline[67] <= 0;
        delay_pipeline[68] <= 0;
        delay_pipeline[69] <= 0;
        delay_pipeline[70] <= 0;
        delay_pipeline[71] <= 0;
        delay_pipeline[72] <= 0;
        delay_pipeline[73] <= 0;
        delay_pipeline[74] <= 0;
        delay_pipeline[75] <= 0;
        delay_pipeline[76] <= 0;
        delay_pipeline[77] <= 0;
        delay_pipeline[78] <= 0;
        delay_pipeline[79] <= 0;
        delay_pipeline[80] <= 0;
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
          delay_pipeline[16] <= delay_pipeline[15];
          delay_pipeline[17] <= delay_pipeline[16];
          delay_pipeline[18] <= delay_pipeline[17];
          delay_pipeline[19] <= delay_pipeline[18];
          delay_pipeline[20] <= delay_pipeline[19];
          delay_pipeline[21] <= delay_pipeline[20];
          delay_pipeline[22] <= delay_pipeline[21];
          delay_pipeline[23] <= delay_pipeline[22];
          delay_pipeline[24] <= delay_pipeline[23];
          delay_pipeline[25] <= delay_pipeline[24];
          delay_pipeline[26] <= delay_pipeline[25];
          delay_pipeline[27] <= delay_pipeline[26];
          delay_pipeline[28] <= delay_pipeline[27];
          delay_pipeline[29] <= delay_pipeline[28];
          delay_pipeline[30] <= delay_pipeline[29];
          delay_pipeline[31] <= delay_pipeline[30];
          delay_pipeline[32] <= delay_pipeline[31];
          delay_pipeline[33] <= delay_pipeline[32];
          delay_pipeline[34] <= delay_pipeline[33];
          delay_pipeline[35] <= delay_pipeline[34];
          delay_pipeline[36] <= delay_pipeline[35];
          delay_pipeline[37] <= delay_pipeline[36];
          delay_pipeline[38] <= delay_pipeline[37];
          delay_pipeline[39] <= delay_pipeline[38];
          delay_pipeline[40] <= delay_pipeline[39];
          delay_pipeline[41] <= delay_pipeline[40];
          delay_pipeline[42] <= delay_pipeline[41];
          delay_pipeline[43] <= delay_pipeline[42];
          delay_pipeline[44] <= delay_pipeline[43];
          delay_pipeline[45] <= delay_pipeline[44];
          delay_pipeline[46] <= delay_pipeline[45];
          delay_pipeline[47] <= delay_pipeline[46];
          delay_pipeline[48] <= delay_pipeline[47];
          delay_pipeline[49] <= delay_pipeline[48];
          delay_pipeline[50] <= delay_pipeline[49];
          delay_pipeline[51] <= delay_pipeline[50];
          delay_pipeline[52] <= delay_pipeline[51];
          delay_pipeline[53] <= delay_pipeline[52];
          delay_pipeline[54] <= delay_pipeline[53];
          delay_pipeline[55] <= delay_pipeline[54];
          delay_pipeline[56] <= delay_pipeline[55];
          delay_pipeline[57] <= delay_pipeline[56];
          delay_pipeline[58] <= delay_pipeline[57];
          delay_pipeline[59] <= delay_pipeline[58];
          delay_pipeline[60] <= delay_pipeline[59];
          delay_pipeline[61] <= delay_pipeline[60];
          delay_pipeline[62] <= delay_pipeline[61];
          delay_pipeline[63] <= delay_pipeline[62];
          delay_pipeline[64] <= delay_pipeline[63];
          delay_pipeline[65] <= delay_pipeline[64];
          delay_pipeline[66] <= delay_pipeline[65];
          delay_pipeline[67] <= delay_pipeline[66];
          delay_pipeline[68] <= delay_pipeline[67];
          delay_pipeline[69] <= delay_pipeline[68];
          delay_pipeline[70] <= delay_pipeline[69];
          delay_pipeline[71] <= delay_pipeline[70];
          delay_pipeline[72] <= delay_pipeline[71];
          delay_pipeline[73] <= delay_pipeline[72];
          delay_pipeline[74] <= delay_pipeline[73];
          delay_pipeline[75] <= delay_pipeline[74];
          delay_pipeline[76] <= delay_pipeline[75];
          delay_pipeline[77] <= delay_pipeline[76];
          delay_pipeline[78] <= delay_pipeline[77];
          delay_pipeline[79] <= delay_pipeline[78];
          delay_pipeline[80] <= delay_pipeline[79];
        end
      end
    end // Delay_Pipeline_process


  assign mul_temp = delay_pipeline[79] * coeff80;
  assign product80 = $signed({mul_temp[29:0], 1'b0});

  assign mul_temp_1 = delay_pipeline[77] * coeff78;
  assign product78 = $signed({mul_temp_1[29:0], 1'b0});

  assign mul_temp_2 = delay_pipeline[75] * coeff76;
  assign product76 = $signed({mul_temp_2[29:0], 1'b0});

  assign mul_temp_3 = delay_pipeline[73] * coeff74;
  assign product74 = $signed({mul_temp_3[29:0], 1'b0});

  assign mul_temp_4 = delay_pipeline[71] * coeff72;
  assign product72 = $signed({mul_temp_4[29:0], 1'b0});

  assign mul_temp_5 = delay_pipeline[69] * coeff70;
  assign product70 = $signed({mul_temp_5[29:0], 1'b0});

  assign mul_temp_6 = delay_pipeline[67] * coeff68;
  assign product68 = $signed({mul_temp_6[29:0], 1'b0});

  assign mul_temp_7 = delay_pipeline[65] * coeff66;
  assign product66 = $signed({mul_temp_7[29:0], 1'b0});

  assign mul_temp_8 = delay_pipeline[63] * coeff64;
  assign product64 = $signed({mul_temp_8[29:0], 1'b0});

  assign mul_temp_9 = delay_pipeline[61] * coeff62;
  assign product62 = $signed({mul_temp_9[29:0], 1'b0});

  assign mul_temp_10 = delay_pipeline[59] * coeff60;
  assign product60 = $signed({mul_temp_10[29:0], 1'b0});

  assign mul_temp_11 = delay_pipeline[57] * coeff58;
  assign product58 = $signed({mul_temp_11[29:0], 1'b0});

  assign mul_temp_12 = delay_pipeline[55] * coeff56;
  assign product56 = $signed({mul_temp_12[29:0], 1'b0});

  assign mul_temp_13 = delay_pipeline[53] * coeff54;
  assign product54 = $signed({mul_temp_13[29:0], 1'b0});

  assign mul_temp_14 = delay_pipeline[51] * coeff52;
  assign product52 = $signed({mul_temp_14[29:0], 1'b0});

  assign mul_temp_15 = delay_pipeline[49] * coeff50;
  assign product50 = $signed({mul_temp_15[29:0], 1'b0});

  assign mul_temp_16 = delay_pipeline[47] * coeff48;
  assign product48 = $signed({mul_temp_16[29:0], 1'b0});

  assign mul_temp_17 = delay_pipeline[45] * coeff46;
  assign product46 = $signed({mul_temp_17[29:0], 1'b0});

  assign mul_temp_18 = delay_pipeline[43] * coeff44;
  assign product44 = $signed({mul_temp_18[29:0], 1'b0});

  assign mul_temp_19 = delay_pipeline[41] * coeff42;
  assign product42 = $signed({mul_temp_19[29:0], 1'b0});

  assign product41 = $signed({delay_pipeline[40][15:0], 15'b000000000000000});

  assign mul_temp_20 = delay_pipeline[39] * coeff40;
  assign product40 = $signed({mul_temp_20[29:0], 1'b0});

  assign mul_temp_21 = delay_pipeline[37] * coeff38;
  assign product38 = $signed({mul_temp_21[29:0], 1'b0});

  assign mul_temp_22 = delay_pipeline[35] * coeff36;
  assign product36 = $signed({mul_temp_22[29:0], 1'b0});

  assign mul_temp_23 = delay_pipeline[33] * coeff34;
  assign product34 = $signed({mul_temp_23[29:0], 1'b0});

  assign mul_temp_24 = delay_pipeline[31] * coeff32;
  assign product32 = $signed({mul_temp_24[29:0], 1'b0});

  assign mul_temp_25 = delay_pipeline[29] * coeff30;
  assign product30 = $signed({mul_temp_25[29:0], 1'b0});

  assign mul_temp_26 = delay_pipeline[27] * coeff28;
  assign product28 = $signed({mul_temp_26[29:0], 1'b0});

  assign mul_temp_27 = delay_pipeline[25] * coeff26;
  assign product26 = $signed({mul_temp_27[29:0], 1'b0});

  assign mul_temp_28 = delay_pipeline[23] * coeff24;
  assign product24 = $signed({mul_temp_28[29:0], 1'b0});

  assign mul_temp_29 = delay_pipeline[21] * coeff22;
  assign product22 = $signed({mul_temp_29[29:0], 1'b0});

  assign mul_temp_30 = delay_pipeline[19] * coeff20;
  assign product20 = $signed({mul_temp_30[29:0], 1'b0});

  assign mul_temp_31 = delay_pipeline[17] * coeff18;
  assign product18 = $signed({mul_temp_31[29:0], 1'b0});

  assign mul_temp_32 = delay_pipeline[15] * coeff16;
  assign product16 = $signed({mul_temp_32[29:0], 1'b0});

  assign mul_temp_33 = delay_pipeline[13] * coeff14;
  assign product14 = $signed({mul_temp_33[29:0], 1'b0});

  assign mul_temp_34 = delay_pipeline[11] * coeff12;
  assign product12 = $signed({mul_temp_34[29:0], 1'b0});

  assign mul_temp_35 = delay_pipeline[9] * coeff10;
  assign product10 = $signed({mul_temp_35[29:0], 1'b0});

  assign mul_temp_36 = delay_pipeline[7] * coeff8;
  assign product8 = $signed({mul_temp_36[29:0], 1'b0});

  assign mul_temp_37 = delay_pipeline[5] * coeff6;
  assign product6 = $signed({mul_temp_37[29:0], 1'b0});

  assign mul_temp_38 = delay_pipeline[3] * coeff4;
  assign product4 = $signed({mul_temp_38[29:0], 1'b0});

  assign mul_temp_39 = delay_pipeline[1] * coeff2;
  assign product2 = $signed({mul_temp_39[29:0], 1'b0});

  assign add_signext = product2;
  assign add_signext_1 = product4;
  assign add_temp = add_signext + add_signext_1;
  assign sum1 = $signed({{2{add_temp[31]}}, add_temp});

  assign add_signext_2 = sum1;
  assign add_signext_3 = $signed({{3{product6[30]}}, product6});
  assign add_temp_1 = add_signext_2 + add_signext_3;
  assign sum2 = add_temp_1[33:0];

  assign add_signext_4 = sum2;
  assign add_signext_5 = $signed({{3{product8[30]}}, product8});
  assign add_temp_2 = add_signext_4 + add_signext_5;
  assign sum3 = add_temp_2[33:0];

  assign add_signext_6 = sum3;
  assign add_signext_7 = $signed({{3{product10[30]}}, product10});
  assign add_temp_3 = add_signext_6 + add_signext_7;
  assign sum4 = add_temp_3[33:0];

  assign add_signext_8 = sum4;
  assign add_signext_9 = $signed({{3{product12[30]}}, product12});
  assign add_temp_4 = add_signext_8 + add_signext_9;
  assign sum5 = add_temp_4[33:0];

  assign add_signext_10 = sum5;
  assign add_signext_11 = $signed({{3{product14[30]}}, product14});
  assign add_temp_5 = add_signext_10 + add_signext_11;
  assign sum6 = add_temp_5[33:0];

  assign add_signext_12 = sum6;
  assign add_signext_13 = $signed({{3{product16[30]}}, product16});
  assign add_temp_6 = add_signext_12 + add_signext_13;
  assign sum7 = add_temp_6[33:0];

  assign add_signext_14 = sum7;
  assign add_signext_15 = $signed({{3{product18[30]}}, product18});
  assign add_temp_7 = add_signext_14 + add_signext_15;
  assign sum8 = add_temp_7[33:0];

  assign add_signext_16 = sum8;
  assign add_signext_17 = $signed({{3{product20[30]}}, product20});
  assign add_temp_8 = add_signext_16 + add_signext_17;
  assign sum9 = add_temp_8[33:0];

  assign add_signext_18 = sum9;
  assign add_signext_19 = $signed({{3{product22[30]}}, product22});
  assign add_temp_9 = add_signext_18 + add_signext_19;
  assign sum10 = add_temp_9[33:0];

  assign add_signext_20 = sum10;
  assign add_signext_21 = $signed({{3{product24[30]}}, product24});
  assign add_temp_10 = add_signext_20 + add_signext_21;
  assign sum11 = add_temp_10[33:0];

  assign add_signext_22 = sum11;
  assign add_signext_23 = $signed({{3{product26[30]}}, product26});
  assign add_temp_11 = add_signext_22 + add_signext_23;
  assign sum12 = add_temp_11[33:0];

  assign add_signext_24 = sum12;
  assign add_signext_25 = $signed({{3{product28[30]}}, product28});
  assign add_temp_12 = add_signext_24 + add_signext_25;
  assign sum13 = add_temp_12[33:0];

  assign add_signext_26 = sum13;
  assign add_signext_27 = $signed({{3{product30[30]}}, product30});
  assign add_temp_13 = add_signext_26 + add_signext_27;
  assign sum14 = add_temp_13[33:0];

  assign add_signext_28 = sum14;
  assign add_signext_29 = $signed({{3{product32[30]}}, product32});
  assign add_temp_14 = add_signext_28 + add_signext_29;
  assign sum15 = add_temp_14[33:0];

  assign add_signext_30 = sum15;
  assign add_signext_31 = $signed({{3{product34[30]}}, product34});
  assign add_temp_15 = add_signext_30 + add_signext_31;
  assign sum16 = add_temp_15[33:0];

  assign add_signext_32 = sum16;
  assign add_signext_33 = $signed({{3{product36[30]}}, product36});
  assign add_temp_16 = add_signext_32 + add_signext_33;
  assign sum17 = add_temp_16[33:0];

  assign add_signext_34 = sum17;
  assign add_signext_35 = $signed({{3{product38[30]}}, product38});
  assign add_temp_17 = add_signext_34 + add_signext_35;
  assign sum18 = add_temp_17[33:0];

  assign add_signext_36 = sum18;
  assign add_signext_37 = $signed({{3{product40[30]}}, product40});
  assign add_temp_18 = add_signext_36 + add_signext_37;
  assign sum19 = add_temp_18[33:0];

  assign add_signext_38 = sum19;
  assign add_signext_39 = $signed({{3{product41[30]}}, product41});
  assign add_temp_19 = add_signext_38 + add_signext_39;
  assign sum20 = add_temp_19[33:0];

  assign add_signext_40 = sum20;
  assign add_signext_41 = $signed({{3{product42[30]}}, product42});
  assign add_temp_20 = add_signext_40 + add_signext_41;
  assign sum21 = add_temp_20[33:0];

  assign add_signext_42 = sum21;
  assign add_signext_43 = $signed({{3{product44[30]}}, product44});
  assign add_temp_21 = add_signext_42 + add_signext_43;
  assign sum22 = add_temp_21[33:0];

  assign add_signext_44 = sum22;
  assign add_signext_45 = $signed({{3{product46[30]}}, product46});
  assign add_temp_22 = add_signext_44 + add_signext_45;
  assign sum23 = add_temp_22[33:0];

  assign add_signext_46 = sum23;
  assign add_signext_47 = $signed({{3{product48[30]}}, product48});
  assign add_temp_23 = add_signext_46 + add_signext_47;
  assign sum24 = add_temp_23[33:0];

  assign add_signext_48 = sum24;
  assign add_signext_49 = $signed({{3{product50[30]}}, product50});
  assign add_temp_24 = add_signext_48 + add_signext_49;
  assign sum25 = add_temp_24[33:0];

  assign add_signext_50 = sum25;
  assign add_signext_51 = $signed({{3{product52[30]}}, product52});
  assign add_temp_25 = add_signext_50 + add_signext_51;
  assign sum26 = add_temp_25[33:0];

  assign add_signext_52 = sum26;
  assign add_signext_53 = $signed({{3{product54[30]}}, product54});
  assign add_temp_26 = add_signext_52 + add_signext_53;
  assign sum27 = add_temp_26[33:0];

  assign add_signext_54 = sum27;
  assign add_signext_55 = $signed({{3{product56[30]}}, product56});
  assign add_temp_27 = add_signext_54 + add_signext_55;
  assign sum28 = add_temp_27[33:0];

  assign add_signext_56 = sum28;
  assign add_signext_57 = $signed({{3{product58[30]}}, product58});
  assign add_temp_28 = add_signext_56 + add_signext_57;
  assign sum29 = add_temp_28[33:0];

  assign add_signext_58 = sum29;
  assign add_signext_59 = $signed({{3{product60[30]}}, product60});
  assign add_temp_29 = add_signext_58 + add_signext_59;
  assign sum30 = add_temp_29[33:0];

  assign add_signext_60 = sum30;
  assign add_signext_61 = $signed({{3{product62[30]}}, product62});
  assign add_temp_30 = add_signext_60 + add_signext_61;
  assign sum31 = add_temp_30[33:0];

  assign add_signext_62 = sum31;
  assign add_signext_63 = $signed({{3{product64[30]}}, product64});
  assign add_temp_31 = add_signext_62 + add_signext_63;
  assign sum32 = add_temp_31[33:0];

  assign add_signext_64 = sum32;
  assign add_signext_65 = $signed({{3{product66[30]}}, product66});
  assign add_temp_32 = add_signext_64 + add_signext_65;
  assign sum33 = add_temp_32[33:0];

  assign add_signext_66 = sum33;
  assign add_signext_67 = $signed({{3{product68[30]}}, product68});
  assign add_temp_33 = add_signext_66 + add_signext_67;
  assign sum34 = add_temp_33[33:0];

  assign add_signext_68 = sum34;
  assign add_signext_69 = $signed({{3{product70[30]}}, product70});
  assign add_temp_34 = add_signext_68 + add_signext_69;
  assign sum35 = add_temp_34[33:0];

  assign add_signext_70 = sum35;
  assign add_signext_71 = $signed({{3{product72[30]}}, product72});
  assign add_temp_35 = add_signext_70 + add_signext_71;
  assign sum36 = add_temp_35[33:0];

  assign add_signext_72 = sum36;
  assign add_signext_73 = $signed({{3{product74[30]}}, product74});
  assign add_temp_36 = add_signext_72 + add_signext_73;
  assign sum37 = add_temp_36[33:0];

  assign add_signext_74 = sum37;
  assign add_signext_75 = $signed({{3{product76[30]}}, product76});
  assign add_temp_37 = add_signext_74 + add_signext_75;
  assign sum38 = add_temp_37[33:0];

  assign add_signext_76 = sum38;
  assign add_signext_77 = $signed({{3{product78[30]}}, product78});
  assign add_temp_38 = add_signext_76 + add_signext_77;
  assign sum39 = add_temp_38[33:0];

  assign add_signext_78 = sum39;
  assign add_signext_79 = $signed({{3{product80[30]}}, product80});
  assign add_temp_39 = add_signext_78 + add_signext_79;
  assign sum40 = add_temp_39[33:0];

  assign output_typeconvert = (sum40[31:0] + {sum40[16], {15{~sum40[16]}}})>>>16;

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
endmodule  // halfpass_filter
