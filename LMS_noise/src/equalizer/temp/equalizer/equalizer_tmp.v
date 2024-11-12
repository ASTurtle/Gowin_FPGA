//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.02
//Part Number: GW5A-LV25UG324C2/I1
//Device: GW5A-25
//Device Version: A
//Created Time: Tue Oct  8 18:19:21 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Equalizer your_instance_name(
		.clk(clk), //input clk
		.rstn(rstn), //input rstn
		.ce(ce), //input ce
		.in_valid(in_valid), //input in_valid
		.din(din), //input [15:0] din
		.gainwe(gainwe), //input gainwe
		.gainset(gainset), //input gainset
		.gain(gain), //input [2:0] gain
		.in_ready(in_ready), //output in_ready
		.out_valid(out_valid), //output out_valid
		.dout(dout) //output [18:0] dout
	);

//--------Copy end-------------------
