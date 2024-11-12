//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.02
//Part Number: GW5A-LV25UG324C2/I1
//Device: GW5A-25
//Device Version: A
//Created Time: Sat Oct 26 10:45:03 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	DDS_phaser your_instance_name(
		.clk(clk), //input clk
		.rstn(rstn), //input rstn
		.wr(wr), //input wr
		.waddr(waddr), //input [15:0] waddr
		.wdata(wdata), //input [31:0] wdata
		.dout(dout), //output [11:0] dout
		.out_valid(out_valid) //output out_valid
	);

//--------Copy end-------------------
