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
    dacfifo_write,
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
input dacfifo_write;
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
wire dacfifo_write;
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
    .data_i({\dacfifo_writedata[31] ,\dacfifo_writedata[30] ,\dacfifo_writedata[29] ,\dacfifo_writedata[28] ,\dacfifo_writedata[27] ,\dacfifo_writedata[26] ,\dacfifo_writedata[25] ,\dacfifo_writedata[24] ,\dacfifo_writedata[23] ,\dacfifo_writedata[22] ,\dacfifo_writedata[21] ,\dacfifo_writedata[20] ,\dacfifo_writedata[19] ,\dacfifo_writedata[18] ,\dacfifo_writedata[17] ,\dacfifo_writedata[16] ,\dacfifo_writedata[15] ,\dacfifo_writedata[14] ,\dacfifo_writedata[13] ,\dacfifo_writedata[12] ,\dacfifo_writedata[11] ,\dacfifo_writedata[10] ,\dacfifo_writedata[9] ,\dacfifo_writedata[8] ,\dacfifo_writedata[7] ,\dacfifo_writedata[6] ,\dacfifo_writedata[5] ,\dacfifo_writedata[4] ,\dacfifo_writedata[3] ,\dacfifo_writedata[2] ,\dacfifo_writedata[1] ,\dacfifo_writedata[0] ,\adcfifo_readdata[31] ,\adcfifo_readdata[30] ,\adcfifo_readdata[29] ,\adcfifo_readdata[28] ,\adcfifo_readdata[27] ,\adcfifo_readdata[26] ,\adcfifo_readdata[25] ,\adcfifo_readdata[24] ,\adcfifo_readdata[23] ,\adcfifo_readdata[22] ,\adcfifo_readdata[21] ,\adcfifo_readdata[20] ,\adcfifo_readdata[19] ,\adcfifo_readdata[18] ,\adcfifo_readdata[17] ,\adcfifo_readdata[16] ,\adcfifo_readdata[15] ,\adcfifo_readdata[14] ,\adcfifo_readdata[13] ,\adcfifo_readdata[12] ,\adcfifo_readdata[11] ,\adcfifo_readdata[10] ,\adcfifo_readdata[9] ,\adcfifo_readdata[8] ,\adcfifo_readdata[7] ,\adcfifo_readdata[6] ,\adcfifo_readdata[5] ,\adcfifo_readdata[4] ,\adcfifo_readdata[3] ,\adcfifo_readdata[2] ,\adcfifo_readdata[1] ,\adcfifo_readdata[0] ,dacfifo_write}),
    .clk_i(clk)
);

endmodule
