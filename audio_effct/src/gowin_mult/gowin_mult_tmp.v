//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.02
//Part Number: GW5A-LV25UG324C2/I1
//Device: GW5A-25
//Device Version: A
//Created Time: Sat Oct 19 16:50:51 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Gowin_MULT your_instance_name(
        .dout(dout), //output [31:0] dout
        .a(a), //input [15:0] a
        .b(b), //input [15:0] b
        .clk(clk), //input clk
        .ce(ce), //input ce
        .reset(reset) //input reset
    );

//--------Copy end-------------------