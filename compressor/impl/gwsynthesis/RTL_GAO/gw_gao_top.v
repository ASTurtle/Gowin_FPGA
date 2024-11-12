module gw_gao(
    \i2s_tx/dacfifo_wrclk ,
    clk,
    I2S_BCLK,
    I2S_MCLK,
    dacfifo_write,
    \compressor_in_0[15] ,
    \compressor_in_0[14] ,
    \compressor_in_0[13] ,
    \compressor_in_0[12] ,
    \compressor_in_0[11] ,
    \compressor_in_0[10] ,
    \compressor_in_0[9] ,
    \compressor_in_0[8] ,
    \compressor_in_0[7] ,
    \compressor_in_0[6] ,
    \compressor_in_0[5] ,
    \compressor_in_0[4] ,
    \compressor_in_0[3] ,
    \compressor_in_0[2] ,
    \compressor_in_0[1] ,
    \compressor_in_0[0] ,
    \compressor_out_0[15] ,
    \compressor_out_0[14] ,
    \compressor_out_0[13] ,
    \compressor_out_0[12] ,
    \compressor_out_0[11] ,
    \compressor_out_0[10] ,
    \compressor_out_0[9] ,
    \compressor_out_0[8] ,
    \compressor_out_0[7] ,
    \compressor_out_0[6] ,
    \compressor_out_0[5] ,
    \compressor_out_0[4] ,
    \compressor_out_0[3] ,
    \compressor_out_0[2] ,
    \compressor_out_0[1] ,
    \compressor_out_0[0] ,
    \compressor_0/gain[15] ,
    \compressor_0/gain[14] ,
    \compressor_0/gain[13] ,
    \compressor_0/gain[12] ,
    \compressor_0/gain[11] ,
    \compressor_0/gain[10] ,
    \compressor_0/gain[9] ,
    \compressor_0/gain[8] ,
    \compressor_0/gain[7] ,
    \compressor_0/gain[6] ,
    \compressor_0/gain[5] ,
    \compressor_0/gain[4] ,
    \compressor_0/gain[3] ,
    \compressor_0/gain[2] ,
    \compressor_0/gain[1] ,
    \compressor_0/gain[0] ,
    \compressor_0/compression_active ,
    \compressor_0/attack_counter[15] ,
    \compressor_0/attack_counter[14] ,
    \compressor_0/attack_counter[13] ,
    \compressor_0/attack_counter[12] ,
    \compressor_0/attack_counter[11] ,
    \compressor_0/attack_counter[10] ,
    \compressor_0/attack_counter[9] ,
    \compressor_0/attack_counter[8] ,
    \compressor_0/attack_counter[7] ,
    \compressor_0/attack_counter[6] ,
    \compressor_0/attack_counter[5] ,
    \compressor_0/attack_counter[4] ,
    \compressor_0/attack_counter[3] ,
    \compressor_0/attack_counter[2] ,
    \compressor_0/attack_counter[1] ,
    \compressor_0/attack_counter[0] ,
    \compressor_0/release_counter[15] ,
    \compressor_0/release_counter[14] ,
    \compressor_0/release_counter[13] ,
    \compressor_0/release_counter[12] ,
    \compressor_0/release_counter[11] ,
    \compressor_0/release_counter[10] ,
    \compressor_0/release_counter[9] ,
    \compressor_0/release_counter[8] ,
    \compressor_0/release_counter[7] ,
    \compressor_0/release_counter[6] ,
    \compressor_0/release_counter[5] ,
    \compressor_0/release_counter[4] ,
    \compressor_0/release_counter[3] ,
    \compressor_0/release_counter[2] ,
    \compressor_0/release_counter[1] ,
    \compressor_0/release_counter[0] ,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \i2s_tx/dacfifo_wrclk ;
input clk;
input I2S_BCLK;
input I2S_MCLK;
input dacfifo_write;
input \compressor_in_0[15] ;
input \compressor_in_0[14] ;
input \compressor_in_0[13] ;
input \compressor_in_0[12] ;
input \compressor_in_0[11] ;
input \compressor_in_0[10] ;
input \compressor_in_0[9] ;
input \compressor_in_0[8] ;
input \compressor_in_0[7] ;
input \compressor_in_0[6] ;
input \compressor_in_0[5] ;
input \compressor_in_0[4] ;
input \compressor_in_0[3] ;
input \compressor_in_0[2] ;
input \compressor_in_0[1] ;
input \compressor_in_0[0] ;
input \compressor_out_0[15] ;
input \compressor_out_0[14] ;
input \compressor_out_0[13] ;
input \compressor_out_0[12] ;
input \compressor_out_0[11] ;
input \compressor_out_0[10] ;
input \compressor_out_0[9] ;
input \compressor_out_0[8] ;
input \compressor_out_0[7] ;
input \compressor_out_0[6] ;
input \compressor_out_0[5] ;
input \compressor_out_0[4] ;
input \compressor_out_0[3] ;
input \compressor_out_0[2] ;
input \compressor_out_0[1] ;
input \compressor_out_0[0] ;
input \compressor_0/gain[15] ;
input \compressor_0/gain[14] ;
input \compressor_0/gain[13] ;
input \compressor_0/gain[12] ;
input \compressor_0/gain[11] ;
input \compressor_0/gain[10] ;
input \compressor_0/gain[9] ;
input \compressor_0/gain[8] ;
input \compressor_0/gain[7] ;
input \compressor_0/gain[6] ;
input \compressor_0/gain[5] ;
input \compressor_0/gain[4] ;
input \compressor_0/gain[3] ;
input \compressor_0/gain[2] ;
input \compressor_0/gain[1] ;
input \compressor_0/gain[0] ;
input \compressor_0/compression_active ;
input \compressor_0/attack_counter[15] ;
input \compressor_0/attack_counter[14] ;
input \compressor_0/attack_counter[13] ;
input \compressor_0/attack_counter[12] ;
input \compressor_0/attack_counter[11] ;
input \compressor_0/attack_counter[10] ;
input \compressor_0/attack_counter[9] ;
input \compressor_0/attack_counter[8] ;
input \compressor_0/attack_counter[7] ;
input \compressor_0/attack_counter[6] ;
input \compressor_0/attack_counter[5] ;
input \compressor_0/attack_counter[4] ;
input \compressor_0/attack_counter[3] ;
input \compressor_0/attack_counter[2] ;
input \compressor_0/attack_counter[1] ;
input \compressor_0/attack_counter[0] ;
input \compressor_0/release_counter[15] ;
input \compressor_0/release_counter[14] ;
input \compressor_0/release_counter[13] ;
input \compressor_0/release_counter[12] ;
input \compressor_0/release_counter[11] ;
input \compressor_0/release_counter[10] ;
input \compressor_0/release_counter[9] ;
input \compressor_0/release_counter[8] ;
input \compressor_0/release_counter[7] ;
input \compressor_0/release_counter[6] ;
input \compressor_0/release_counter[5] ;
input \compressor_0/release_counter[4] ;
input \compressor_0/release_counter[3] ;
input \compressor_0/release_counter[2] ;
input \compressor_0/release_counter[1] ;
input \compressor_0/release_counter[0] ;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \i2s_tx/dacfifo_wrclk ;
wire clk;
wire I2S_BCLK;
wire I2S_MCLK;
wire dacfifo_write;
wire \compressor_in_0[15] ;
wire \compressor_in_0[14] ;
wire \compressor_in_0[13] ;
wire \compressor_in_0[12] ;
wire \compressor_in_0[11] ;
wire \compressor_in_0[10] ;
wire \compressor_in_0[9] ;
wire \compressor_in_0[8] ;
wire \compressor_in_0[7] ;
wire \compressor_in_0[6] ;
wire \compressor_in_0[5] ;
wire \compressor_in_0[4] ;
wire \compressor_in_0[3] ;
wire \compressor_in_0[2] ;
wire \compressor_in_0[1] ;
wire \compressor_in_0[0] ;
wire \compressor_out_0[15] ;
wire \compressor_out_0[14] ;
wire \compressor_out_0[13] ;
wire \compressor_out_0[12] ;
wire \compressor_out_0[11] ;
wire \compressor_out_0[10] ;
wire \compressor_out_0[9] ;
wire \compressor_out_0[8] ;
wire \compressor_out_0[7] ;
wire \compressor_out_0[6] ;
wire \compressor_out_0[5] ;
wire \compressor_out_0[4] ;
wire \compressor_out_0[3] ;
wire \compressor_out_0[2] ;
wire \compressor_out_0[1] ;
wire \compressor_out_0[0] ;
wire \compressor_0/gain[15] ;
wire \compressor_0/gain[14] ;
wire \compressor_0/gain[13] ;
wire \compressor_0/gain[12] ;
wire \compressor_0/gain[11] ;
wire \compressor_0/gain[10] ;
wire \compressor_0/gain[9] ;
wire \compressor_0/gain[8] ;
wire \compressor_0/gain[7] ;
wire \compressor_0/gain[6] ;
wire \compressor_0/gain[5] ;
wire \compressor_0/gain[4] ;
wire \compressor_0/gain[3] ;
wire \compressor_0/gain[2] ;
wire \compressor_0/gain[1] ;
wire \compressor_0/gain[0] ;
wire \compressor_0/compression_active ;
wire \compressor_0/attack_counter[15] ;
wire \compressor_0/attack_counter[14] ;
wire \compressor_0/attack_counter[13] ;
wire \compressor_0/attack_counter[12] ;
wire \compressor_0/attack_counter[11] ;
wire \compressor_0/attack_counter[10] ;
wire \compressor_0/attack_counter[9] ;
wire \compressor_0/attack_counter[8] ;
wire \compressor_0/attack_counter[7] ;
wire \compressor_0/attack_counter[6] ;
wire \compressor_0/attack_counter[5] ;
wire \compressor_0/attack_counter[4] ;
wire \compressor_0/attack_counter[3] ;
wire \compressor_0/attack_counter[2] ;
wire \compressor_0/attack_counter[1] ;
wire \compressor_0/attack_counter[0] ;
wire \compressor_0/release_counter[15] ;
wire \compressor_0/release_counter[14] ;
wire \compressor_0/release_counter[13] ;
wire \compressor_0/release_counter[12] ;
wire \compressor_0/release_counter[11] ;
wire \compressor_0/release_counter[10] ;
wire \compressor_0/release_counter[9] ;
wire \compressor_0/release_counter[8] ;
wire \compressor_0/release_counter[7] ;
wire \compressor_0/release_counter[6] ;
wire \compressor_0/release_counter[5] ;
wire \compressor_0/release_counter[4] ;
wire \compressor_0/release_counter[3] ;
wire \compressor_0/release_counter[2] ;
wire \compressor_0/release_counter[1] ;
wire \compressor_0/release_counter[0] ;
wire tms_pad_i;
wire tck_pad_i;
wire tdi_pad_i;
wire tdo_pad_o;
wire tms_i_c;
wire tck_i_c;
wire tdi_i_c;
wire tdo_o_c;
wire [9:0] control0;
wire gao_jtag_tck;
wire gao_jtag_reset;
wire run_test_idle_er1;
wire run_test_idle_er2;
wire shift_dr_capture_dr;
wire update_dr;
wire pause_dr;
wire enable_er1;
wire enable_er2;
wire gao_jtag_tdi;
wire tdo_er1;

IBUF tms_ibuf (
    .I(tms_pad_i),
    .O(tms_i_c)
);

IBUF tck_ibuf (
    .I(tck_pad_i),
    .O(tck_i_c)
);

IBUF tdi_ibuf (
    .I(tdi_pad_i),
    .O(tdi_i_c)
);

OBUF tdo_obuf (
    .I(tdo_o_c),
    .O(tdo_pad_o)
);

GW_JTAG  u_gw_jtag(
    .tms_pad_i(tms_i_c),
    .tck_pad_i(tck_i_c),
    .tdi_pad_i(tdi_i_c),
    .tdo_pad_o(tdo_o_c),
    .tck_o(gao_jtag_tck),
    .test_logic_reset_o(gao_jtag_reset),
    .run_test_idle_er1_o(run_test_idle_er1),
    .run_test_idle_er2_o(run_test_idle_er2),
    .shift_dr_capture_dr_o(shift_dr_capture_dr),
    .update_dr_o(update_dr),
    .pause_dr_o(pause_dr),
    .enable_er1_o(enable_er1),
    .enable_er2_o(enable_er2),
    .tdi_o(gao_jtag_tdi),
    .tdo_er1_i(tdo_er1),
    .tdo_er2_i(1'b0)
);

gw_con_top  u_icon_top(
    .tck_i(gao_jtag_tck),
    .tdi_i(gao_jtag_tdi),
    .tdo_o(tdo_er1),
    .rst_i(gao_jtag_reset),
    .control0(control0[9:0]),
    .enable_i(enable_er1),
    .shift_dr_capture_dr_i(shift_dr_capture_dr),
    .update_dr_i(update_dr)
);

ao_top_0  u_la0_top(
    .control(control0[9:0]),
    .trig0_i(clk),
    .data_i({\i2s_tx/dacfifo_wrclk ,clk,I2S_BCLK,I2S_MCLK,dacfifo_write,\compressor_in_0[15] ,\compressor_in_0[14] ,\compressor_in_0[13] ,\compressor_in_0[12] ,\compressor_in_0[11] ,\compressor_in_0[10] ,\compressor_in_0[9] ,\compressor_in_0[8] ,\compressor_in_0[7] ,\compressor_in_0[6] ,\compressor_in_0[5] ,\compressor_in_0[4] ,\compressor_in_0[3] ,\compressor_in_0[2] ,\compressor_in_0[1] ,\compressor_in_0[0] ,\compressor_out_0[15] ,\compressor_out_0[14] ,\compressor_out_0[13] ,\compressor_out_0[12] ,\compressor_out_0[11] ,\compressor_out_0[10] ,\compressor_out_0[9] ,\compressor_out_0[8] ,\compressor_out_0[7] ,\compressor_out_0[6] ,\compressor_out_0[5] ,\compressor_out_0[4] ,\compressor_out_0[3] ,\compressor_out_0[2] ,\compressor_out_0[1] ,\compressor_out_0[0] ,\compressor_0/gain[15] ,\compressor_0/gain[14] ,\compressor_0/gain[13] ,\compressor_0/gain[12] ,\compressor_0/gain[11] ,\compressor_0/gain[10] ,\compressor_0/gain[9] ,\compressor_0/gain[8] ,\compressor_0/gain[7] ,\compressor_0/gain[6] ,\compressor_0/gain[5] ,\compressor_0/gain[4] ,\compressor_0/gain[3] ,\compressor_0/gain[2] ,\compressor_0/gain[1] ,\compressor_0/gain[0] ,\compressor_0/compression_active ,\compressor_0/attack_counter[15] ,\compressor_0/attack_counter[14] ,\compressor_0/attack_counter[13] ,\compressor_0/attack_counter[12] ,\compressor_0/attack_counter[11] ,\compressor_0/attack_counter[10] ,\compressor_0/attack_counter[9] ,\compressor_0/attack_counter[8] ,\compressor_0/attack_counter[7] ,\compressor_0/attack_counter[6] ,\compressor_0/attack_counter[5] ,\compressor_0/attack_counter[4] ,\compressor_0/attack_counter[3] ,\compressor_0/attack_counter[2] ,\compressor_0/attack_counter[1] ,\compressor_0/attack_counter[0] ,\compressor_0/release_counter[15] ,\compressor_0/release_counter[14] ,\compressor_0/release_counter[13] ,\compressor_0/release_counter[12] ,\compressor_0/release_counter[11] ,\compressor_0/release_counter[10] ,\compressor_0/release_counter[9] ,\compressor_0/release_counter[8] ,\compressor_0/release_counter[7] ,\compressor_0/release_counter[6] ,\compressor_0/release_counter[5] ,\compressor_0/release_counter[4] ,\compressor_0/release_counter[3] ,\compressor_0/release_counter[2] ,\compressor_0/release_counter[1] ,\compressor_0/release_counter[0] }),
    .clk_i(clk)
);

endmodule
