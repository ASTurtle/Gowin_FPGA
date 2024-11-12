module ring_modulator(
    input wire clk,       // 时钟信号
    input wire reset_n,     // 复位信号，低电平有效
    input wire [15:0] ring_in,  
    //input wire frequency //频率可调
    output wire [15:0] ring_out 
);

wire ring_in,ring_out;



reg wr=0;
reg [15:0] waddr=0;
reg [15:0] wdata=0;
wire signed[5:0]sin;
RING_DDS RING_DDS(
.clk (clk),
.rstn (reset_n),
.wr (wr),
.waddr(waddr),
.wdata (wdata),
.out_valid (out_valid),
.dout (sin)
);
//后续加入串口控制频率改变，使用写数据
//改变相位增量改变频率地址0X20
 gains gain_ring (
        .clk(clk),
        .reset_n(reset_n),
        .integer_input(ring_in), // 延时后的音频数据
        .decimal_input(sin),         // 增益参数
        .result_output(ring_out)   // 增益处理后的结果
    );
endmodule