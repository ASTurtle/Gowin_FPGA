`timescale 1 ps / 1 ps
// synopsys translate_on
module mult16 (
    clk,
    reset_n,
	dataa,
	datab,
	result);

	input	[15:0]  dataa;
	input	[15:0]  datab;
	output	[31:0]  result;
    input wire clk,reset_n;
	wire [31:0] sub_wire0;
	wire [31:0] result = sub_wire0[31:0];

	signed_multiplier lpm_mult (
    .result(sub_wire0),
    .a(dataa), 
    .b(datab));
endmodule