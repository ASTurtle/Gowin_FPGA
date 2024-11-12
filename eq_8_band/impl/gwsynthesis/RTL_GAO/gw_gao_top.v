module gw_gao(
    \eq_in_0[15] ,
    \eq_in_0[14] ,
    \eq_in_0[13] ,
    \eq_in_0[12] ,
    \eq_in_0[11] ,
    \eq_in_0[10] ,
    \eq_in_0[9] ,
    \eq_in_0[8] ,
    \eq_in_0[7] ,
    \eq_in_0[6] ,
    \eq_in_0[5] ,
    \eq_in_0[4] ,
    \eq_in_0[3] ,
    \eq_in_0[2] ,
    \eq_in_0[1] ,
    \eq_in_0[0] ,
    \eq_out_0[15] ,
    \eq_out_0[14] ,
    \eq_out_0[13] ,
    \eq_out_0[12] ,
    \eq_out_0[11] ,
    \eq_out_0[10] ,
    \eq_out_0[9] ,
    \eq_out_0[8] ,
    \eq_out_0[7] ,
    \eq_out_0[6] ,
    \eq_out_0[5] ,
    \eq_out_0[4] ,
    \eq_out_0[3] ,
    \eq_out_0[2] ,
    \eq_out_0[1] ,
    \eq_out_0[0] ,
    dacfifo_write,
    \equalizer_0/filtered_out[0][15] ,
    \equalizer_0/filtered_out[0][14] ,
    \equalizer_0/filtered_out[0][13] ,
    \equalizer_0/filtered_out[0][12] ,
    \equalizer_0/filtered_out[0][11] ,
    \equalizer_0/filtered_out[0][10] ,
    \equalizer_0/filtered_out[0][9] ,
    \equalizer_0/filtered_out[0][8] ,
    \equalizer_0/filtered_out[0][7] ,
    \equalizer_0/filtered_out[0][6] ,
    \equalizer_0/filtered_out[0][5] ,
    \equalizer_0/filtered_out[0][4] ,
    \equalizer_0/filtered_out[0][3] ,
    \equalizer_0/filtered_out[0][2] ,
    \equalizer_0/filtered_out[0][1] ,
    \equalizer_0/filtered_out[0][0] ,
    \equalizer_0/filtered_out[1][15] ,
    \equalizer_0/filtered_out[1][14] ,
    \equalizer_0/filtered_out[1][13] ,
    \equalizer_0/filtered_out[1][12] ,
    \equalizer_0/filtered_out[1][11] ,
    \equalizer_0/filtered_out[1][10] ,
    \equalizer_0/filtered_out[1][9] ,
    \equalizer_0/filtered_out[1][8] ,
    \equalizer_0/filtered_out[1][7] ,
    \equalizer_0/filtered_out[1][6] ,
    \equalizer_0/filtered_out[1][5] ,
    \equalizer_0/filtered_out[1][4] ,
    \equalizer_0/filtered_out[1][3] ,
    \equalizer_0/filtered_out[1][2] ,
    \equalizer_0/filtered_out[1][1] ,
    \equalizer_0/filtered_out[1][0] ,
    \equalizer_0/filtered_out[2][15] ,
    \equalizer_0/filtered_out[2][14] ,
    \equalizer_0/filtered_out[2][13] ,
    \equalizer_0/filtered_out[2][12] ,
    \equalizer_0/filtered_out[2][11] ,
    \equalizer_0/filtered_out[2][10] ,
    \equalizer_0/filtered_out[2][9] ,
    \equalizer_0/filtered_out[2][8] ,
    \equalizer_0/filtered_out[2][7] ,
    \equalizer_0/filtered_out[2][6] ,
    \equalizer_0/filtered_out[2][5] ,
    \equalizer_0/filtered_out[2][4] ,
    \equalizer_0/filtered_out[2][3] ,
    \equalizer_0/filtered_out[2][2] ,
    \equalizer_0/filtered_out[2][1] ,
    \equalizer_0/filtered_out[2][0] ,
    \equalizer_0/filtered_out[3][15] ,
    \equalizer_0/filtered_out[3][14] ,
    \equalizer_0/filtered_out[3][13] ,
    \equalizer_0/filtered_out[3][12] ,
    \equalizer_0/filtered_out[3][11] ,
    \equalizer_0/filtered_out[3][10] ,
    \equalizer_0/filtered_out[3][9] ,
    \equalizer_0/filtered_out[3][8] ,
    \equalizer_0/filtered_out[3][7] ,
    \equalizer_0/filtered_out[3][6] ,
    \equalizer_0/filtered_out[3][5] ,
    \equalizer_0/filtered_out[3][4] ,
    \equalizer_0/filtered_out[3][3] ,
    \equalizer_0/filtered_out[3][2] ,
    \equalizer_0/filtered_out[3][1] ,
    \equalizer_0/filtered_out[3][0] ,
    clk,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \eq_in_0[15] ;
input \eq_in_0[14] ;
input \eq_in_0[13] ;
input \eq_in_0[12] ;
input \eq_in_0[11] ;
input \eq_in_0[10] ;
input \eq_in_0[9] ;
input \eq_in_0[8] ;
input \eq_in_0[7] ;
input \eq_in_0[6] ;
input \eq_in_0[5] ;
input \eq_in_0[4] ;
input \eq_in_0[3] ;
input \eq_in_0[2] ;
input \eq_in_0[1] ;
input \eq_in_0[0] ;
input \eq_out_0[15] ;
input \eq_out_0[14] ;
input \eq_out_0[13] ;
input \eq_out_0[12] ;
input \eq_out_0[11] ;
input \eq_out_0[10] ;
input \eq_out_0[9] ;
input \eq_out_0[8] ;
input \eq_out_0[7] ;
input \eq_out_0[6] ;
input \eq_out_0[5] ;
input \eq_out_0[4] ;
input \eq_out_0[3] ;
input \eq_out_0[2] ;
input \eq_out_0[1] ;
input \eq_out_0[0] ;
input dacfifo_write;
input \equalizer_0/filtered_out[0][15] ;
input \equalizer_0/filtered_out[0][14] ;
input \equalizer_0/filtered_out[0][13] ;
input \equalizer_0/filtered_out[0][12] ;
input \equalizer_0/filtered_out[0][11] ;
input \equalizer_0/filtered_out[0][10] ;
input \equalizer_0/filtered_out[0][9] ;
input \equalizer_0/filtered_out[0][8] ;
input \equalizer_0/filtered_out[0][7] ;
input \equalizer_0/filtered_out[0][6] ;
input \equalizer_0/filtered_out[0][5] ;
input \equalizer_0/filtered_out[0][4] ;
input \equalizer_0/filtered_out[0][3] ;
input \equalizer_0/filtered_out[0][2] ;
input \equalizer_0/filtered_out[0][1] ;
input \equalizer_0/filtered_out[0][0] ;
input \equalizer_0/filtered_out[1][15] ;
input \equalizer_0/filtered_out[1][14] ;
input \equalizer_0/filtered_out[1][13] ;
input \equalizer_0/filtered_out[1][12] ;
input \equalizer_0/filtered_out[1][11] ;
input \equalizer_0/filtered_out[1][10] ;
input \equalizer_0/filtered_out[1][9] ;
input \equalizer_0/filtered_out[1][8] ;
input \equalizer_0/filtered_out[1][7] ;
input \equalizer_0/filtered_out[1][6] ;
input \equalizer_0/filtered_out[1][5] ;
input \equalizer_0/filtered_out[1][4] ;
input \equalizer_0/filtered_out[1][3] ;
input \equalizer_0/filtered_out[1][2] ;
input \equalizer_0/filtered_out[1][1] ;
input \equalizer_0/filtered_out[1][0] ;
input \equalizer_0/filtered_out[2][15] ;
input \equalizer_0/filtered_out[2][14] ;
input \equalizer_0/filtered_out[2][13] ;
input \equalizer_0/filtered_out[2][12] ;
input \equalizer_0/filtered_out[2][11] ;
input \equalizer_0/filtered_out[2][10] ;
input \equalizer_0/filtered_out[2][9] ;
input \equalizer_0/filtered_out[2][8] ;
input \equalizer_0/filtered_out[2][7] ;
input \equalizer_0/filtered_out[2][6] ;
input \equalizer_0/filtered_out[2][5] ;
input \equalizer_0/filtered_out[2][4] ;
input \equalizer_0/filtered_out[2][3] ;
input \equalizer_0/filtered_out[2][2] ;
input \equalizer_0/filtered_out[2][1] ;
input \equalizer_0/filtered_out[2][0] ;
input \equalizer_0/filtered_out[3][15] ;
input \equalizer_0/filtered_out[3][14] ;
input \equalizer_0/filtered_out[3][13] ;
input \equalizer_0/filtered_out[3][12] ;
input \equalizer_0/filtered_out[3][11] ;
input \equalizer_0/filtered_out[3][10] ;
input \equalizer_0/filtered_out[3][9] ;
input \equalizer_0/filtered_out[3][8] ;
input \equalizer_0/filtered_out[3][7] ;
input \equalizer_0/filtered_out[3][6] ;
input \equalizer_0/filtered_out[3][5] ;
input \equalizer_0/filtered_out[3][4] ;
input \equalizer_0/filtered_out[3][3] ;
input \equalizer_0/filtered_out[3][2] ;
input \equalizer_0/filtered_out[3][1] ;
input \equalizer_0/filtered_out[3][0] ;
input clk;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \eq_in_0[15] ;
wire \eq_in_0[14] ;
wire \eq_in_0[13] ;
wire \eq_in_0[12] ;
wire \eq_in_0[11] ;
wire \eq_in_0[10] ;
wire \eq_in_0[9] ;
wire \eq_in_0[8] ;
wire \eq_in_0[7] ;
wire \eq_in_0[6] ;
wire \eq_in_0[5] ;
wire \eq_in_0[4] ;
wire \eq_in_0[3] ;
wire \eq_in_0[2] ;
wire \eq_in_0[1] ;
wire \eq_in_0[0] ;
wire \eq_out_0[15] ;
wire \eq_out_0[14] ;
wire \eq_out_0[13] ;
wire \eq_out_0[12] ;
wire \eq_out_0[11] ;
wire \eq_out_0[10] ;
wire \eq_out_0[9] ;
wire \eq_out_0[8] ;
wire \eq_out_0[7] ;
wire \eq_out_0[6] ;
wire \eq_out_0[5] ;
wire \eq_out_0[4] ;
wire \eq_out_0[3] ;
wire \eq_out_0[2] ;
wire \eq_out_0[1] ;
wire \eq_out_0[0] ;
wire dacfifo_write;
wire \equalizer_0/filtered_out[0][15] ;
wire \equalizer_0/filtered_out[0][14] ;
wire \equalizer_0/filtered_out[0][13] ;
wire \equalizer_0/filtered_out[0][12] ;
wire \equalizer_0/filtered_out[0][11] ;
wire \equalizer_0/filtered_out[0][10] ;
wire \equalizer_0/filtered_out[0][9] ;
wire \equalizer_0/filtered_out[0][8] ;
wire \equalizer_0/filtered_out[0][7] ;
wire \equalizer_0/filtered_out[0][6] ;
wire \equalizer_0/filtered_out[0][5] ;
wire \equalizer_0/filtered_out[0][4] ;
wire \equalizer_0/filtered_out[0][3] ;
wire \equalizer_0/filtered_out[0][2] ;
wire \equalizer_0/filtered_out[0][1] ;
wire \equalizer_0/filtered_out[0][0] ;
wire \equalizer_0/filtered_out[1][15] ;
wire \equalizer_0/filtered_out[1][14] ;
wire \equalizer_0/filtered_out[1][13] ;
wire \equalizer_0/filtered_out[1][12] ;
wire \equalizer_0/filtered_out[1][11] ;
wire \equalizer_0/filtered_out[1][10] ;
wire \equalizer_0/filtered_out[1][9] ;
wire \equalizer_0/filtered_out[1][8] ;
wire \equalizer_0/filtered_out[1][7] ;
wire \equalizer_0/filtered_out[1][6] ;
wire \equalizer_0/filtered_out[1][5] ;
wire \equalizer_0/filtered_out[1][4] ;
wire \equalizer_0/filtered_out[1][3] ;
wire \equalizer_0/filtered_out[1][2] ;
wire \equalizer_0/filtered_out[1][1] ;
wire \equalizer_0/filtered_out[1][0] ;
wire \equalizer_0/filtered_out[2][15] ;
wire \equalizer_0/filtered_out[2][14] ;
wire \equalizer_0/filtered_out[2][13] ;
wire \equalizer_0/filtered_out[2][12] ;
wire \equalizer_0/filtered_out[2][11] ;
wire \equalizer_0/filtered_out[2][10] ;
wire \equalizer_0/filtered_out[2][9] ;
wire \equalizer_0/filtered_out[2][8] ;
wire \equalizer_0/filtered_out[2][7] ;
wire \equalizer_0/filtered_out[2][6] ;
wire \equalizer_0/filtered_out[2][5] ;
wire \equalizer_0/filtered_out[2][4] ;
wire \equalizer_0/filtered_out[2][3] ;
wire \equalizer_0/filtered_out[2][2] ;
wire \equalizer_0/filtered_out[2][1] ;
wire \equalizer_0/filtered_out[2][0] ;
wire \equalizer_0/filtered_out[3][15] ;
wire \equalizer_0/filtered_out[3][14] ;
wire \equalizer_0/filtered_out[3][13] ;
wire \equalizer_0/filtered_out[3][12] ;
wire \equalizer_0/filtered_out[3][11] ;
wire \equalizer_0/filtered_out[3][10] ;
wire \equalizer_0/filtered_out[3][9] ;
wire \equalizer_0/filtered_out[3][8] ;
wire \equalizer_0/filtered_out[3][7] ;
wire \equalizer_0/filtered_out[3][6] ;
wire \equalizer_0/filtered_out[3][5] ;
wire \equalizer_0/filtered_out[3][4] ;
wire \equalizer_0/filtered_out[3][3] ;
wire \equalizer_0/filtered_out[3][2] ;
wire \equalizer_0/filtered_out[3][1] ;
wire \equalizer_0/filtered_out[3][0] ;
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
    .data_i({\eq_in_0[15] ,\eq_in_0[14] ,\eq_in_0[13] ,\eq_in_0[12] ,\eq_in_0[11] ,\eq_in_0[10] ,\eq_in_0[9] ,\eq_in_0[8] ,\eq_in_0[7] ,\eq_in_0[6] ,\eq_in_0[5] ,\eq_in_0[4] ,\eq_in_0[3] ,\eq_in_0[2] ,\eq_in_0[1] ,\eq_in_0[0] ,\eq_out_0[15] ,\eq_out_0[14] ,\eq_out_0[13] ,\eq_out_0[12] ,\eq_out_0[11] ,\eq_out_0[10] ,\eq_out_0[9] ,\eq_out_0[8] ,\eq_out_0[7] ,\eq_out_0[6] ,\eq_out_0[5] ,\eq_out_0[4] ,\eq_out_0[3] ,\eq_out_0[2] ,\eq_out_0[1] ,\eq_out_0[0] ,dacfifo_write,\equalizer_0/filtered_out[0][15] ,\equalizer_0/filtered_out[0][14] ,\equalizer_0/filtered_out[0][13] ,\equalizer_0/filtered_out[0][12] ,\equalizer_0/filtered_out[0][11] ,\equalizer_0/filtered_out[0][10] ,\equalizer_0/filtered_out[0][9] ,\equalizer_0/filtered_out[0][8] ,\equalizer_0/filtered_out[0][7] ,\equalizer_0/filtered_out[0][6] ,\equalizer_0/filtered_out[0][5] ,\equalizer_0/filtered_out[0][4] ,\equalizer_0/filtered_out[0][3] ,\equalizer_0/filtered_out[0][2] ,\equalizer_0/filtered_out[0][1] ,\equalizer_0/filtered_out[0][0] ,\equalizer_0/filtered_out[1][15] ,\equalizer_0/filtered_out[1][14] ,\equalizer_0/filtered_out[1][13] ,\equalizer_0/filtered_out[1][12] ,\equalizer_0/filtered_out[1][11] ,\equalizer_0/filtered_out[1][10] ,\equalizer_0/filtered_out[1][9] ,\equalizer_0/filtered_out[1][8] ,\equalizer_0/filtered_out[1][7] ,\equalizer_0/filtered_out[1][6] ,\equalizer_0/filtered_out[1][5] ,\equalizer_0/filtered_out[1][4] ,\equalizer_0/filtered_out[1][3] ,\equalizer_0/filtered_out[1][2] ,\equalizer_0/filtered_out[1][1] ,\equalizer_0/filtered_out[1][0] ,\equalizer_0/filtered_out[2][15] ,\equalizer_0/filtered_out[2][14] ,\equalizer_0/filtered_out[2][13] ,\equalizer_0/filtered_out[2][12] ,\equalizer_0/filtered_out[2][11] ,\equalizer_0/filtered_out[2][10] ,\equalizer_0/filtered_out[2][9] ,\equalizer_0/filtered_out[2][8] ,\equalizer_0/filtered_out[2][7] ,\equalizer_0/filtered_out[2][6] ,\equalizer_0/filtered_out[2][5] ,\equalizer_0/filtered_out[2][4] ,\equalizer_0/filtered_out[2][3] ,\equalizer_0/filtered_out[2][2] ,\equalizer_0/filtered_out[2][1] ,\equalizer_0/filtered_out[2][0] ,\equalizer_0/filtered_out[3][15] ,\equalizer_0/filtered_out[3][14] ,\equalizer_0/filtered_out[3][13] ,\equalizer_0/filtered_out[3][12] ,\equalizer_0/filtered_out[3][11] ,\equalizer_0/filtered_out[3][10] ,\equalizer_0/filtered_out[3][9] ,\equalizer_0/filtered_out[3][8] ,\equalizer_0/filtered_out[3][7] ,\equalizer_0/filtered_out[3][6] ,\equalizer_0/filtered_out[3][5] ,\equalizer_0/filtered_out[3][4] ,\equalizer_0/filtered_out[3][3] ,\equalizer_0/filtered_out[3][2] ,\equalizer_0/filtered_out[3][1] ,\equalizer_0/filtered_out[3][0] }),
    .clk_i(clk)
);

endmodule
