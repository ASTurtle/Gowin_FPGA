`timescale 1 ns / 1 ns

module sample_filter
               (
                clk,
                clk_enable,
                reset,
                coeff,
                amplified_filter_in,
                filtered_out
                );

  input   clk; 
  input   clk_enable; 
  input   signed [1023:0] coeff;
  input   reset; 
  input   signed [15:0] amplified_filter_in; //sfix16_En15
  output  signed [15:0] filtered_out; //sfix16_En15

////////////////////////////////////////////////////////////////
//Module Architecture: sample_filter
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
assign   coeff1 = coeff[(16*(65-1)-1):(16*(64-1))];
assign   coeff2 = coeff[(16*(65-2)-1):(16*(64-2))];
assign   coeff3 = coeff[(16*(65-3)-1):(16*(64-3))];
assign   coeff4 = coeff[(16*(65-4)-1):(16*(64-4))];
assign   coeff5 = coeff[(16*(65-5)-1):(16*(64-5))];
assign   coeff6 = coeff[(16*(65-6)-1):(16*(64-6))];
assign   coeff7 = coeff[(16*(65-7)-1):(16*(64-7))];
assign   coeff8 = coeff[(16*(65-8)-1):(16*(64-8))];
assign   coeff9 = coeff[(16*(65-9)-1):(16*(64-9))];
assign   coeff10 = coeff[(16*(65-10)-1):(16*(64-10))];
assign   coeff11 = coeff[(16*(65-11)-1):(16*(64-11))];
assign   coeff12 = coeff[(16*(65-12)-1):(16*(64-12))];
assign   coeff13 = coeff[(16*(65-13)-1):(16*(64-13))];
assign   coeff14 = coeff[(16*(65-14)-1):(16*(64-14))];
assign   coeff15 = coeff[(16*(65-15)-1):(16*(64-15))];
assign   coeff16 = coeff[(16*(65-16)-1):(16*(64-16))];
assign   coeff17 = coeff[(16*(65-17)-1):(16*(64-17))];
assign   coeff18 = coeff[(16*(65-18)-1):(16*(64-18))];
assign   coeff19 = coeff[(16*(65-19)-1):(16*(64-19))];
assign   coeff20 = coeff[(16*(65-20)-1):(16*(64-20))];
assign   coeff21 = coeff[(16*(65-21)-1):(16*(64-21))];
assign   coeff22 = coeff[(16*(65-22)-1):(16*(64-22))];
assign   coeff23 = coeff[(16*(65-23)-1):(16*(64-23))];
assign   coeff24 = coeff[(16*(65-24)-1):(16*(64-24))];
assign   coeff25 = coeff[(16*(65-25)-1):(16*(64-25))];
assign   coeff26 = coeff[(16*(65-26)-1):(16*(64-26))];
assign   coeff27 = coeff[(16*(65-27)-1):(16*(64-27))];
assign   coeff28 = coeff[(16*(65-28)-1):(16*(64-28))];
assign   coeff29 = coeff[(16*(65-29)-1):(16*(64-29))];
assign   coeff30 = coeff[(16*(65-30)-1):(16*(64-30))];
assign   coeff31 = coeff[(16*(65-31)-1):(16*(64-31))];
assign   coeff32 = coeff[(16*(65-32)-1):(16*(64-32))];
assign   coeff33 = coeff[(16*(65-33)-1):(16*(64-33))];
assign   coeff34 = coeff[(16*(65-34)-1):(16*(64-34))];
assign   coeff35 = coeff[(16*(65-35)-1):(16*(64-35))];
assign   coeff36 = coeff[(16*(65-36)-1):(16*(64-36))];
assign   coeff37 = coeff[(16*(65-37)-1):(16*(64-37))];
assign   coeff38 = coeff[(16*(65-38)-1):(16*(64-38))];
assign   coeff39 = coeff[(16*(65-39)-1):(16*(64-39))];
assign   coeff40 = coeff[(16*(65-40)-1):(16*(64-40))];
assign   coeff41 = coeff[(16*(65-41)-1):(16*(64-41))];
assign   coeff42 = coeff[(16*(65-42)-1):(16*(64-42))];
assign   coeff43 = coeff[(16*(65-43)-1):(16*(64-43))];
assign   coeff44 = coeff[(16*(65-44)-1):(16*(64-44))];
assign   coeff45 = coeff[(16*(65-45)-1):(16*(64-45))];
assign   coeff46 = coeff[(16*(65-46)-1):(16*(64-46))];
assign   coeff47 = coeff[(16*(65-47)-1):(16*(64-47))];
assign   coeff48 = coeff[(16*(65-48)-1):(16*(64-48))];
assign   coeff49 = coeff[(16*(65-49)-1):(16*(64-49))];
assign   coeff50 = coeff[(16*(65-50)-1):(16*(64-50))];
assign   coeff51 = coeff[(16*(65-51)-1):(16*(64-51))];
assign   coeff52 = coeff[(16*(65-52)-1):(16*(64-52))];
assign   coeff53 = coeff[(16*(65-53)-1):(16*(64-53))];
assign   coeff54 = coeff[(16*(65-54)-1):(16*(64-54))];
assign   coeff55 = coeff[(16*(65-55)-1):(16*(64-55))];
assign   coeff56 = coeff[(16*(65-56)-1):(16*(64-56))];
assign   coeff57 = coeff[(16*(65-57)-1):(16*(64-57))];
assign   coeff58 = coeff[(16*(65-58)-1):(16*(64-58))];
assign   coeff59 = coeff[(16*(65-59)-1):(16*(64-59))];
assign   coeff60 = coeff[(16*(65-60)-1):(16*(64-60))];
assign   coeff61 = coeff[(16*(65-61)-1):(16*(64-61))];
assign   coeff62 = coeff[(16*(65-62)-1):(16*(64-62))];
assign   coeff63 = coeff[(16*(65-63)-1):(16*(64-63))];
assign   coeff64 = coeff[(16*(65-64)-1):(16*(64-64))];
  // Signals
  reg  signed [15:0] delay_pipeline [0:63] ; // sfix16_En15
  wire signed [31:0] product64; // sfix32_En30
  wire signed [31:0] mul_temp; // sfix32_En32
  wire signed [31:0] product63; // sfix32_En30
  wire signed [31:0] mul_temp_1; // sfix32_En32
  wire signed [31:0] product62; // sfix32_En30
  wire signed [31:0] mul_temp_2; // sfix32_En32
  wire signed [31:0] product61; // sfix32_En30
  wire signed [31:0] mul_temp_3; // sfix32_En32
  wire signed [31:0] product60; // sfix32_En30
  wire signed [31:0] mul_temp_4; // sfix32_En32
  wire signed [31:0] product59; // sfix32_En30
  wire signed [31:0] mul_temp_5; // sfix32_En32
  wire signed [31:0] product58; // sfix32_En30
  wire signed [31:0] mul_temp_6; // sfix32_En32
  wire signed [31:0] product57; // sfix32_En30
  wire signed [31:0] mul_temp_7; // sfix32_En32
  wire signed [31:0] product56; // sfix32_En30
  wire signed [31:0] mul_temp_8; // sfix32_En32
  wire signed [31:0] product55; // sfix32_En30
  wire signed [31:0] mul_temp_9; // sfix32_En32
  wire signed [31:0] product54; // sfix32_En30
  wire signed [31:0] mul_temp_10; // sfix32_En32
  wire signed [31:0] product53; // sfix32_En30
  wire signed [31:0] mul_temp_11; // sfix32_En32
  wire signed [31:0] product52; // sfix32_En30
  wire signed [31:0] mul_temp_12; // sfix32_En32
  wire signed [31:0] product51; // sfix32_En30
  wire signed [31:0] mul_temp_13; // sfix32_En32
  wire signed [31:0] product50; // sfix32_En30
  wire signed [31:0] mul_temp_14; // sfix32_En32
  wire signed [31:0] product49; // sfix32_En30
  wire signed [31:0] mul_temp_15; // sfix32_En32
  wire signed [31:0] product48; // sfix32_En30
  wire signed [31:0] mul_temp_16; // sfix32_En32
  wire signed [31:0] product47; // sfix32_En30
  wire signed [31:0] mul_temp_17; // sfix32_En32
  wire signed [31:0] product46; // sfix32_En30
  wire signed [31:0] mul_temp_18; // sfix32_En32
  wire signed [31:0] product45; // sfix32_En30
  wire signed [31:0] mul_temp_19; // sfix32_En32
  wire signed [31:0] product44; // sfix32_En30
  wire signed [31:0] mul_temp_20; // sfix32_En32
  wire signed [31:0] product43; // sfix32_En30
  wire signed [31:0] mul_temp_21; // sfix32_En32
  wire signed [31:0] product42; // sfix32_En30
  wire signed [31:0] mul_temp_22; // sfix32_En32
  wire signed [31:0] product41; // sfix32_En30
  wire signed [31:0] mul_temp_23; // sfix32_En32
  wire signed [31:0] product40; // sfix32_En30
  wire signed [31:0] mul_temp_24; // sfix32_En32
  wire signed [31:0] product39; // sfix32_En30
  wire signed [31:0] mul_temp_25; // sfix32_En32
  wire signed [31:0] product38; // sfix32_En30
  wire signed [31:0] mul_temp_26; // sfix32_En32
  wire signed [31:0] product37; // sfix32_En30
  wire signed [31:0] mul_temp_27; // sfix32_En32
  wire signed [31:0] product36; // sfix32_En30
  wire signed [31:0] mul_temp_28; // sfix32_En32
  wire signed [31:0] product35; // sfix32_En30
  wire signed [31:0] mul_temp_29; // sfix32_En32
  wire signed [31:0] product34; // sfix32_En30
  wire signed [31:0] mul_temp_30; // sfix32_En32
  wire signed [31:0] product33; // sfix32_En30
  wire signed [31:0] mul_temp_31; // sfix32_En32
  wire signed [31:0] product32; // sfix32_En30
  wire signed [31:0] mul_temp_32; // sfix32_En32
  wire signed [31:0] product31; // sfix32_En30
  wire signed [31:0] mul_temp_33; // sfix32_En32
  wire signed [31:0] product30; // sfix32_En30
  wire signed [31:0] mul_temp_34; // sfix32_En32
  wire signed [31:0] product29; // sfix32_En30
  wire signed [31:0] mul_temp_35; // sfix32_En32
  wire signed [31:0] product28; // sfix32_En30
  wire signed [31:0] mul_temp_36; // sfix32_En32
  wire signed [31:0] product27; // sfix32_En30
  wire signed [31:0] mul_temp_37; // sfix32_En32
  wire signed [31:0] product26; // sfix32_En30
  wire signed [31:0] mul_temp_38; // sfix32_En32
  wire signed [31:0] product25; // sfix32_En30
  wire signed [31:0] mul_temp_39; // sfix32_En32
  wire signed [31:0] product24; // sfix32_En30
  wire signed [31:0] mul_temp_40; // sfix32_En32
  wire signed [31:0] product23; // sfix32_En30
  wire signed [31:0] mul_temp_41; // sfix32_En32
  wire signed [31:0] product22; // sfix32_En30
  wire signed [31:0] mul_temp_42; // sfix32_En32
  wire signed [31:0] product21; // sfix32_En30
  wire signed [31:0] mul_temp_43; // sfix32_En32
  wire signed [31:0] product20; // sfix32_En30
  wire signed [31:0] mul_temp_44; // sfix32_En32
  wire signed [31:0] product19; // sfix32_En30
  wire signed [31:0] mul_temp_45; // sfix32_En32
  wire signed [31:0] product18; // sfix32_En30
  wire signed [31:0] mul_temp_46; // sfix32_En32
  wire signed [31:0] product17; // sfix32_En30
  wire signed [31:0] mul_temp_47; // sfix32_En32
  wire signed [31:0] product16; // sfix32_En30
  wire signed [31:0] mul_temp_48; // sfix32_En32
  wire signed [31:0] product15; // sfix32_En30
  wire signed [31:0] mul_temp_49; // sfix32_En32
  wire signed [31:0] product14; // sfix32_En30
  wire signed [31:0] mul_temp_50; // sfix32_En32
  wire signed [31:0] product13; // sfix32_En30
  wire signed [31:0] mul_temp_51; // sfix32_En32
  wire signed [31:0] product12; // sfix32_En30
  wire signed [31:0] mul_temp_52; // sfix32_En32
  wire signed [31:0] product11; // sfix32_En30
  wire signed [31:0] mul_temp_53; // sfix32_En32
  wire signed [31:0] product10; // sfix32_En30
  wire signed [31:0] mul_temp_54; // sfix32_En32
  wire signed [31:0] product9; // sfix32_En30
  wire signed [31:0] mul_temp_55; // sfix32_En32
  wire signed [31:0] product8; // sfix32_En30
  wire signed [31:0] mul_temp_56; // sfix32_En32
  wire signed [31:0] product7; // sfix32_En30
  wire signed [31:0] mul_temp_57; // sfix32_En32
  wire signed [31:0] product6; // sfix32_En30
  wire signed [31:0] mul_temp_58; // sfix32_En32
  wire signed [31:0] product5; // sfix32_En30
  wire signed [31:0] mul_temp_59; // sfix32_En32
  wire signed [31:0] product4; // sfix32_En30
  wire signed [31:0] mul_temp_60; // sfix32_En32
  wire signed [31:0] product3; // sfix32_En30
  wire signed [31:0] mul_temp_61; // sfix32_En32
  wire signed [31:0] product2; // sfix32_En30
  wire signed [31:0] mul_temp_62; // sfix32_En32
  wire signed [39:0] product1_cast; // sfix40_En30
  wire signed [31:0] product1; // sfix32_En30
  wire signed [31:0] mul_temp_63; // sfix32_En32
  wire signed [39:0] sum1; // sfix40_En30
  wire signed [39:0] add_signext; // sfix40_En30
  wire signed [39:0] add_signext_1; // sfix40_En30
  wire signed [40:0] add_temp; // sfix41_En30
  wire signed [39:0] sum2; // sfix40_En30
  wire signed [39:0] add_signext_2; // sfix40_En30
  wire signed [39:0] add_signext_3; // sfix40_En30
  wire signed [40:0] add_temp_1; // sfix41_En30
  wire signed [39:0] sum3; // sfix40_En30
  wire signed [39:0] add_signext_4; // sfix40_En30
  wire signed [39:0] add_signext_5; // sfix40_En30
  wire signed [40:0] add_temp_2; // sfix41_En30
  wire signed [39:0] sum4; // sfix40_En30
  wire signed [39:0] add_signext_6; // sfix40_En30
  wire signed [39:0] add_signext_7; // sfix40_En30
  wire signed [40:0] add_temp_3; // sfix41_En30
  wire signed [39:0] sum5; // sfix40_En30
  wire signed [39:0] add_signext_8; // sfix40_En30
  wire signed [39:0] add_signext_9; // sfix40_En30
  wire signed [40:0] add_temp_4; // sfix41_En30
  wire signed [39:0] sum6; // sfix40_En30
  wire signed [39:0] add_signext_10; // sfix40_En30
  wire signed [39:0] add_signext_11; // sfix40_En30
  wire signed [40:0] add_temp_5; // sfix41_En30
  wire signed [39:0] sum7; // sfix40_En30
  wire signed [39:0] add_signext_12; // sfix40_En30
  wire signed [39:0] add_signext_13; // sfix40_En30
  wire signed [40:0] add_temp_6; // sfix41_En30
  wire signed [39:0] sum8; // sfix40_En30
  wire signed [39:0] add_signext_14; // sfix40_En30
  wire signed [39:0] add_signext_15; // sfix40_En30
  wire signed [40:0] add_temp_7; // sfix41_En30
  wire signed [39:0] sum9; // sfix40_En30
  wire signed [39:0] add_signext_16; // sfix40_En30
  wire signed [39:0] add_signext_17; // sfix40_En30
  wire signed [40:0] add_temp_8; // sfix41_En30
  wire signed [39:0] sum10; // sfix40_En30
  wire signed [39:0] add_signext_18; // sfix40_En30
  wire signed [39:0] add_signext_19; // sfix40_En30
  wire signed [40:0] add_temp_9; // sfix41_En30
  wire signed [39:0] sum11; // sfix40_En30
  wire signed [39:0] add_signext_20; // sfix40_En30
  wire signed [39:0] add_signext_21; // sfix40_En30
  wire signed [40:0] add_temp_10; // sfix41_En30
  wire signed [39:0] sum12; // sfix40_En30
  wire signed [39:0] add_signext_22; // sfix40_En30
  wire signed [39:0] add_signext_23; // sfix40_En30
  wire signed [40:0] add_temp_11; // sfix41_En30
  wire signed [39:0] sum13; // sfix40_En30
  wire signed [39:0] add_signext_24; // sfix40_En30
  wire signed [39:0] add_signext_25; // sfix40_En30
  wire signed [40:0] add_temp_12; // sfix41_En30
  wire signed [39:0] sum14; // sfix40_En30
  wire signed [39:0] add_signext_26; // sfix40_En30
  wire signed [39:0] add_signext_27; // sfix40_En30
  wire signed [40:0] add_temp_13; // sfix41_En30
  wire signed [39:0] sum15; // sfix40_En30
  wire signed [39:0] add_signext_28; // sfix40_En30
  wire signed [39:0] add_signext_29; // sfix40_En30
  wire signed [40:0] add_temp_14; // sfix41_En30
  wire signed [39:0] sum16; // sfix40_En30
  wire signed [39:0] add_signext_30; // sfix40_En30
  wire signed [39:0] add_signext_31; // sfix40_En30
  wire signed [40:0] add_temp_15; // sfix41_En30
  wire signed [39:0] sum17; // sfix40_En30
  wire signed [39:0] add_signext_32; // sfix40_En30
  wire signed [39:0] add_signext_33; // sfix40_En30
  wire signed [40:0] add_temp_16; // sfix41_En30
  wire signed [39:0] sum18; // sfix40_En30
  wire signed [39:0] add_signext_34; // sfix40_En30
  wire signed [39:0] add_signext_35; // sfix40_En30
  wire signed [40:0] add_temp_17; // sfix41_En30
  wire signed [39:0] sum19; // sfix40_En30
  wire signed [39:0] add_signext_36; // sfix40_En30
  wire signed [39:0] add_signext_37; // sfix40_En30
  wire signed [40:0] add_temp_18; // sfix41_En30
  wire signed [39:0] sum20; // sfix40_En30
  wire signed [39:0] add_signext_38; // sfix40_En30
  wire signed [39:0] add_signext_39; // sfix40_En30
  wire signed [40:0] add_temp_19; // sfix41_En30
  wire signed [39:0] sum21; // sfix40_En30
  wire signed [39:0] add_signext_40; // sfix40_En30
  wire signed [39:0] add_signext_41; // sfix40_En30
  wire signed [40:0] add_temp_20; // sfix41_En30
  wire signed [39:0] sum22; // sfix40_En30
  wire signed [39:0] add_signext_42; // sfix40_En30
  wire signed [39:0] add_signext_43; // sfix40_En30
  wire signed [40:0] add_temp_21; // sfix41_En30
  wire signed [39:0] sum23; // sfix40_En30
  wire signed [39:0] add_signext_44; // sfix40_En30
  wire signed [39:0] add_signext_45; // sfix40_En30
  wire signed [40:0] add_temp_22; // sfix41_En30
  wire signed [39:0] sum24; // sfix40_En30
  wire signed [39:0] add_signext_46; // sfix40_En30
  wire signed [39:0] add_signext_47; // sfix40_En30
  wire signed [40:0] add_temp_23; // sfix41_En30
  wire signed [39:0] sum25; // sfix40_En30
  wire signed [39:0] add_signext_48; // sfix40_En30
  wire signed [39:0] add_signext_49; // sfix40_En30
  wire signed [40:0] add_temp_24; // sfix41_En30
  wire signed [39:0] sum26; // sfix40_En30
  wire signed [39:0] add_signext_50; // sfix40_En30
  wire signed [39:0] add_signext_51; // sfix40_En30
  wire signed [40:0] add_temp_25; // sfix41_En30
  wire signed [39:0] sum27; // sfix40_En30
  wire signed [39:0] add_signext_52; // sfix40_En30
  wire signed [39:0] add_signext_53; // sfix40_En30
  wire signed [40:0] add_temp_26; // sfix41_En30
  wire signed [39:0] sum28; // sfix40_En30
  wire signed [39:0] add_signext_54; // sfix40_En30
  wire signed [39:0] add_signext_55; // sfix40_En30
  wire signed [40:0] add_temp_27; // sfix41_En30
  wire signed [39:0] sum29; // sfix40_En30
  wire signed [39:0] add_signext_56; // sfix40_En30
  wire signed [39:0] add_signext_57; // sfix40_En30
  wire signed [40:0] add_temp_28; // sfix41_En30
  wire signed [39:0] sum30; // sfix40_En30
  wire signed [39:0] add_signext_58; // sfix40_En30
  wire signed [39:0] add_signext_59; // sfix40_En30
  wire signed [40:0] add_temp_29; // sfix41_En30
  wire signed [39:0] sum31; // sfix40_En30
  wire signed [39:0] add_signext_60; // sfix40_En30
  wire signed [39:0] add_signext_61; // sfix40_En30
  wire signed [40:0] add_temp_30; // sfix41_En30
  wire signed [39:0] sum32; // sfix40_En30
  wire signed [39:0] add_signext_62; // sfix40_En30
  wire signed [39:0] add_signext_63; // sfix40_En30
  wire signed [40:0] add_temp_31; // sfix41_En30
  wire signed [39:0] sum33; // sfix40_En30
  wire signed [39:0] add_signext_64; // sfix40_En30
  wire signed [39:0] add_signext_65; // sfix40_En30
  wire signed [40:0] add_temp_32; // sfix41_En30
  wire signed [39:0] sum34; // sfix40_En30
  wire signed [39:0] add_signext_66; // sfix40_En30
  wire signed [39:0] add_signext_67; // sfix40_En30
  wire signed [40:0] add_temp_33; // sfix41_En30
  wire signed [39:0] sum35; // sfix40_En30
  wire signed [39:0] add_signext_68; // sfix40_En30
  wire signed [39:0] add_signext_69; // sfix40_En30
  wire signed [40:0] add_temp_34; // sfix41_En30
  wire signed [39:0] sum36; // sfix40_En30
  wire signed [39:0] add_signext_70; // sfix40_En30
  wire signed [39:0] add_signext_71; // sfix40_En30
  wire signed [40:0] add_temp_35; // sfix41_En30
  wire signed [39:0] sum37; // sfix40_En30
  wire signed [39:0] add_signext_72; // sfix40_En30
  wire signed [39:0] add_signext_73; // sfix40_En30
  wire signed [40:0] add_temp_36; // sfix41_En30
  wire signed [39:0] sum38; // sfix40_En30
  wire signed [39:0] add_signext_74; // sfix40_En30
  wire signed [39:0] add_signext_75; // sfix40_En30
  wire signed [40:0] add_temp_37; // sfix41_En30
  wire signed [39:0] sum39; // sfix40_En30
  wire signed [39:0] add_signext_76; // sfix40_En30
  wire signed [39:0] add_signext_77; // sfix40_En30
  wire signed [40:0] add_temp_38; // sfix41_En30
  wire signed [39:0] sum40; // sfix40_En30
  wire signed [39:0] add_signext_78; // sfix40_En30
  wire signed [39:0] add_signext_79; // sfix40_En30
  wire signed [40:0] add_temp_39; // sfix41_En30
  wire signed [39:0] sum41; // sfix40_En30
  wire signed [39:0] add_signext_80; // sfix40_En30
  wire signed [39:0] add_signext_81; // sfix40_En30
  wire signed [40:0] add_temp_40; // sfix41_En30
  wire signed [39:0] sum42; // sfix40_En30
  wire signed [39:0] add_signext_82; // sfix40_En30
  wire signed [39:0] add_signext_83; // sfix40_En30
  wire signed [40:0] add_temp_41; // sfix41_En30
  wire signed [39:0] sum43; // sfix40_En30
  wire signed [39:0] add_signext_84; // sfix40_En30
  wire signed [39:0] add_signext_85; // sfix40_En30
  wire signed [40:0] add_temp_42; // sfix41_En30
  wire signed [39:0] sum44; // sfix40_En30
  wire signed [39:0] add_signext_86; // sfix40_En30
  wire signed [39:0] add_signext_87; // sfix40_En30
  wire signed [40:0] add_temp_43; // sfix41_En30
  wire signed [39:0] sum45; // sfix40_En30
  wire signed [39:0] add_signext_88; // sfix40_En30
  wire signed [39:0] add_signext_89; // sfix40_En30
  wire signed [40:0] add_temp_44; // sfix41_En30
  wire signed [39:0] sum46; // sfix40_En30
  wire signed [39:0] add_signext_90; // sfix40_En30
  wire signed [39:0] add_signext_91; // sfix40_En30
  wire signed [40:0] add_temp_45; // sfix41_En30
  wire signed [39:0] sum47; // sfix40_En30
  wire signed [39:0] add_signext_92; // sfix40_En30
  wire signed [39:0] add_signext_93; // sfix40_En30
  wire signed [40:0] add_temp_46; // sfix41_En30
  wire signed [39:0] sum48; // sfix40_En30
  wire signed [39:0] add_signext_94; // sfix40_En30
  wire signed [39:0] add_signext_95; // sfix40_En30
  wire signed [40:0] add_temp_47; // sfix41_En30
  wire signed [39:0] sum49; // sfix40_En30
  wire signed [39:0] add_signext_96; // sfix40_En30
  wire signed [39:0] add_signext_97; // sfix40_En30
  wire signed [40:0] add_temp_48; // sfix41_En30
  wire signed [39:0] sum50; // sfix40_En30
  wire signed [39:0] add_signext_98; // sfix40_En30
  wire signed [39:0] add_signext_99; // sfix40_En30
  wire signed [40:0] add_temp_49; // sfix41_En30
  wire signed [39:0] sum51; // sfix40_En30
  wire signed [39:0] add_signext_100; // sfix40_En30
  wire signed [39:0] add_signext_101; // sfix40_En30
  wire signed [40:0] add_temp_50; // sfix41_En30
  wire signed [39:0] sum52; // sfix40_En30
  wire signed [39:0] add_signext_102; // sfix40_En30
  wire signed [39:0] add_signext_103; // sfix40_En30
  wire signed [40:0] add_temp_51; // sfix41_En30
  wire signed [39:0] sum53; // sfix40_En30
  wire signed [39:0] add_signext_104; // sfix40_En30
  wire signed [39:0] add_signext_105; // sfix40_En30
  wire signed [40:0] add_temp_52; // sfix41_En30
  wire signed [39:0] sum54; // sfix40_En30
  wire signed [39:0] add_signext_106; // sfix40_En30
  wire signed [39:0] add_signext_107; // sfix40_En30
  wire signed [40:0] add_temp_53; // sfix41_En30
  wire signed [39:0] sum55; // sfix40_En30
  wire signed [39:0] add_signext_108; // sfix40_En30
  wire signed [39:0] add_signext_109; // sfix40_En30
  wire signed [40:0] add_temp_54; // sfix41_En30
  wire signed [39:0] sum56; // sfix40_En30
  wire signed [39:0] add_signext_110; // sfix40_En30
  wire signed [39:0] add_signext_111; // sfix40_En30
  wire signed [40:0] add_temp_55; // sfix41_En30
  wire signed [39:0] sum57; // sfix40_En30
  wire signed [39:0] add_signext_112; // sfix40_En30
  wire signed [39:0] add_signext_113; // sfix40_En30
  wire signed [40:0] add_temp_56; // sfix41_En30
  wire signed [39:0] sum58; // sfix40_En30
  wire signed [39:0] add_signext_114; // sfix40_En30
  wire signed [39:0] add_signext_115; // sfix40_En30
  wire signed [40:0] add_temp_57; // sfix41_En30
  wire signed [39:0] sum59; // sfix40_En30
  wire signed [39:0] add_signext_116; // sfix40_En30
  wire signed [39:0] add_signext_117; // sfix40_En30
  wire signed [40:0] add_temp_58; // sfix41_En30
  wire signed [39:0] sum60; // sfix40_En30
  wire signed [39:0] add_signext_118; // sfix40_En30
  wire signed [39:0] add_signext_119; // sfix40_En30
  wire signed [40:0] add_temp_59; // sfix41_En30
  wire signed [39:0] sum61; // sfix40_En30
  wire signed [39:0] add_signext_120; // sfix40_En30
  wire signed [39:0] add_signext_121; // sfix40_En30
  wire signed [40:0] add_temp_60; // sfix41_En30
  wire signed [39:0] sum62; // sfix40_En30
  wire signed [39:0] add_signext_122; // sfix40_En30
  wire signed [39:0] add_signext_123; // sfix40_En30
  wire signed [40:0] add_temp_61; // sfix41_En30
  wire signed [39:0] sum63; // sfix40_En30
  wire signed [39:0] add_signext_124; // sfix40_En30
  wire signed [39:0] add_signext_125; // sfix40_En30
  wire signed [40:0] add_temp_62; // sfix41_En30
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
      end
      else begin
        if (clk_enable == 1'b1) begin
          delay_pipeline[0] <= amplified_filter_in;
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
        end
      end
    end // Delay_Pipeline_process


  assign mul_temp = delay_pipeline[63] * coeff64;
  assign product64 = ({{2{mul_temp[31]}}, mul_temp[31:0]} + {mul_temp[2], {1{~mul_temp[2]}}})>>>2;

  assign mul_temp_1 = delay_pipeline[62] * coeff63;
  assign product63 = ({{2{mul_temp_1[31]}}, mul_temp_1[31:0]} + {mul_temp_1[2], {1{~mul_temp_1[2]}}})>>>2;

  assign mul_temp_2 = delay_pipeline[61] * coeff62;
  assign product62 = ({{2{mul_temp_2[31]}}, mul_temp_2[31:0]} + {mul_temp_2[2], {1{~mul_temp_2[2]}}})>>>2;

  assign mul_temp_3 = delay_pipeline[60] * coeff61;
  assign product61 = ({{2{mul_temp_3[31]}}, mul_temp_3[31:0]} + {mul_temp_3[2], {1{~mul_temp_3[2]}}})>>>2;

  assign mul_temp_4 = delay_pipeline[59] * coeff60;
  assign product60 = ({{2{mul_temp_4[31]}}, mul_temp_4[31:0]} + {mul_temp_4[2], {1{~mul_temp_4[2]}}})>>>2;

  assign mul_temp_5 = delay_pipeline[58] * coeff59;
  assign product59 = ({{2{mul_temp_5[31]}}, mul_temp_5[31:0]} + {mul_temp_5[2], {1{~mul_temp_5[2]}}})>>>2;

  assign mul_temp_6 = delay_pipeline[57] * coeff58;
  assign product58 = ({{2{mul_temp_6[31]}}, mul_temp_6[31:0]} + {mul_temp_6[2], {1{~mul_temp_6[2]}}})>>>2;

  assign mul_temp_7 = delay_pipeline[56] * coeff57;
  assign product57 = ({{2{mul_temp_7[31]}}, mul_temp_7[31:0]} + {mul_temp_7[2], {1{~mul_temp_7[2]}}})>>>2;

  assign mul_temp_8 = delay_pipeline[55] * coeff56;
  assign product56 = ({{2{mul_temp_8[31]}}, mul_temp_8[31:0]} + {mul_temp_8[2], {1{~mul_temp_8[2]}}})>>>2;

  assign mul_temp_9 = delay_pipeline[54] * coeff55;
  assign product55 = ({{2{mul_temp_9[31]}}, mul_temp_9[31:0]} + {mul_temp_9[2], {1{~mul_temp_9[2]}}})>>>2;

  assign mul_temp_10 = delay_pipeline[53] * coeff54;
  assign product54 = ({{2{mul_temp_10[31]}}, mul_temp_10[31:0]} + {mul_temp_10[2], {1{~mul_temp_10[2]}}})>>>2;

  assign mul_temp_11 = delay_pipeline[52] * coeff53;
  assign product53 = ({{2{mul_temp_11[31]}}, mul_temp_11[31:0]} + {mul_temp_11[2], {1{~mul_temp_11[2]}}})>>>2;

  assign mul_temp_12 = delay_pipeline[51] * coeff52;
  assign product52 = ({{2{mul_temp_12[31]}}, mul_temp_12[31:0]} + {mul_temp_12[2], {1{~mul_temp_12[2]}}})>>>2;

  assign mul_temp_13 = delay_pipeline[50] * coeff51;
  assign product51 = ({{2{mul_temp_13[31]}}, mul_temp_13[31:0]} + {mul_temp_13[2], {1{~mul_temp_13[2]}}})>>>2;

  assign mul_temp_14 = delay_pipeline[49] * coeff50;
  assign product50 = ({{2{mul_temp_14[31]}}, mul_temp_14[31:0]} + {mul_temp_14[2], {1{~mul_temp_14[2]}}})>>>2;

  assign mul_temp_15 = delay_pipeline[48] * coeff49;
  assign product49 = ({{2{mul_temp_15[31]}}, mul_temp_15[31:0]} + {mul_temp_15[2], {1{~mul_temp_15[2]}}})>>>2;

  assign mul_temp_16 = delay_pipeline[47] * coeff48;
  assign product48 = ({{2{mul_temp_16[31]}}, mul_temp_16[31:0]} + {mul_temp_16[2], {1{~mul_temp_16[2]}}})>>>2;

  assign mul_temp_17 = delay_pipeline[46] * coeff47;
  assign product47 = ({{2{mul_temp_17[31]}}, mul_temp_17[31:0]} + {mul_temp_17[2], {1{~mul_temp_17[2]}}})>>>2;

  assign mul_temp_18 = delay_pipeline[45] * coeff46;
  assign product46 = ({{2{mul_temp_18[31]}}, mul_temp_18[31:0]} + {mul_temp_18[2], {1{~mul_temp_18[2]}}})>>>2;

  assign mul_temp_19 = delay_pipeline[44] * coeff45;
  assign product45 = ({{2{mul_temp_19[31]}}, mul_temp_19[31:0]} + {mul_temp_19[2], {1{~mul_temp_19[2]}}})>>>2;

  assign mul_temp_20 = delay_pipeline[43] * coeff44;
  assign product44 = ({{2{mul_temp_20[31]}}, mul_temp_20[31:0]} + {mul_temp_20[2], {1{~mul_temp_20[2]}}})>>>2;

  assign mul_temp_21 = delay_pipeline[42] * coeff43;
  assign product43 = ({{2{mul_temp_21[31]}}, mul_temp_21[31:0]} + {mul_temp_21[2], {1{~mul_temp_21[2]}}})>>>2;

  assign mul_temp_22 = delay_pipeline[41] * coeff42;
  assign product42 = ({{2{mul_temp_22[31]}}, mul_temp_22[31:0]} + {mul_temp_22[2], {1{~mul_temp_22[2]}}})>>>2;

  assign mul_temp_23 = delay_pipeline[40] * coeff41;
  assign product41 = ({{2{mul_temp_23[31]}}, mul_temp_23[31:0]} + {mul_temp_23[2], {1{~mul_temp_23[2]}}})>>>2;

  assign mul_temp_24 = delay_pipeline[39] * coeff40;
  assign product40 = ({{2{mul_temp_24[31]}}, mul_temp_24[31:0]} + {mul_temp_24[2], {1{~mul_temp_24[2]}}})>>>2;

  assign mul_temp_25 = delay_pipeline[38] * coeff39;
  assign product39 = ({{2{mul_temp_25[31]}}, mul_temp_25[31:0]} + {mul_temp_25[2], {1{~mul_temp_25[2]}}})>>>2;

  assign mul_temp_26 = delay_pipeline[37] * coeff38;
  assign product38 = ({{2{mul_temp_26[31]}}, mul_temp_26[31:0]} + {mul_temp_26[2], {1{~mul_temp_26[2]}}})>>>2;

  assign mul_temp_27 = delay_pipeline[36] * coeff37;
  assign product37 = ({{2{mul_temp_27[31]}}, mul_temp_27[31:0]} + {mul_temp_27[2], {1{~mul_temp_27[2]}}})>>>2;

  assign mul_temp_28 = delay_pipeline[35] * coeff36;
  assign product36 = ({{2{mul_temp_28[31]}}, mul_temp_28[31:0]} + {mul_temp_28[2], {1{~mul_temp_28[2]}}})>>>2;

  assign mul_temp_29 = delay_pipeline[34] * coeff35;
  assign product35 = ({{2{mul_temp_29[31]}}, mul_temp_29[31:0]} + {mul_temp_29[2], {1{~mul_temp_29[2]}}})>>>2;

  assign mul_temp_30 = delay_pipeline[33] * coeff34;
  assign product34 = ({{2{mul_temp_30[31]}}, mul_temp_30[31:0]} + {mul_temp_30[2], {1{~mul_temp_30[2]}}})>>>2;

  assign mul_temp_31 = delay_pipeline[32] * coeff33;
  assign product33 = ({{2{mul_temp_31[31]}}, mul_temp_31[31:0]} + {mul_temp_31[2], {1{~mul_temp_31[2]}}})>>>2;

  assign mul_temp_32 = delay_pipeline[31] * coeff32;
  assign product32 = ({{2{mul_temp_32[31]}}, mul_temp_32[31:0]} + {mul_temp_32[2], {1{~mul_temp_32[2]}}})>>>2;

  assign mul_temp_33 = delay_pipeline[30] * coeff31;
  assign product31 = ({{2{mul_temp_33[31]}}, mul_temp_33[31:0]} + {mul_temp_33[2], {1{~mul_temp_33[2]}}})>>>2;

  assign mul_temp_34 = delay_pipeline[29] * coeff30;
  assign product30 = ({{2{mul_temp_34[31]}}, mul_temp_34[31:0]} + {mul_temp_34[2], {1{~mul_temp_34[2]}}})>>>2;

  assign mul_temp_35 = delay_pipeline[28] * coeff29;
  assign product29 = ({{2{mul_temp_35[31]}}, mul_temp_35[31:0]} + {mul_temp_35[2], {1{~mul_temp_35[2]}}})>>>2;

  assign mul_temp_36 = delay_pipeline[27] * coeff28;
  assign product28 = ({{2{mul_temp_36[31]}}, mul_temp_36[31:0]} + {mul_temp_36[2], {1{~mul_temp_36[2]}}})>>>2;

  assign mul_temp_37 = delay_pipeline[26] * coeff27;
  assign product27 = ({{2{mul_temp_37[31]}}, mul_temp_37[31:0]} + {mul_temp_37[2], {1{~mul_temp_37[2]}}})>>>2;

  assign mul_temp_38 = delay_pipeline[25] * coeff26;
  assign product26 = ({{2{mul_temp_38[31]}}, mul_temp_38[31:0]} + {mul_temp_38[2], {1{~mul_temp_38[2]}}})>>>2;

  assign mul_temp_39 = delay_pipeline[24] * coeff25;
  assign product25 = ({{2{mul_temp_39[31]}}, mul_temp_39[31:0]} + {mul_temp_39[2], {1{~mul_temp_39[2]}}})>>>2;

  assign mul_temp_40 = delay_pipeline[23] * coeff24;
  assign product24 = ({{2{mul_temp_40[31]}}, mul_temp_40[31:0]} + {mul_temp_40[2], {1{~mul_temp_40[2]}}})>>>2;

  assign mul_temp_41 = delay_pipeline[22] * coeff23;
  assign product23 = ({{2{mul_temp_41[31]}}, mul_temp_41[31:0]} + {mul_temp_41[2], {1{~mul_temp_41[2]}}})>>>2;

  assign mul_temp_42 = delay_pipeline[21] * coeff22;
  assign product22 = ({{2{mul_temp_42[31]}}, mul_temp_42[31:0]} + {mul_temp_42[2], {1{~mul_temp_42[2]}}})>>>2;

  assign mul_temp_43 = delay_pipeline[20] * coeff21;
  assign product21 = ({{2{mul_temp_43[31]}}, mul_temp_43[31:0]} + {mul_temp_43[2], {1{~mul_temp_43[2]}}})>>>2;

  assign mul_temp_44 = delay_pipeline[19] * coeff20;
  assign product20 = ({{2{mul_temp_44[31]}}, mul_temp_44[31:0]} + {mul_temp_44[2], {1{~mul_temp_44[2]}}})>>>2;

  assign mul_temp_45 = delay_pipeline[18] * coeff19;
  assign product19 = ({{2{mul_temp_45[31]}}, mul_temp_45[31:0]} + {mul_temp_45[2], {1{~mul_temp_45[2]}}})>>>2;

  assign mul_temp_46 = delay_pipeline[17] * coeff18;
  assign product18 = ({{2{mul_temp_46[31]}}, mul_temp_46[31:0]} + {mul_temp_46[2], {1{~mul_temp_46[2]}}})>>>2;

  assign mul_temp_47 = delay_pipeline[16] * coeff17;
  assign product17 = ({{2{mul_temp_47[31]}}, mul_temp_47[31:0]} + {mul_temp_47[2], {1{~mul_temp_47[2]}}})>>>2;

  assign mul_temp_48 = delay_pipeline[15] * coeff16;
  assign product16 = ({{2{mul_temp_48[31]}}, mul_temp_48[31:0]} + {mul_temp_48[2], {1{~mul_temp_48[2]}}})>>>2;

  assign mul_temp_49 = delay_pipeline[14] * coeff15;
  assign product15 = ({{2{mul_temp_49[31]}}, mul_temp_49[31:0]} + {mul_temp_49[2], {1{~mul_temp_49[2]}}})>>>2;

  assign mul_temp_50 = delay_pipeline[13] * coeff14;
  assign product14 = ({{2{mul_temp_50[31]}}, mul_temp_50[31:0]} + {mul_temp_50[2], {1{~mul_temp_50[2]}}})>>>2;

  assign mul_temp_51 = delay_pipeline[12] * coeff13;
  assign product13 = ({{2{mul_temp_51[31]}}, mul_temp_51[31:0]} + {mul_temp_51[2], {1{~mul_temp_51[2]}}})>>>2;

  assign mul_temp_52 = delay_pipeline[11] * coeff12;
  assign product12 = ({{2{mul_temp_52[31]}}, mul_temp_52[31:0]} + {mul_temp_52[2], {1{~mul_temp_52[2]}}})>>>2;

  assign mul_temp_53 = delay_pipeline[10] * coeff11;
  assign product11 = ({{2{mul_temp_53[31]}}, mul_temp_53[31:0]} + {mul_temp_53[2], {1{~mul_temp_53[2]}}})>>>2;

  assign mul_temp_54 = delay_pipeline[9] * coeff10;
  assign product10 = ({{2{mul_temp_54[31]}}, mul_temp_54[31:0]} + {mul_temp_54[2], {1{~mul_temp_54[2]}}})>>>2;

  assign mul_temp_55 = delay_pipeline[8] * coeff9;
  assign product9 = ({{2{mul_temp_55[31]}}, mul_temp_55[31:0]} + {mul_temp_55[2], {1{~mul_temp_55[2]}}})>>>2;

  assign mul_temp_56 = delay_pipeline[7] * coeff8;
  assign product8 = ({{2{mul_temp_56[31]}}, mul_temp_56[31:0]} + {mul_temp_56[2], {1{~mul_temp_56[2]}}})>>>2;

  assign mul_temp_57 = delay_pipeline[6] * coeff7;
  assign product7 = ({{2{mul_temp_57[31]}}, mul_temp_57[31:0]} + {mul_temp_57[2], {1{~mul_temp_57[2]}}})>>>2;

  assign mul_temp_58 = delay_pipeline[5] * coeff6;
  assign product6 = ({{2{mul_temp_58[31]}}, mul_temp_58[31:0]} + {mul_temp_58[2], {1{~mul_temp_58[2]}}})>>>2;

  assign mul_temp_59 = delay_pipeline[4] * coeff5;
  assign product5 = ({{2{mul_temp_59[31]}}, mul_temp_59[31:0]} + {mul_temp_59[2], {1{~mul_temp_59[2]}}})>>>2;

  assign mul_temp_60 = delay_pipeline[3] * coeff4;
  assign product4 = ({{2{mul_temp_60[31]}}, mul_temp_60[31:0]} + {mul_temp_60[2], {1{~mul_temp_60[2]}}})>>>2;

  assign mul_temp_61 = delay_pipeline[2] * coeff3;
  assign product3 = ({{2{mul_temp_61[31]}}, mul_temp_61[31:0]} + {mul_temp_61[2], {1{~mul_temp_61[2]}}})>>>2;

  assign mul_temp_62 = delay_pipeline[1] * coeff2;
  assign product2 = ({{2{mul_temp_62[31]}}, mul_temp_62[31:0]} + {mul_temp_62[2], {1{~mul_temp_62[2]}}})>>>2;

  assign product1_cast = $signed({{8{product1[31]}}, product1});

  assign mul_temp_63 = delay_pipeline[0] * coeff1;
  assign product1 = ({{2{mul_temp_63[31]}}, mul_temp_63[31:0]} + {mul_temp_63[2], {1{~mul_temp_63[2]}}})>>>2;

  assign add_signext = product1_cast;
  assign add_signext_1 = $signed({{8{product2[31]}}, product2});
  assign add_temp = add_signext + add_signext_1;
  assign sum1 = add_temp[39:0];

  assign add_signext_2 = sum1;
  assign add_signext_3 = $signed({{8{product3[31]}}, product3});
  assign add_temp_1 = add_signext_2 + add_signext_3;
  assign sum2 = add_temp_1[39:0];

  assign add_signext_4 = sum2;
  assign add_signext_5 = $signed({{8{product4[31]}}, product4});
  assign add_temp_2 = add_signext_4 + add_signext_5;
  assign sum3 = add_temp_2[39:0];

  assign add_signext_6 = sum3;
  assign add_signext_7 = $signed({{8{product5[31]}}, product5});
  assign add_temp_3 = add_signext_6 + add_signext_7;
  assign sum4 = add_temp_3[39:0];

  assign add_signext_8 = sum4;
  assign add_signext_9 = $signed({{8{product6[31]}}, product6});
  assign add_temp_4 = add_signext_8 + add_signext_9;
  assign sum5 = add_temp_4[39:0];

  assign add_signext_10 = sum5;
  assign add_signext_11 = $signed({{8{product7[31]}}, product7});
  assign add_temp_5 = add_signext_10 + add_signext_11;
  assign sum6 = add_temp_5[39:0];

  assign add_signext_12 = sum6;
  assign add_signext_13 = $signed({{8{product8[31]}}, product8});
  assign add_temp_6 = add_signext_12 + add_signext_13;
  assign sum7 = add_temp_6[39:0];

  assign add_signext_14 = sum7;
  assign add_signext_15 = $signed({{8{product9[31]}}, product9});
  assign add_temp_7 = add_signext_14 + add_signext_15;
  assign sum8 = add_temp_7[39:0];

  assign add_signext_16 = sum8;
  assign add_signext_17 = $signed({{8{product10[31]}}, product10});
  assign add_temp_8 = add_signext_16 + add_signext_17;
  assign sum9 = add_temp_8[39:0];

  assign add_signext_18 = sum9;
  assign add_signext_19 = $signed({{8{product11[31]}}, product11});
  assign add_temp_9 = add_signext_18 + add_signext_19;
  assign sum10 = add_temp_9[39:0];

  assign add_signext_20 = sum10;
  assign add_signext_21 = $signed({{8{product12[31]}}, product12});
  assign add_temp_10 = add_signext_20 + add_signext_21;
  assign sum11 = add_temp_10[39:0];

  assign add_signext_22 = sum11;
  assign add_signext_23 = $signed({{8{product13[31]}}, product13});
  assign add_temp_11 = add_signext_22 + add_signext_23;
  assign sum12 = add_temp_11[39:0];

  assign add_signext_24 = sum12;
  assign add_signext_25 = $signed({{8{product14[31]}}, product14});
  assign add_temp_12 = add_signext_24 + add_signext_25;
  assign sum13 = add_temp_12[39:0];

  assign add_signext_26 = sum13;
  assign add_signext_27 = $signed({{8{product15[31]}}, product15});
  assign add_temp_13 = add_signext_26 + add_signext_27;
  assign sum14 = add_temp_13[39:0];

  assign add_signext_28 = sum14;
  assign add_signext_29 = $signed({{8{product16[31]}}, product16});
  assign add_temp_14 = add_signext_28 + add_signext_29;
  assign sum15 = add_temp_14[39:0];

  assign add_signext_30 = sum15;
  assign add_signext_31 = $signed({{8{product17[31]}}, product17});
  assign add_temp_15 = add_signext_30 + add_signext_31;
  assign sum16 = add_temp_15[39:0];

  assign add_signext_32 = sum16;
  assign add_signext_33 = $signed({{8{product18[31]}}, product18});
  assign add_temp_16 = add_signext_32 + add_signext_33;
  assign sum17 = add_temp_16[39:0];

  assign add_signext_34 = sum17;
  assign add_signext_35 = $signed({{8{product19[31]}}, product19});
  assign add_temp_17 = add_signext_34 + add_signext_35;
  assign sum18 = add_temp_17[39:0];

  assign add_signext_36 = sum18;
  assign add_signext_37 = $signed({{8{product20[31]}}, product20});
  assign add_temp_18 = add_signext_36 + add_signext_37;
  assign sum19 = add_temp_18[39:0];

  assign add_signext_38 = sum19;
  assign add_signext_39 = $signed({{8{product21[31]}}, product21});
  assign add_temp_19 = add_signext_38 + add_signext_39;
  assign sum20 = add_temp_19[39:0];

  assign add_signext_40 = sum20;
  assign add_signext_41 = $signed({{8{product22[31]}}, product22});
  assign add_temp_20 = add_signext_40 + add_signext_41;
  assign sum21 = add_temp_20[39:0];

  assign add_signext_42 = sum21;
  assign add_signext_43 = $signed({{8{product23[31]}}, product23});
  assign add_temp_21 = add_signext_42 + add_signext_43;
  assign sum22 = add_temp_21[39:0];

  assign add_signext_44 = sum22;
  assign add_signext_45 = $signed({{8{product24[31]}}, product24});
  assign add_temp_22 = add_signext_44 + add_signext_45;
  assign sum23 = add_temp_22[39:0];

  assign add_signext_46 = sum23;
  assign add_signext_47 = $signed({{8{product25[31]}}, product25});
  assign add_temp_23 = add_signext_46 + add_signext_47;
  assign sum24 = add_temp_23[39:0];

  assign add_signext_48 = sum24;
  assign add_signext_49 = $signed({{8{product26[31]}}, product26});
  assign add_temp_24 = add_signext_48 + add_signext_49;
  assign sum25 = add_temp_24[39:0];

  assign add_signext_50 = sum25;
  assign add_signext_51 = $signed({{8{product27[31]}}, product27});
  assign add_temp_25 = add_signext_50 + add_signext_51;
  assign sum26 = add_temp_25[39:0];

  assign add_signext_52 = sum26;
  assign add_signext_53 = $signed({{8{product28[31]}}, product28});
  assign add_temp_26 = add_signext_52 + add_signext_53;
  assign sum27 = add_temp_26[39:0];

  assign add_signext_54 = sum27;
  assign add_signext_55 = $signed({{8{product29[31]}}, product29});
  assign add_temp_27 = add_signext_54 + add_signext_55;
  assign sum28 = add_temp_27[39:0];

  assign add_signext_56 = sum28;
  assign add_signext_57 = $signed({{8{product30[31]}}, product30});
  assign add_temp_28 = add_signext_56 + add_signext_57;
  assign sum29 = add_temp_28[39:0];

  assign add_signext_58 = sum29;
  assign add_signext_59 = $signed({{8{product31[31]}}, product31});
  assign add_temp_29 = add_signext_58 + add_signext_59;
  assign sum30 = add_temp_29[39:0];

  assign add_signext_60 = sum30;
  assign add_signext_61 = $signed({{8{product32[31]}}, product32});
  assign add_temp_30 = add_signext_60 + add_signext_61;
  assign sum31 = add_temp_30[39:0];

  assign add_signext_62 = sum31;
  assign add_signext_63 = $signed({{8{product33[31]}}, product33});
  assign add_temp_31 = add_signext_62 + add_signext_63;
  assign sum32 = add_temp_31[39:0];

  assign add_signext_64 = sum32;
  assign add_signext_65 = $signed({{8{product34[31]}}, product34});
  assign add_temp_32 = add_signext_64 + add_signext_65;
  assign sum33 = add_temp_32[39:0];

  assign add_signext_66 = sum33;
  assign add_signext_67 = $signed({{8{product35[31]}}, product35});
  assign add_temp_33 = add_signext_66 + add_signext_67;
  assign sum34 = add_temp_33[39:0];

  assign add_signext_68 = sum34;
  assign add_signext_69 = $signed({{8{product36[31]}}, product36});
  assign add_temp_34 = add_signext_68 + add_signext_69;
  assign sum35 = add_temp_34[39:0];

  assign add_signext_70 = sum35;
  assign add_signext_71 = $signed({{8{product37[31]}}, product37});
  assign add_temp_35 = add_signext_70 + add_signext_71;
  assign sum36 = add_temp_35[39:0];

  assign add_signext_72 = sum36;
  assign add_signext_73 = $signed({{8{product38[31]}}, product38});
  assign add_temp_36 = add_signext_72 + add_signext_73;
  assign sum37 = add_temp_36[39:0];

  assign add_signext_74 = sum37;
  assign add_signext_75 = $signed({{8{product39[31]}}, product39});
  assign add_temp_37 = add_signext_74 + add_signext_75;
  assign sum38 = add_temp_37[39:0];

  assign add_signext_76 = sum38;
  assign add_signext_77 = $signed({{8{product40[31]}}, product40});
  assign add_temp_38 = add_signext_76 + add_signext_77;
  assign sum39 = add_temp_38[39:0];

  assign add_signext_78 = sum39;
  assign add_signext_79 = $signed({{8{product41[31]}}, product41});
  assign add_temp_39 = add_signext_78 + add_signext_79;
  assign sum40 = add_temp_39[39:0];

  assign add_signext_80 = sum40;
  assign add_signext_81 = $signed({{8{product42[31]}}, product42});
  assign add_temp_40 = add_signext_80 + add_signext_81;
  assign sum41 = add_temp_40[39:0];

  assign add_signext_82 = sum41;
  assign add_signext_83 = $signed({{8{product43[31]}}, product43});
  assign add_temp_41 = add_signext_82 + add_signext_83;
  assign sum42 = add_temp_41[39:0];

  assign add_signext_84 = sum42;
  assign add_signext_85 = $signed({{8{product44[31]}}, product44});
  assign add_temp_42 = add_signext_84 + add_signext_85;
  assign sum43 = add_temp_42[39:0];

  assign add_signext_86 = sum43;
  assign add_signext_87 = $signed({{8{product45[31]}}, product45});
  assign add_temp_43 = add_signext_86 + add_signext_87;
  assign sum44 = add_temp_43[39:0];

  assign add_signext_88 = sum44;
  assign add_signext_89 = $signed({{8{product46[31]}}, product46});
  assign add_temp_44 = add_signext_88 + add_signext_89;
  assign sum45 = add_temp_44[39:0];

  assign add_signext_90 = sum45;
  assign add_signext_91 = $signed({{8{product47[31]}}, product47});
  assign add_temp_45 = add_signext_90 + add_signext_91;
  assign sum46 = add_temp_45[39:0];

  assign add_signext_92 = sum46;
  assign add_signext_93 = $signed({{8{product48[31]}}, product48});
  assign add_temp_46 = add_signext_92 + add_signext_93;
  assign sum47 = add_temp_46[39:0];

  assign add_signext_94 = sum47;
  assign add_signext_95 = $signed({{8{product49[31]}}, product49});
  assign add_temp_47 = add_signext_94 + add_signext_95;
  assign sum48 = add_temp_47[39:0];

  assign add_signext_96 = sum48;
  assign add_signext_97 = $signed({{8{product50[31]}}, product50});
  assign add_temp_48 = add_signext_96 + add_signext_97;
  assign sum49 = add_temp_48[39:0];

  assign add_signext_98 = sum49;
  assign add_signext_99 = $signed({{8{product51[31]}}, product51});
  assign add_temp_49 = add_signext_98 + add_signext_99;
  assign sum50 = add_temp_49[39:0];

  assign add_signext_100 = sum50;
  assign add_signext_101 = $signed({{8{product52[31]}}, product52});
  assign add_temp_50 = add_signext_100 + add_signext_101;
  assign sum51 = add_temp_50[39:0];

  assign add_signext_102 = sum51;
  assign add_signext_103 = $signed({{8{product53[31]}}, product53});
  assign add_temp_51 = add_signext_102 + add_signext_103;
  assign sum52 = add_temp_51[39:0];

  assign add_signext_104 = sum52;
  assign add_signext_105 = $signed({{8{product54[31]}}, product54});
  assign add_temp_52 = add_signext_104 + add_signext_105;
  assign sum53 = add_temp_52[39:0];

  assign add_signext_106 = sum53;
  assign add_signext_107 = $signed({{8{product55[31]}}, product55});
  assign add_temp_53 = add_signext_106 + add_signext_107;
  assign sum54 = add_temp_53[39:0];

  assign add_signext_108 = sum54;
  assign add_signext_109 = $signed({{8{product56[31]}}, product56});
  assign add_temp_54 = add_signext_108 + add_signext_109;
  assign sum55 = add_temp_54[39:0];

  assign add_signext_110 = sum55;
  assign add_signext_111 = $signed({{8{product57[31]}}, product57});
  assign add_temp_55 = add_signext_110 + add_signext_111;
  assign sum56 = add_temp_55[39:0];

  assign add_signext_112 = sum56;
  assign add_signext_113 = $signed({{8{product58[31]}}, product58});
  assign add_temp_56 = add_signext_112 + add_signext_113;
  assign sum57 = add_temp_56[39:0];

  assign add_signext_114 = sum57;
  assign add_signext_115 = $signed({{8{product59[31]}}, product59});
  assign add_temp_57 = add_signext_114 + add_signext_115;
  assign sum58 = add_temp_57[39:0];

  assign add_signext_116 = sum58;
  assign add_signext_117 = $signed({{8{product60[31]}}, product60});
  assign add_temp_58 = add_signext_116 + add_signext_117;
  assign sum59 = add_temp_58[39:0];

  assign add_signext_118 = sum59;
  assign add_signext_119 = $signed({{8{product61[31]}}, product61});
  assign add_temp_59 = add_signext_118 + add_signext_119;
  assign sum60 = add_temp_59[39:0];

  assign add_signext_120 = sum60;
  assign add_signext_121 = $signed({{8{product62[31]}}, product62});
  assign add_temp_60 = add_signext_120 + add_signext_121;
  assign sum61 = add_temp_60[39:0];

  assign add_signext_122 = sum61;
  assign add_signext_123 = $signed({{8{product63[31]}}, product63});
  assign add_temp_61 = add_signext_122 + add_signext_123;
  assign sum62 = add_temp_61[39:0];

  assign add_signext_124 = sum62;
  assign add_signext_125 = $signed({{8{product64[31]}}, product64});
  assign add_temp_62 = add_signext_124 + add_signext_125;
  assign sum63 = add_temp_62[39:0];

  assign output_typeconvert = (sum63[30:0] + {sum63[15], {14{~sum63[15]}}})>>>15;

  always @ (posedge clk or posedge reset)
    begin: Output_Register_process
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          output_register <= output_typeconvert;
        end
      end
    end // // Output_Register_process

  // Assignment Statements
  assign filtered_out = output_register;
endmodule  // filter_0
