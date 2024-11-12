module gw_gao(
    dacfifo_write,
    factor_clk,
    standard_clk,
    \filtered_data_out[31] ,
    \filtered_data_out[30] ,
    \filtered_data_out[29] ,
    \filtered_data_out[28] ,
    \filtered_data_out[27] ,
    \filtered_data_out[26] ,
    \filtered_data_out[25] ,
    \filtered_data_out[24] ,
    \filtered_data_out[23] ,
    \filtered_data_out[22] ,
    \filtered_data_out[21] ,
    \filtered_data_out[20] ,
    \filtered_data_out[19] ,
    \filtered_data_out[18] ,
    \filtered_data_out[17] ,
    \filtered_data_out[16] ,
    \filtered_data_out[15] ,
    \filtered_data_out[14] ,
    \filtered_data_out[13] ,
    \filtered_data_out[12] ,
    \filtered_data_out[11] ,
    \filtered_data_out[10] ,
    \filtered_data_out[9] ,
    \filtered_data_out[8] ,
    \filtered_data_out[7] ,
    \filtered_data_out[6] ,
    \filtered_data_out[5] ,
    \filtered_data_out[4] ,
    \filtered_data_out[3] ,
    \filtered_data_out[2] ,
    \filtered_data_out[1] ,
    \filtered_data_out[0] ,
    clk,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input dacfifo_write;
input factor_clk;
input standard_clk;
input \filtered_data_out[31] ;
input \filtered_data_out[30] ;
input \filtered_data_out[29] ;
input \filtered_data_out[28] ;
input \filtered_data_out[27] ;
input \filtered_data_out[26] ;
input \filtered_data_out[25] ;
input \filtered_data_out[24] ;
input \filtered_data_out[23] ;
input \filtered_data_out[22] ;
input \filtered_data_out[21] ;
input \filtered_data_out[20] ;
input \filtered_data_out[19] ;
input \filtered_data_out[18] ;
input \filtered_data_out[17] ;
input \filtered_data_out[16] ;
input \filtered_data_out[15] ;
input \filtered_data_out[14] ;
input \filtered_data_out[13] ;
input \filtered_data_out[12] ;
input \filtered_data_out[11] ;
input \filtered_data_out[10] ;
input \filtered_data_out[9] ;
input \filtered_data_out[8] ;
input \filtered_data_out[7] ;
input \filtered_data_out[6] ;
input \filtered_data_out[5] ;
input \filtered_data_out[4] ;
input \filtered_data_out[3] ;
input \filtered_data_out[2] ;
input \filtered_data_out[1] ;
input \filtered_data_out[0] ;
input clk;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire dacfifo_write;
wire factor_clk;
wire standard_clk;
wire \filtered_data_out[31] ;
wire \filtered_data_out[30] ;
wire \filtered_data_out[29] ;
wire \filtered_data_out[28] ;
wire \filtered_data_out[27] ;
wire \filtered_data_out[26] ;
wire \filtered_data_out[25] ;
wire \filtered_data_out[24] ;
wire \filtered_data_out[23] ;
wire \filtered_data_out[22] ;
wire \filtered_data_out[21] ;
wire \filtered_data_out[20] ;
wire \filtered_data_out[19] ;
wire \filtered_data_out[18] ;
wire \filtered_data_out[17] ;
wire \filtered_data_out[16] ;
wire \filtered_data_out[15] ;
wire \filtered_data_out[14] ;
wire \filtered_data_out[13] ;
wire \filtered_data_out[12] ;
wire \filtered_data_out[11] ;
wire \filtered_data_out[10] ;
wire \filtered_data_out[9] ;
wire \filtered_data_out[8] ;
wire \filtered_data_out[7] ;
wire \filtered_data_out[6] ;
wire \filtered_data_out[5] ;
wire \filtered_data_out[4] ;
wire \filtered_data_out[3] ;
wire \filtered_data_out[2] ;
wire \filtered_data_out[1] ;
wire \filtered_data_out[0] ;
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
    .data_i({dacfifo_write,factor_clk,standard_clk,\filtered_data_out[31] ,\filtered_data_out[30] ,\filtered_data_out[29] ,\filtered_data_out[28] ,\filtered_data_out[27] ,\filtered_data_out[26] ,\filtered_data_out[25] ,\filtered_data_out[24] ,\filtered_data_out[23] ,\filtered_data_out[22] ,\filtered_data_out[21] ,\filtered_data_out[20] ,\filtered_data_out[19] ,\filtered_data_out[18] ,\filtered_data_out[17] ,\filtered_data_out[16] ,\filtered_data_out[15] ,\filtered_data_out[14] ,\filtered_data_out[13] ,\filtered_data_out[12] ,\filtered_data_out[11] ,\filtered_data_out[10] ,\filtered_data_out[9] ,\filtered_data_out[8] ,\filtered_data_out[7] ,\filtered_data_out[6] ,\filtered_data_out[5] ,\filtered_data_out[4] ,\filtered_data_out[3] ,\filtered_data_out[2] ,\filtered_data_out[1] ,\filtered_data_out[0] }),
    .clk_i(clk)
);

endmodule
