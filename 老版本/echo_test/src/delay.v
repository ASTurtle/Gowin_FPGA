module delay(
    input wire clk,       // 时钟信号
    input wire reset_n,     // 复位信号，低电平有效
    input wire [31:0] in,  // 32位输�?
    input wire [11:0] delay_num,  //延时时间
    output wire [31:0] out, // 32位输�?
    output wire Almost_Full,
    output  wire Almost_Empty,
    output wire fifoFull
);

// // 计数器，用于实现延时
// reg [7:0] counter; // 8位计数器，足以计数到256

// // 寄存器数组，用于实现256周期的延�??
// reg [31:0] shift_reg[255:0];

// // 时钟沿边触发的寄存器，用于存储下�??个要输出的�??
// reg [31:0] next_out;

wire [15:0] Rnum,Wnum;
wire fifoEmpty;
reg WrEn,RdEn;

always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        WrEn <=  0;
        RdEn <= 0;
    end
    else begin
        WrEn <= 1;
        if(fifoFull) begin
            RdEn <= 1;
        end
        else begin
            RdEn <= 0;
        end
    end

end
/*用高云fifo ip核实现延�??*/
delay_fifo my_audio_delay1(
		.Data(in), //input [31:0] Data
		.WrClk(clk), //input WrClk
		.RdClk(clk), //input RdClk
		.WrEn(WrEn), //input WrEn
		.RdEn(RdEn), //input RdEn
		.AlmostEmptyTh(delay_num), //input [11:0] AlmostEmptyTh
		.AlmostFullTh(delay_num), //input [11:0] AlmostFullTh
		.Wnum(Wnum), //output [12:0] Wnum
		.Rnum(Rnum), //output [12:0] Rnum
		.Almost_Empty(Almost_Empty), //output Almost_Empty
		.Almost_Full(Almost_Full), //output Almost_Full
		.Q(out), //output [31:0] Q
		.Empty(fifoEmpty), //output Empty
		.Full(fifoFull) //output Full
	);
// /*用vivado仿真时使用xilinx ip�??*/
// fifo_generator_0 my_audio_delay1 (
//   .clk(clk),                    // input wire clk
//   .srst(reset_n),                  // input wire srst
//   .din(in),                    // input wire [31 : 0] din
//   .wr_en(WrEn),                // input wire wr_en
//   .rd_en(RdEn),                // input wire rd_en
//   .dout(out),                  // output wire [31 : 0] dout
//   .full(fifoFull),                  // output wire full
//   .almost_full(Almost_Full),    // output wire almost_full
//   //.wr_ack(wr_ack),              // output wire wr_ack
//   .empty(fifoEmpty),                // output wire empty
//   .almost_empty(Almost_Empty)  // output wire almost_empty
//   //.valid(valid),                // output wire valid
//   //.prog_full(prog_full),        // output wire prog_full
//   //.prog_empty(prog_empty)      // output wire prog_empty
// );

/*原本的延�??*/
//integer i; // 将循环变量声明移到这�??
//always @(posedge clk or negedge reset_n) begin
//    if (!reset_n) begin
//        counter <= 8'd0;
//        next_out <= 32'd0;
//         清空移位寄存�??
//        for (i = 0; i < 256; i = i + 1) begin
//            shift_reg[i] <= 32'd0;
//        end
//    end else begin
//         移位操作
//        if (counter == 0) begin
//             当计数器�??0时，加载新数据到移位寄存器的第一�??
//            shift_reg[0] <= in;
//            next_out <= shift_reg[255]; // 将最后一位的值赋给next_out
//          counter <= 8'd255; // 重置计数�??
//        end else begin
//            counter <= counter - 1; // 计数器�?�减
//             将移位寄存器的内容向前移动一�??
//            for (i = 255; i > 0; i = i - 1) begin
//                shift_reg[i] <= shift_reg[i-1];
//            end
//            shift_reg[0] <= 32'd0; // 清零�??前面的寄存器
//        end
//    end
//end

// 更新输出�??
//always @(posedge clk or negedge reset_n) begin
//    if (!reset_n) begin
//        out <= 32'd0;
//    end else begin
//        out <= next_out;
//    end
//end
/*原本的延�??*/
endmodule