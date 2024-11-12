module gw_gao(
    \dacfifo_writedata[31] ,
    \dacfifo_writedata[30] ,
    \dacfifo_writedata[29] ,
    \dacfifo_writedata[28] ,
    \dacfifo_writedata[27] ,
    \dacfifo_writedata[26] ,
    \dacfifo_writedata[25] ,
    \dacfifo_writedata[24] ,
    \dacfifo_writedata[23] ,
    \dacfifo_writedata[22] ,
    \dacfifo_writedata[21] ,
    \dacfifo_writedata[20] ,
    \dacfifo_writedata[19] ,
    \dacfifo_writedata[18] ,
    \dacfifo_writedata[17] ,
    \dacfifo_writedata[16] ,
    \dacfifo_writedata[15] ,
    \dacfifo_writedata[14] ,
    \dacfifo_writedata[13] ,
    \dacfifo_writedata[12] ,
    \dacfifo_writedata[11] ,
    \dacfifo_writedata[10] ,
    \dacfifo_writedata[9] ,
    \dacfifo_writedata[8] ,
    \dacfifo_writedata[7] ,
    \dacfifo_writedata[6] ,
    \dacfifo_writedata[5] ,
    \dacfifo_writedata[4] ,
    \dacfifo_writedata[3] ,
    \dacfifo_writedata[2] ,
    \dacfifo_writedata[1] ,
    \dacfifo_writedata[0] ,
    \adcfifo_readdata[31] ,
    \adcfifo_readdata[30] ,
    \adcfifo_readdata[29] ,
    \adcfifo_readdata[28] ,
    \adcfifo_readdata[27] ,
    \adcfifo_readdata[26] ,
    \adcfifo_readdata[25] ,
    \adcfifo_readdata[24] ,
    \adcfifo_readdata[23] ,
    \adcfifo_readdata[22] ,
    \adcfifo_readdata[21] ,
    \adcfifo_readdata[20] ,
    \adcfifo_readdata[19] ,
    \adcfifo_readdata[18] ,
    \adcfifo_readdata[17] ,
    \adcfifo_readdata[16] ,
    \adcfifo_readdata[15] ,
    \adcfifo_readdata[14] ,
    \adcfifo_readdata[13] ,
    \adcfifo_readdata[12] ,
    \adcfifo_readdata[11] ,
    \adcfifo_readdata[10] ,
    \adcfifo_readdata[9] ,
    \adcfifo_readdata[8] ,
    \adcfifo_readdata[7] ,
    \adcfifo_readdata[6] ,
    \adcfifo_readdata[5] ,
    \adcfifo_readdata[4] ,
    \adcfifo_readdata[3] ,
    \adcfifo_readdata[2] ,
    \adcfifo_readdata[1] ,
    \adcfifo_readdata[0] ,
    \echo_out_0[15] ,
    \echo_out_0[14] ,
    \echo_out_0[13] ,
    \echo_out_0[12] ,
    \echo_out_0[11] ,
    \echo_out_0[10] ,
    \echo_out_0[9] ,
    \echo_out_0[8] ,
    \echo_out_0[7] ,
    \echo_out_0[6] ,
    \echo_out_0[5] ,
    \echo_out_0[4] ,
    \echo_out_0[3] ,
    \echo_out_0[2] ,
    \echo_out_0[1] ,
    \echo_out_0[0] ,
    \echo_in_0[15] ,
    \echo_in_0[14] ,
    \echo_in_0[13] ,
    \echo_in_0[12] ,
    \echo_in_0[11] ,
    \echo_in_0[10] ,
    \echo_in_0[9] ,
    \echo_in_0[8] ,
    \echo_in_0[7] ,
    \echo_in_0[6] ,
    \echo_in_0[5] ,
    \echo_in_0[4] ,
    \echo_in_0[3] ,
    \echo_in_0[2] ,
    \echo_in_0[1] ,
    \echo_in_0[0] ,
    dacfifo_write,
    \echo_0/delayed_audio[15] ,
    \echo_0/delayed_audio[14] ,
    \echo_0/delayed_audio[13] ,
    \echo_0/delayed_audio[12] ,
    \echo_0/delayed_audio[11] ,
    \echo_0/delayed_audio[10] ,
    \echo_0/delayed_audio[9] ,
    \echo_0/delayed_audio[8] ,
    \echo_0/delayed_audio[7] ,
    \echo_0/delayed_audio[6] ,
    \echo_0/delayed_audio[5] ,
    \echo_0/delayed_audio[4] ,
    \echo_0/delayed_audio[3] ,
    \echo_0/delayed_audio[2] ,
    \echo_0/delayed_audio[1] ,
    \echo_0/delayed_audio[0] ,
    \echo_0/gain_result[15] ,
    \echo_0/gain_result[14] ,
    \echo_0/gain_result[13] ,
    \echo_0/gain_result[12] ,
    \echo_0/gain_result[11] ,
    \echo_0/gain_result[10] ,
    \echo_0/gain_result[9] ,
    \echo_0/gain_result[8] ,
    \echo_0/gain_result[7] ,
    \echo_0/gain_result[6] ,
    \echo_0/gain_result[5] ,
    \echo_0/gain_result[4] ,
    \echo_0/gain_result[3] ,
    \echo_0/gain_result[2] ,
    \echo_0/gain_result[1] ,
    \echo_0/gain_result[0] ,
    \echo_0/mixed_audio[15] ,
    \echo_0/mixed_audio[14] ,
    \echo_0/mixed_audio[13] ,
    \echo_0/mixed_audio[12] ,
    \echo_0/mixed_audio[11] ,
    \echo_0/mixed_audio[10] ,
    \echo_0/mixed_audio[9] ,
    \echo_0/mixed_audio[8] ,
    \echo_0/mixed_audio[7] ,
    \echo_0/mixed_audio[6] ,
    \echo_0/mixed_audio[5] ,
    \echo_0/mixed_audio[4] ,
    \echo_0/mixed_audio[3] ,
    \echo_0/mixed_audio[2] ,
    \echo_0/mixed_audio[1] ,
    \echo_0/mixed_audio[0] ,
    \lowp_0/filter_out[15] ,
    \lowp_0/filter_out[14] ,
    \lowp_0/filter_out[13] ,
    \lowp_0/filter_out[12] ,
    \lowp_0/filter_out[11] ,
    \lowp_0/filter_out[10] ,
    \lowp_0/filter_out[9] ,
    \lowp_0/filter_out[8] ,
    \lowp_0/filter_out[7] ,
    \lowp_0/filter_out[6] ,
    \lowp_0/filter_out[5] ,
    \lowp_0/filter_out[4] ,
    \lowp_0/filter_out[3] ,
    \lowp_0/filter_out[2] ,
    \lowp_0/filter_out[1] ,
    \lowp_0/filter_out[0] ,
    \i2s_tx/dacfifo_wren ,
    \i2s_tx/dac_fifo/wrclk ,
    \i2s_tx/dac_fifo/wren ,
    I2S_BCLK,
    \i2s_rx/bclk ,
    clk,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \dacfifo_writedata[31] ;
input \dacfifo_writedata[30] ;
input \dacfifo_writedata[29] ;
input \dacfifo_writedata[28] ;
input \dacfifo_writedata[27] ;
input \dacfifo_writedata[26] ;
input \dacfifo_writedata[25] ;
input \dacfifo_writedata[24] ;
input \dacfifo_writedata[23] ;
input \dacfifo_writedata[22] ;
input \dacfifo_writedata[21] ;
input \dacfifo_writedata[20] ;
input \dacfifo_writedata[19] ;
input \dacfifo_writedata[18] ;
input \dacfifo_writedata[17] ;
input \dacfifo_writedata[16] ;
input \dacfifo_writedata[15] ;
input \dacfifo_writedata[14] ;
input \dacfifo_writedata[13] ;
input \dacfifo_writedata[12] ;
input \dacfifo_writedata[11] ;
input \dacfifo_writedata[10] ;
input \dacfifo_writedata[9] ;
input \dacfifo_writedata[8] ;
input \dacfifo_writedata[7] ;
input \dacfifo_writedata[6] ;
input \dacfifo_writedata[5] ;
input \dacfifo_writedata[4] ;
input \dacfifo_writedata[3] ;
input \dacfifo_writedata[2] ;
input \dacfifo_writedata[1] ;
input \dacfifo_writedata[0] ;
input \adcfifo_readdata[31] ;
input \adcfifo_readdata[30] ;
input \adcfifo_readdata[29] ;
input \adcfifo_readdata[28] ;
input \adcfifo_readdata[27] ;
input \adcfifo_readdata[26] ;
input \adcfifo_readdata[25] ;
input \adcfifo_readdata[24] ;
input \adcfifo_readdata[23] ;
input \adcfifo_readdata[22] ;
input \adcfifo_readdata[21] ;
input \adcfifo_readdata[20] ;
input \adcfifo_readdata[19] ;
input \adcfifo_readdata[18] ;
input \adcfifo_readdata[17] ;
input \adcfifo_readdata[16] ;
input \adcfifo_readdata[15] ;
input \adcfifo_readdata[14] ;
input \adcfifo_readdata[13] ;
input \adcfifo_readdata[12] ;
input \adcfifo_readdata[11] ;
input \adcfifo_readdata[10] ;
input \adcfifo_readdata[9] ;
input \adcfifo_readdata[8] ;
input \adcfifo_readdata[7] ;
input \adcfifo_readdata[6] ;
input \adcfifo_readdata[5] ;
input \adcfifo_readdata[4] ;
input \adcfifo_readdata[3] ;
input \adcfifo_readdata[2] ;
input \adcfifo_readdata[1] ;
input \adcfifo_readdata[0] ;
input \echo_out_0[15] ;
input \echo_out_0[14] ;
input \echo_out_0[13] ;
input \echo_out_0[12] ;
input \echo_out_0[11] ;
input \echo_out_0[10] ;
input \echo_out_0[9] ;
input \echo_out_0[8] ;
input \echo_out_0[7] ;
input \echo_out_0[6] ;
input \echo_out_0[5] ;
input \echo_out_0[4] ;
input \echo_out_0[3] ;
input \echo_out_0[2] ;
input \echo_out_0[1] ;
input \echo_out_0[0] ;
input \echo_in_0[15] ;
input \echo_in_0[14] ;
input \echo_in_0[13] ;
input \echo_in_0[12] ;
input \echo_in_0[11] ;
input \echo_in_0[10] ;
input \echo_in_0[9] ;
input \echo_in_0[8] ;
input \echo_in_0[7] ;
input \echo_in_0[6] ;
input \echo_in_0[5] ;
input \echo_in_0[4] ;
input \echo_in_0[3] ;
input \echo_in_0[2] ;
input \echo_in_0[1] ;
input \echo_in_0[0] ;
input dacfifo_write;
input \echo_0/delayed_audio[15] ;
input \echo_0/delayed_audio[14] ;
input \echo_0/delayed_audio[13] ;
input \echo_0/delayed_audio[12] ;
input \echo_0/delayed_audio[11] ;
input \echo_0/delayed_audio[10] ;
input \echo_0/delayed_audio[9] ;
input \echo_0/delayed_audio[8] ;
input \echo_0/delayed_audio[7] ;
input \echo_0/delayed_audio[6] ;
input \echo_0/delayed_audio[5] ;
input \echo_0/delayed_audio[4] ;
input \echo_0/delayed_audio[3] ;
input \echo_0/delayed_audio[2] ;
input \echo_0/delayed_audio[1] ;
input \echo_0/delayed_audio[0] ;
input \echo_0/gain_result[15] ;
input \echo_0/gain_result[14] ;
input \echo_0/gain_result[13] ;
input \echo_0/gain_result[12] ;
input \echo_0/gain_result[11] ;
input \echo_0/gain_result[10] ;
input \echo_0/gain_result[9] ;
input \echo_0/gain_result[8] ;
input \echo_0/gain_result[7] ;
input \echo_0/gain_result[6] ;
input \echo_0/gain_result[5] ;
input \echo_0/gain_result[4] ;
input \echo_0/gain_result[3] ;
input \echo_0/gain_result[2] ;
input \echo_0/gain_result[1] ;
input \echo_0/gain_result[0] ;
input \echo_0/mixed_audio[15] ;
input \echo_0/mixed_audio[14] ;
input \echo_0/mixed_audio[13] ;
input \echo_0/mixed_audio[12] ;
input \echo_0/mixed_audio[11] ;
input \echo_0/mixed_audio[10] ;
input \echo_0/mixed_audio[9] ;
input \echo_0/mixed_audio[8] ;
input \echo_0/mixed_audio[7] ;
input \echo_0/mixed_audio[6] ;
input \echo_0/mixed_audio[5] ;
input \echo_0/mixed_audio[4] ;
input \echo_0/mixed_audio[3] ;
input \echo_0/mixed_audio[2] ;
input \echo_0/mixed_audio[1] ;
input \echo_0/mixed_audio[0] ;
input \lowp_0/filter_out[15] ;
input \lowp_0/filter_out[14] ;
input \lowp_0/filter_out[13] ;
input \lowp_0/filter_out[12] ;
input \lowp_0/filter_out[11] ;
input \lowp_0/filter_out[10] ;
input \lowp_0/filter_out[9] ;
input \lowp_0/filter_out[8] ;
input \lowp_0/filter_out[7] ;
input \lowp_0/filter_out[6] ;
input \lowp_0/filter_out[5] ;
input \lowp_0/filter_out[4] ;
input \lowp_0/filter_out[3] ;
input \lowp_0/filter_out[2] ;
input \lowp_0/filter_out[1] ;
input \lowp_0/filter_out[0] ;
input \i2s_tx/dacfifo_wren ;
input \i2s_tx/dac_fifo/wrclk ;
input \i2s_tx/dac_fifo/wren ;
input I2S_BCLK;
input \i2s_rx/bclk ;
input clk;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \dacfifo_writedata[31] ;
wire \dacfifo_writedata[30] ;
wire \dacfifo_writedata[29] ;
wire \dacfifo_writedata[28] ;
wire \dacfifo_writedata[27] ;
wire \dacfifo_writedata[26] ;
wire \dacfifo_writedata[25] ;
wire \dacfifo_writedata[24] ;
wire \dacfifo_writedata[23] ;
wire \dacfifo_writedata[22] ;
wire \dacfifo_writedata[21] ;
wire \dacfifo_writedata[20] ;
wire \dacfifo_writedata[19] ;
wire \dacfifo_writedata[18] ;
wire \dacfifo_writedata[17] ;
wire \dacfifo_writedata[16] ;
wire \dacfifo_writedata[15] ;
wire \dacfifo_writedata[14] ;
wire \dacfifo_writedata[13] ;
wire \dacfifo_writedata[12] ;
wire \dacfifo_writedata[11] ;
wire \dacfifo_writedata[10] ;
wire \dacfifo_writedata[9] ;
wire \dacfifo_writedata[8] ;
wire \dacfifo_writedata[7] ;
wire \dacfifo_writedata[6] ;
wire \dacfifo_writedata[5] ;
wire \dacfifo_writedata[4] ;
wire \dacfifo_writedata[3] ;
wire \dacfifo_writedata[2] ;
wire \dacfifo_writedata[1] ;
wire \dacfifo_writedata[0] ;
wire \adcfifo_readdata[31] ;
wire \adcfifo_readdata[30] ;
wire \adcfifo_readdata[29] ;
wire \adcfifo_readdata[28] ;
wire \adcfifo_readdata[27] ;
wire \adcfifo_readdata[26] ;
wire \adcfifo_readdata[25] ;
wire \adcfifo_readdata[24] ;
wire \adcfifo_readdata[23] ;
wire \adcfifo_readdata[22] ;
wire \adcfifo_readdata[21] ;
wire \adcfifo_readdata[20] ;
wire \adcfifo_readdata[19] ;
wire \adcfifo_readdata[18] ;
wire \adcfifo_readdata[17] ;
wire \adcfifo_readdata[16] ;
wire \adcfifo_readdata[15] ;
wire \adcfifo_readdata[14] ;
wire \adcfifo_readdata[13] ;
wire \adcfifo_readdata[12] ;
wire \adcfifo_readdata[11] ;
wire \adcfifo_readdata[10] ;
wire \adcfifo_readdata[9] ;
wire \adcfifo_readdata[8] ;
wire \adcfifo_readdata[7] ;
wire \adcfifo_readdata[6] ;
wire \adcfifo_readdata[5] ;
wire \adcfifo_readdata[4] ;
wire \adcfifo_readdata[3] ;
wire \adcfifo_readdata[2] ;
wire \adcfifo_readdata[1] ;
wire \adcfifo_readdata[0] ;
wire \echo_out_0[15] ;
wire \echo_out_0[14] ;
wire \echo_out_0[13] ;
wire \echo_out_0[12] ;
wire \echo_out_0[11] ;
wire \echo_out_0[10] ;
wire \echo_out_0[9] ;
wire \echo_out_0[8] ;
wire \echo_out_0[7] ;
wire \echo_out_0[6] ;
wire \echo_out_0[5] ;
wire \echo_out_0[4] ;
wire \echo_out_0[3] ;
wire \echo_out_0[2] ;
wire \echo_out_0[1] ;
wire \echo_out_0[0] ;
wire \echo_in_0[15] ;
wire \echo_in_0[14] ;
wire \echo_in_0[13] ;
wire \echo_in_0[12] ;
wire \echo_in_0[11] ;
wire \echo_in_0[10] ;
wire \echo_in_0[9] ;
wire \echo_in_0[8] ;
wire \echo_in_0[7] ;
wire \echo_in_0[6] ;
wire \echo_in_0[5] ;
wire \echo_in_0[4] ;
wire \echo_in_0[3] ;
wire \echo_in_0[2] ;
wire \echo_in_0[1] ;
wire \echo_in_0[0] ;
wire dacfifo_write;
wire \echo_0/delayed_audio[15] ;
wire \echo_0/delayed_audio[14] ;
wire \echo_0/delayed_audio[13] ;
wire \echo_0/delayed_audio[12] ;
wire \echo_0/delayed_audio[11] ;
wire \echo_0/delayed_audio[10] ;
wire \echo_0/delayed_audio[9] ;
wire \echo_0/delayed_audio[8] ;
wire \echo_0/delayed_audio[7] ;
wire \echo_0/delayed_audio[6] ;
wire \echo_0/delayed_audio[5] ;
wire \echo_0/delayed_audio[4] ;
wire \echo_0/delayed_audio[3] ;
wire \echo_0/delayed_audio[2] ;
wire \echo_0/delayed_audio[1] ;
wire \echo_0/delayed_audio[0] ;
wire \echo_0/gain_result[15] ;
wire \echo_0/gain_result[14] ;
wire \echo_0/gain_result[13] ;
wire \echo_0/gain_result[12] ;
wire \echo_0/gain_result[11] ;
wire \echo_0/gain_result[10] ;
wire \echo_0/gain_result[9] ;
wire \echo_0/gain_result[8] ;
wire \echo_0/gain_result[7] ;
wire \echo_0/gain_result[6] ;
wire \echo_0/gain_result[5] ;
wire \echo_0/gain_result[4] ;
wire \echo_0/gain_result[3] ;
wire \echo_0/gain_result[2] ;
wire \echo_0/gain_result[1] ;
wire \echo_0/gain_result[0] ;
wire \echo_0/mixed_audio[15] ;
wire \echo_0/mixed_audio[14] ;
wire \echo_0/mixed_audio[13] ;
wire \echo_0/mixed_audio[12] ;
wire \echo_0/mixed_audio[11] ;
wire \echo_0/mixed_audio[10] ;
wire \echo_0/mixed_audio[9] ;
wire \echo_0/mixed_audio[8] ;
wire \echo_0/mixed_audio[7] ;
wire \echo_0/mixed_audio[6] ;
wire \echo_0/mixed_audio[5] ;
wire \echo_0/mixed_audio[4] ;
wire \echo_0/mixed_audio[3] ;
wire \echo_0/mixed_audio[2] ;
wire \echo_0/mixed_audio[1] ;
wire \echo_0/mixed_audio[0] ;
wire \lowp_0/filter_out[15] ;
wire \lowp_0/filter_out[14] ;
wire \lowp_0/filter_out[13] ;
wire \lowp_0/filter_out[12] ;
wire \lowp_0/filter_out[11] ;
wire \lowp_0/filter_out[10] ;
wire \lowp_0/filter_out[9] ;
wire \lowp_0/filter_out[8] ;
wire \lowp_0/filter_out[7] ;
wire \lowp_0/filter_out[6] ;
wire \lowp_0/filter_out[5] ;
wire \lowp_0/filter_out[4] ;
wire \lowp_0/filter_out[3] ;
wire \lowp_0/filter_out[2] ;
wire \lowp_0/filter_out[1] ;
wire \lowp_0/filter_out[0] ;
wire \i2s_tx/dacfifo_wren ;
wire \i2s_tx/dac_fifo/wrclk ;
wire \i2s_tx/dac_fifo/wren ;
wire I2S_BCLK;
wire \i2s_rx/bclk ;
wire clk;
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
    .trig0_i(dacfifo_write),
    .trig1_i(clk),
    .data_i({\dacfifo_writedata[31] ,\dacfifo_writedata[30] ,\dacfifo_writedata[29] ,\dacfifo_writedata[28] ,\dacfifo_writedata[27] ,\dacfifo_writedata[26] ,\dacfifo_writedata[25] ,\dacfifo_writedata[24] ,\dacfifo_writedata[23] ,\dacfifo_writedata[22] ,\dacfifo_writedata[21] ,\dacfifo_writedata[20] ,\dacfifo_writedata[19] ,\dacfifo_writedata[18] ,\dacfifo_writedata[17] ,\dacfifo_writedata[16] ,\dacfifo_writedata[15] ,\dacfifo_writedata[14] ,\dacfifo_writedata[13] ,\dacfifo_writedata[12] ,\dacfifo_writedata[11] ,\dacfifo_writedata[10] ,\dacfifo_writedata[9] ,\dacfifo_writedata[8] ,\dacfifo_writedata[7] ,\dacfifo_writedata[6] ,\dacfifo_writedata[5] ,\dacfifo_writedata[4] ,\dacfifo_writedata[3] ,\dacfifo_writedata[2] ,\dacfifo_writedata[1] ,\dacfifo_writedata[0] ,\adcfifo_readdata[31] ,\adcfifo_readdata[30] ,\adcfifo_readdata[29] ,\adcfifo_readdata[28] ,\adcfifo_readdata[27] ,\adcfifo_readdata[26] ,\adcfifo_readdata[25] ,\adcfifo_readdata[24] ,\adcfifo_readdata[23] ,\adcfifo_readdata[22] ,\adcfifo_readdata[21] ,\adcfifo_readdata[20] ,\adcfifo_readdata[19] ,\adcfifo_readdata[18] ,\adcfifo_readdata[17] ,\adcfifo_readdata[16] ,\adcfifo_readdata[15] ,\adcfifo_readdata[14] ,\adcfifo_readdata[13] ,\adcfifo_readdata[12] ,\adcfifo_readdata[11] ,\adcfifo_readdata[10] ,\adcfifo_readdata[9] ,\adcfifo_readdata[8] ,\adcfifo_readdata[7] ,\adcfifo_readdata[6] ,\adcfifo_readdata[5] ,\adcfifo_readdata[4] ,\adcfifo_readdata[3] ,\adcfifo_readdata[2] ,\adcfifo_readdata[1] ,\adcfifo_readdata[0] ,\echo_out_0[15] ,\echo_out_0[14] ,\echo_out_0[13] ,\echo_out_0[12] ,\echo_out_0[11] ,\echo_out_0[10] ,\echo_out_0[9] ,\echo_out_0[8] ,\echo_out_0[7] ,\echo_out_0[6] ,\echo_out_0[5] ,\echo_out_0[4] ,\echo_out_0[3] ,\echo_out_0[2] ,\echo_out_0[1] ,\echo_out_0[0] ,\echo_in_0[15] ,\echo_in_0[14] ,\echo_in_0[13] ,\echo_in_0[12] ,\echo_in_0[11] ,\echo_in_0[10] ,\echo_in_0[9] ,\echo_in_0[8] ,\echo_in_0[7] ,\echo_in_0[6] ,\echo_in_0[5] ,\echo_in_0[4] ,\echo_in_0[3] ,\echo_in_0[2] ,\echo_in_0[1] ,\echo_in_0[0] ,dacfifo_write,\echo_0/delayed_audio[15] ,\echo_0/delayed_audio[14] ,\echo_0/delayed_audio[13] ,\echo_0/delayed_audio[12] ,\echo_0/delayed_audio[11] ,\echo_0/delayed_audio[10] ,\echo_0/delayed_audio[9] ,\echo_0/delayed_audio[8] ,\echo_0/delayed_audio[7] ,\echo_0/delayed_audio[6] ,\echo_0/delayed_audio[5] ,\echo_0/delayed_audio[4] ,\echo_0/delayed_audio[3] ,\echo_0/delayed_audio[2] ,\echo_0/delayed_audio[1] ,\echo_0/delayed_audio[0] ,\echo_0/gain_result[15] ,\echo_0/gain_result[14] ,\echo_0/gain_result[13] ,\echo_0/gain_result[12] ,\echo_0/gain_result[11] ,\echo_0/gain_result[10] ,\echo_0/gain_result[9] ,\echo_0/gain_result[8] ,\echo_0/gain_result[7] ,\echo_0/gain_result[6] ,\echo_0/gain_result[5] ,\echo_0/gain_result[4] ,\echo_0/gain_result[3] ,\echo_0/gain_result[2] ,\echo_0/gain_result[1] ,\echo_0/gain_result[0] ,\echo_0/mixed_audio[15] ,\echo_0/mixed_audio[14] ,\echo_0/mixed_audio[13] ,\echo_0/mixed_audio[12] ,\echo_0/mixed_audio[11] ,\echo_0/mixed_audio[10] ,\echo_0/mixed_audio[9] ,\echo_0/mixed_audio[8] ,\echo_0/mixed_audio[7] ,\echo_0/mixed_audio[6] ,\echo_0/mixed_audio[5] ,\echo_0/mixed_audio[4] ,\echo_0/mixed_audio[3] ,\echo_0/mixed_audio[2] ,\echo_0/mixed_audio[1] ,\echo_0/mixed_audio[0] ,\lowp_0/filter_out[15] ,\lowp_0/filter_out[14] ,\lowp_0/filter_out[13] ,\lowp_0/filter_out[12] ,\lowp_0/filter_out[11] ,\lowp_0/filter_out[10] ,\lowp_0/filter_out[9] ,\lowp_0/filter_out[8] ,\lowp_0/filter_out[7] ,\lowp_0/filter_out[6] ,\lowp_0/filter_out[5] ,\lowp_0/filter_out[4] ,\lowp_0/filter_out[3] ,\lowp_0/filter_out[2] ,\lowp_0/filter_out[1] ,\lowp_0/filter_out[0] ,\i2s_tx/dacfifo_wren ,\i2s_tx/dac_fifo/wrclk ,\i2s_tx/dac_fifo/wren ,I2S_BCLK,\i2s_rx/bclk }),
    .clk_i(clk)
);

endmodule
