//module sample_switch #(
//    parameter DATA_WIDTH = 32, // 音频数据的位宽
//    parameter INTERP_FACTOR = 2, // 插值因子，可以是2、4或1/2
//    parameter FIR_TAPS = 4      // FIR滤波器的抽头数，至少为2
//) (
//    input wire clk,              // 时钟信号
//    input wire rst_n,            // 复位信号，低电平有效
//    input wire signed [DATA_WIDTH-1:0] data_in, // 输入音频数据
//    input wire sample_in,        // 输入样本时钟
//    output reg signed [DATA_WIDTH-1:0] data_out, // 输出音频数据
//    output reg sample_out        // 输出样本时钟
//);

 ////计数器和缓冲区用于实现插值和抽取
//reg [DATA_WIDTH-1:0] buffer[FIR_TAPS-1:0];
//reg [31:0] buffer_index;
//reg [31:0] interp_counter;
//reg [31:0] decim_counter;

//always @(posedge clk or negedge rst_n) begin
//    if (!rst_n) begin
   ////      同步复位
//        buffer_index <= 0;
//        interp_counter <= 0;
//        decim_counter <= 0;
//        sample_out <= 0;
//    end else begin
//        buffer[buffer_index] <= data_in;
//        buffer_index <= buffer_index + 1;

       ////  实现插值
//        if (INTERP_FACTOR == 2) begin
//            interp_counter <= (sample_in) ? (interp_counter + 1) : 0;
//            if (interp_counter == 1) begin
//                data_out <= buffer[0];
//                sample_out <= 1;
//                interp_counter <= 0;
//            end
//        end else if (INTERP_FACTOR == 4) begin
//            interp_counter <= (sample_in) ? (interp_counter + 1) : 0;
//            if (interp_counter == 3) begin
//                data_out <= buffer[0];
//                sample_out <= 1;
//                interp_counter <= 0;
//            end
//        end

        //// 实现1/2倍重采样的抽取
//        if (INTERP_FACTOR == 1/2) begin
////           decim_counter <= (sample_in) ? (decim_counter + 1) : 0;
//            if (decim_counter == 1) begin
//                data_out <= buffer[FIR_TAPS/2-1]; // 取中间抽头作为输出
//                sample_out <= 1;
//                decim_counter <= 0;
////                buffer_index <= 0; // 重置缓冲区索引
//            end else if (decim_counter == 0) begin
//                buffer_index <= 0; // 重置缓冲区索引
//            end
//        end
//    end
//end

//endmodule
