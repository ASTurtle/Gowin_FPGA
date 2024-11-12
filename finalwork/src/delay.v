module delay(
    input wire clk,       // 时钟信号
    input wire reset_n,     // 复位信号，低电平有效
    input wire [15:0] in,  // 32位输入
    input wire [12:0] delay_num,  //延时时间
    output wire [15:0] out // 32位输出
);
wire [15:0] Rnum,Wnum;
wire fifoEmpty,fifoFull,Almost_Full,Almost_Empty;
reg WrEn,RdEn;

always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        WrEn <=  0;
        RdEn <= 0;
    end
    else begin
        WrEn <= 1;
        if(Almost_Full) begin
            RdEn <= 1;
        end
        else begin
            RdEn <= 0;
        end
    end

end






fifo_4096 delay_0(
		.Data(in), //input [31:0] Data
		.WrClk(clk), //input Wrclk
		.RdClk(clk), //input Rdclk
		.WrEn(WrEn), //input WrEn
		.RdEn(RdEn), //input RdEn
//		.AlmostEmptyTh(delay_num), //input [11:0] AlmostEmptyTh
		.AlmostFullTh(delay_num), //input [11:0] AlmostFullTh
		//.Wnum(Wnum), //output [12:0] Wnum
		//.Rnum(Rnum), //output [12:0] Rnum
		.Almost_Empty(Almost_Empty), //output Almost_Empty
		.Almost_Full(Almost_Full), //output Almost_Full
		.Q(out), //output  Q
		.Empty(fifoEmpty), //output Empty
		.Full(fifoFull) //output Full
	);



endmodule