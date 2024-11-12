//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.02
//Part Number: GW5A-LV25UG324C2/I1
//Device: GW5A-25
//Device Version: A
//Created Time: Thu Oct  3 22:19:09 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	delay_fifo your_instance_name(
		.Data(Data), //input [31:0] Data
		.WrClk(WrClk), //input WrClk
		.RdClk(RdClk), //input RdClk
		.WrEn(WrEn), //input WrEn
		.RdEn(RdEn), //input RdEn
		.AlmostEmptyTh(AlmostEmptyTh), //input [11:0] AlmostEmptyTh
		.AlmostFullTh(AlmostFullTh), //input [11:0] AlmostFullTh
		.Wnum(Wnum), //output [12:0] Wnum
		.Rnum(Rnum), //output [12:0] Rnum
		.Almost_Empty(Almost_Empty), //output Almost_Empty
		.Almost_Full(Almost_Full), //output Almost_Full
		.Q(Q), //output [31:0] Q
		.Empty(Empty), //output Empty
		.Full(Full) //output Full
	);

//--------Copy end-------------------
