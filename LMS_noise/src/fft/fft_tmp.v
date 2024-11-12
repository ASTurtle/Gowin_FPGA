//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.02
//Part Number: GW5A-LV25UG324C2/I1
//Device: GW5A-25
//Device Version: A
//Created Time: Fri Oct 11 22:59:52 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	FFT_Top your_instance_name(
		.idx(idx), //output [9:0] idx
		.xk_re(xk_re), //output [15:0] xk_re
		.xk_im(xk_im), //output [15:0] xk_im
		.sod(sod), //output sod
		.ipd(ipd), //output ipd
		.eod(eod), //output eod
		.busy(busy), //output busy
		.soud(soud), //output soud
		.opd(opd), //output opd
		.eoud(eoud), //output eoud
		.xn_re(xn_re), //input [15:0] xn_re
		.xn_im(xn_im), //input [15:0] xn_im
		.start(start), //input start
		.clk(clk), //input clk
		.rst(rst) //input rst
	);

//--------Copy end-------------------
