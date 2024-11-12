`timescale 1ns/100ps


module echo_sim_tb();
reg clk;
reg rst_n;
reg WrEn,RdEn;
reg [31:0] audio_in;
wire [31:0] audio_out; 
wire almost_full,almost_empty,fifoFull,fifoEmpty;
wire WrAck; 
reg [7:0] wave_form_sin[255:0];
reg [11:0] delay_num;
reg [7:0] i; 



initial begin
		clk <= 1'b0;
		rst_n <= 1'b0;
        i  <=  0;
        delay_num <= 12'd127;
		#201
		rst_n = 1'b1;

     
		
end

initial begin
wave_form_sin[0]   <= 127;wave_form_sin[1]   <= 130;wave_form_sin[2]   <= 133;wave_form_sin[3]   <= 136;wave_form_sin[4]   <= 139;wave_form_sin[5]   <= 143;wave_form_sin[6]   <= 146;wave_form_sin[7]   <= 149;
wave_form_sin[8]   <= 152;wave_form_sin[9]   <= 155;wave_form_sin[10]  <= 158;wave_form_sin[11]  <= 161;wave_form_sin[12]  <= 164;wave_form_sin[13]  <= 167;wave_form_sin[14]  <= 170;wave_form_sin[15]  <= 173;
wave_form_sin[16]  <= 176;wave_form_sin[17]  <= 178;wave_form_sin[18]  <= 181;wave_form_sin[19]  <= 184;wave_form_sin[20]  <= 187;wave_form_sin[21]  <= 190;wave_form_sin[22]  <= 192;wave_form_sin[23]  <= 195;
wave_form_sin[24]  <= 198;wave_form_sin[25]  <= 200;wave_form_sin[26]  <= 203;wave_form_sin[27]  <= 205;wave_form_sin[28]  <= 208;wave_form_sin[29]  <= 210;wave_form_sin[30]  <= 212;wave_form_sin[31]  <= 215;
wave_form_sin[32]  <= 217;wave_form_sin[33]  <= 219;wave_form_sin[34]  <= 221;wave_form_sin[35]  <= 223;wave_form_sin[36]  <= 225;wave_form_sin[37]  <= 227;wave_form_sin[38]  <= 229;wave_form_sin[39]  <= 231;
wave_form_sin[40]  <= 233;wave_form_sin[41]  <= 234;wave_form_sin[42]  <= 236;wave_form_sin[43]  <= 238;wave_form_sin[44]  <= 239;wave_form_sin[45]  <= 240;wave_form_sin[46]  <= 242;wave_form_sin[47]  <= 243;
wave_form_sin[48]  <= 244;wave_form_sin[49]  <= 245;wave_form_sin[50]  <= 247;wave_form_sin[51]  <= 248;wave_form_sin[52]  <= 249;wave_form_sin[53]  <= 249;wave_form_sin[54]  <= 250;wave_form_sin[55]  <= 251;
wave_form_sin[56]  <= 252;wave_form_sin[57]  <= 252;wave_form_sin[58]  <= 253;wave_form_sin[59]  <= 253;wave_form_sin[60]  <= 253;wave_form_sin[61]  <= 254;wave_form_sin[62]  <= 254;wave_form_sin[63]  <= 254;
wave_form_sin[64]  <= 254;wave_form_sin[65]  <= 254;wave_form_sin[66]  <= 254;wave_form_sin[67]  <= 254;wave_form_sin[68]  <= 253;wave_form_sin[69]  <= 253;wave_form_sin[70]  <= 253;wave_form_sin[71]  <= 252;
wave_form_sin[72]  <= 252;wave_form_sin[73]  <= 251;wave_form_sin[74]  <= 250;wave_form_sin[75]  <= 249;wave_form_sin[76]  <= 249;wave_form_sin[77]  <= 248;wave_form_sin[78]  <= 247;wave_form_sin[79]  <= 245;
wave_form_sin[80]  <= 244;wave_form_sin[81]  <= 243;wave_form_sin[82]  <= 242;wave_form_sin[83]  <= 240;wave_form_sin[84]  <= 239;wave_form_sin[85]  <= 238;wave_form_sin[86]  <= 236;wave_form_sin[87]  <= 234;
wave_form_sin[88]  <= 233;wave_form_sin[89]  <= 231;wave_form_sin[90]  <= 229;wave_form_sin[91]  <= 227;wave_form_sin[92]  <= 225;wave_form_sin[93]  <= 223;wave_form_sin[94]  <= 221;wave_form_sin[95]  <= 219;
wave_form_sin[96]  <= 217;wave_form_sin[97]  <= 215;wave_form_sin[98]  <= 212;wave_form_sin[99]  <= 210;wave_form_sin[100] <= 208;wave_form_sin[101] <= 205;wave_form_sin[102] <= 203;wave_form_sin[103] <= 200;
wave_form_sin[104] <= 198;wave_form_sin[105] <= 195;wave_form_sin[106] <= 192;wave_form_sin[107] <= 190;wave_form_sin[108] <= 187;wave_form_sin[109] <= 184;wave_form_sin[110] <= 181;wave_form_sin[111] <= 178;
wave_form_sin[112] <= 176;wave_form_sin[113] <= 173;wave_form_sin[114] <= 170;wave_form_sin[115] <= 167;wave_form_sin[116] <= 164;wave_form_sin[117] <= 161;wave_form_sin[118] <= 158;wave_form_sin[119] <= 155;
wave_form_sin[120] <= 152;wave_form_sin[121] <= 149;wave_form_sin[122] <= 146;wave_form_sin[123] <= 143;wave_form_sin[124] <= 139;wave_form_sin[125] <= 136;wave_form_sin[126] <= 133;wave_form_sin[127] <= 130;
wave_form_sin[128] <= 127;wave_form_sin[129] <= 124;wave_form_sin[130] <= 121;wave_form_sin[131] <= 118;wave_form_sin[132] <= 115;wave_form_sin[133] <= 111;wave_form_sin[134] <= 108;wave_form_sin[135] <= 105;
wave_form_sin[136] <= 102;wave_form_sin[137] <=  99;wave_form_sin[138] <=  96;wave_form_sin[139] <=  93;wave_form_sin[140] <=  90;wave_form_sin[141] <=  87;wave_form_sin[142] <=  84;wave_form_sin[143] <=  81;
wave_form_sin[144] <=  78;wave_form_sin[145] <=  76;wave_form_sin[146] <=  73;wave_form_sin[147] <=  70;wave_form_sin[148] <=  67;wave_form_sin[149] <=  64;wave_form_sin[150] <=  62;wave_form_sin[151] <=  59;
wave_form_sin[152] <=  56;wave_form_sin[153] <=  54;wave_form_sin[154] <=  51;wave_form_sin[155] <=  49;wave_form_sin[156] <=  46;wave_form_sin[157] <=  44;wave_form_sin[158] <=  42;wave_form_sin[159] <=  39;
wave_form_sin[160] <=  37;wave_form_sin[161] <=  35;wave_form_sin[162] <=  33;wave_form_sin[163] <=  31;wave_form_sin[164] <=  29;wave_form_sin[165] <=  27;wave_form_sin[166] <=  25;wave_form_sin[167] <=  23;
wave_form_sin[168] <=  21;wave_form_sin[169] <=  20;wave_form_sin[170] <=  18;wave_form_sin[171] <=  16;wave_form_sin[172] <=  15;wave_form_sin[173] <=  14;wave_form_sin[174] <=  12;wave_form_sin[175] <=  11;
wave_form_sin[176] <=  10;wave_form_sin[177] <=   9;wave_form_sin[178] <=   7;wave_form_sin[179] <=   6;wave_form_sin[180] <=   5;wave_form_sin[181] <=   5;wave_form_sin[182] <=   4;wave_form_sin[183] <=   3;
wave_form_sin[184] <=   2;wave_form_sin[185] <=   2;wave_form_sin[186] <=   1;wave_form_sin[187] <=   1;wave_form_sin[188] <=   1;wave_form_sin[189] <=   0;wave_form_sin[190] <=   0;wave_form_sin[191] <=   0;
wave_form_sin[192] <=   0;wave_form_sin[193] <=   0;wave_form_sin[194] <=   0;wave_form_sin[195] <=   0;wave_form_sin[196] <=   1;wave_form_sin[197] <=   1;wave_form_sin[198] <=   1;wave_form_sin[199] <=   2;
wave_form_sin[200] <=   2;wave_form_sin[201] <=   3;wave_form_sin[202] <=   4;wave_form_sin[203] <=   5;wave_form_sin[204] <=   5;wave_form_sin[205] <=   6;wave_form_sin[206] <=   7;wave_form_sin[207] <=   9;
wave_form_sin[208] <=  10;wave_form_sin[209] <=  11;wave_form_sin[210] <=  12;wave_form_sin[211] <=  14;wave_form_sin[212] <=  15;wave_form_sin[213] <=  16;wave_form_sin[214] <=  18;wave_form_sin[215] <=  20;
wave_form_sin[216] <=  21;wave_form_sin[217] <=  23;wave_form_sin[218] <=  25;wave_form_sin[219] <=  27;wave_form_sin[220] <=  29;wave_form_sin[221] <=  31;wave_form_sin[222] <=  33;wave_form_sin[223] <=  35;
wave_form_sin[224] <=  37;wave_form_sin[225] <=  39;wave_form_sin[226] <=  42;wave_form_sin[227] <=  44;wave_form_sin[228] <=  46;wave_form_sin[229] <=  49;wave_form_sin[230] <=  51;wave_form_sin[231] <=  54;
wave_form_sin[232] <=  56;wave_form_sin[233] <=  59;wave_form_sin[234] <=  62;wave_form_sin[235] <=  64;wave_form_sin[236] <=  67;wave_form_sin[237] <=  70;wave_form_sin[238] <=  73;wave_form_sin[239] <=  76;
wave_form_sin[240] <=  78;wave_form_sin[241] <=  81;wave_form_sin[242] <=  84;wave_form_sin[243] <=  87;wave_form_sin[244] <=  90;wave_form_sin[245] <=  93;wave_form_sin[246] <=  96;wave_form_sin[247] <=  99;
wave_form_sin[248] <= 102;wave_form_sin[249] <= 105;wave_form_sin[250] <= 108;wave_form_sin[251] <= 111;wave_form_sin[252] <= 115;wave_form_sin[253] <= 118;wave_form_sin[254] <= 121;wave_form_sin[255] <= 124;
      
end

always #10 clk = ~clk;

always @(posedge clk) begin
    audio_in[7:0] <= wave_form_sin[i];
    audio_in[31:8] <= 0;
    i <= i+1;
    
end
// echo sim_echo
// (
//     .clk(clk),
//     .reset_n(rst_n),
//     .gain(6'd5 ),
//     .audio_data_0(audio_in),
//     .echo_data(audio_out),
//     .Almost_Full(almost_full),
//     .Almost_Empty(almost_empty)
// );

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        WrEn <=  0;
        RdEn <= 0;
    end
    else begin
        WrEn <= 1;
        if(almost_full) begin
            RdEn <= 1;
        end
        else begin
            RdEn <= 0;
        end
    end

end

/*用高云fifo ip核实现延???*/
delay_fifo my_audio_delay1(
		.Data(audio_in), //input [31:0] Data
		.WrClk(clk), //input WrClk
		.RdClk(clk), //input RdClk
		.WrEn(WrEn), //input WrEn
		.RdEn(RdEn), //input RdEn
		.AlmostEmptyTh(delay_num), //input [11:0] AlmostEmptyTh
		.AlmostFullTh(delay_num), //input [11:0] AlmostFullTh
		//.Wnum(Wnum), //output [12:0] Wnum
		//.Rnum(Rnum), //output [12:0] Rnum
		.Almost_Empty(Almost_Empty), //output Almost_Empty
		.Almost_Full(Almost_Full), //output Almost_Full
		.Q(audio_out), //output [31:0] Q
		.Empty(fifoEmpty), //output Empty
		.Full(fifoFull) //output Full
	);
// fifo_generator_0 my_audio_delay1 (
//   .clk(clk),                    // input wire clk
//   .srst(~rst_n),                  // input wire srst
//   .din(audio_in),                    // input wire [31 : 0] din
//   .wr_en(WrEn),                // input wire wr_en
//   .rd_en(RdEn),                // input wire rd_en
//   .dout(audio_out),                  // output wire [31 : 0] dout
//   .full(fifoFull),                  // output wire full
//   .almost_full(almost_full),    // output wire almost_full
//   .wr_ack(Wr_Ack),              // output wire wr_ack
//   .empty(fifoEmpty),                // output wire empty
//   .almost_empty(almost_empty)  // output wire almost_empty
//   //.valid(valid),                // output wire valid
//   //.prog_full(prog_full),        // output wire prog_full
//   //.prog_empty(prog_empty)      // output wire prog_empty
// );

endmodule