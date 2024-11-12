module sample_switch #(
    parameter DATA_WIDTH = 32, // 音频数据的位宽
     parameter FILTER_IN_BITS = 16,
    parameter FILTER_OUT_BITS = 16,
    parameter NUMBER_OF_FILTERS =8,//5种情况的滤波器
     parameter COEFF_FRAC_BITS = 16,////滤波器的小数位数
    parameter NUMBER_OF_TAPS=64,//滤波器的阶数
    parameter COEFF_BITS = 16,//滤波器系数
    parameter COUNTER_MIN = 6'b000000,
    parameter COUNTER_MAX = 6'b111111,
    parameter COUNTER_BITS = $clog2(COUNTER_MAX),
   parameter FILTER_COEFFS_TXT = "C:/Users/Asus/Desktop/sample_filters_coeffs3.0.txt"  //存储滤波器系数的文件
) (
    input wire clk,              // 50M时钟信号
    input clk_enable,           //时钟有效
    input wire sample_clk,       // 12.288M时钟
    input wire reset_n,          // 复位信号，低电平有效
    input wire signed [DATA_WIDTH-1:0] data_in, // 输入音频数据
    input wire sample_in,        // 输入样本时钟
    input wire unsigned [2:0] inte_deci_num,     // 插值或抽取因子，0:1536k、1:768k、2:384k、3:192k、4:96k、5:48k、6:24k、7：12k
    output reg signed [DATA_WIDTH-1:0] data_out, // 输出音频数据
    output reg [31:0]filtered_data_out,
    output reg factor_clk        // 输出样本时钟
);
    wire [COUNTER_BITS-1:0] current_count;
    wire phase_min; 
    wire [15:0]filter_out_0,filter_out_1;
    reg[31:0]filter_in;
    reg[31:0]down_filter_out;
    wire [31:0]filter_out;
    reg [10:0] counter_0; // 用于计数输出样本
    reg [10:0] counter_1; // 用于计数输出样本
    reg [10:0] counter_2; // 用于计数输出样本
    reg [10:0] factor;  // 插值或抽取
    //reg factor_clk;// 用于输出sample_out,同时可以判断当前是否为输出采样点
    reg signed [DATA_WIDTH-1:0] zero_sample = 0; // 零样本，用于插值
    reg clk_stand;
    reg clk_stand_pst;   
    reg [COEFF_BITS*NUMBER_OF_TAPS-1:0] coeffs[0:NUMBER_OF_FILTERS-1];
always @(posedge sample_clk or negedge reset_n) begin
    if (!reset_n) begin
        counter_0<=0;
        factor_clk<=0;
    end else begin 
        factor <= 1<<(inte_deci_num+2);
        if(counter_0==factor-1)begin
            factor_clk<= ~factor_clk;
             counter_0<=0;
        end else begin
             counter_0<=counter_0+1;
         end    
    end
end

always @(posedge sample_clk or negedge reset_n) begin
    if (!reset_n) begin
        counter_1<=0;
        clk_stand<=0;
    end else begin
        if(counter_1==127)begin
            clk_stand<= ~clk_stand;
             counter_1<=0;
        end else begin
             counter_1<=counter_1+1;    
        end
    end
end
always @(posedge sample_clk or negedge reset_n) begin
    if (!reset_n) begin
        counter_2<=128;
        clk_stand_pst<=0;
    end else begin
        if(counter_2==255)begin
            clk_stand_pst<= ~clk_stand_pst;
             counter_2<=0;
        end else begin
            clk_stand_pst<=0;
             counter_2<=counter_2+1;    
        end
    end
end
always @(negedge factor_clk or negedge reset_n) begin
    if (!reset_n) begin
        data_out<=0;
    end else if (inte_deci_num<=4) begin 
    if(clk_stand_pst)begin
            data_out<=data_in;
        end else begin
            data_out<=zero_sample;
        end
    end
end
always @(negedge factor_clk or negedge reset_n) begin
    if (!reset_n) begin
       filtered_data_out<=0;
        filter_in<=0;
        down_filter_out<=0;
    end else if (inte_deci_num<=4) begin
                filter_in<=data_out;
               filtered_data_out[15:0] <=filter_out_0;
               filtered_data_out[31:16] <=filter_out_1;
        end
    else begin filter_in<=data_in;
            down_filter_out[15:0] <=filter_out_0;
            down_filter_out[31:16] <=filter_out_1;
            filtered_data_out<=down_filter_out;
    end
end
initial begin
    // read coeffs for each filter from text file
    $readmemb(FILTER_COEFFS_TXT, coeffs);
  end
counter #(
      .COUNTER_MIN(COUNTER_MIN),
      .COUNTER_MAX(COUNTER_MAX)
  ) counter (
      .clk(clk),
      .clk_enable(clk_enable),
      .rst(!reset_n),
      .current_count(current_count),
      .phase_min(phase_min)
  );
filter #(
          .FILTER_IN_BITS(FILTER_IN_BITS),
          .FILTER_OUT_BITS(FILTER_OUT_BITS),
          .COUNTER_BITS(COUNTER_BITS),
          .NUMBER_OF_TAPS(NUMBER_OF_TAPS),
          .COEFF_BITS(COEFF_BITS),
          .COEFF_FRAC_BITS(COEFF_FRAC_BITS)
      ) filter_0 (
          .clk(clk),
          .rst(!reset_n),
          .clk_enable(clk_enable),
          .phase_min(phase_min),
          .amplified_filter_in(filter_in[15:0]),
          .current_count(current_count),
          .coeffs_feed(coeffs[inte_deci_num]),
          .filtered_out(filter_out_0)
      );
filter #(
          .FILTER_IN_BITS(FILTER_IN_BITS),
          .FILTER_OUT_BITS(FILTER_OUT_BITS),
          .COUNTER_BITS(COUNTER_BITS),
          .NUMBER_OF_TAPS(NUMBER_OF_TAPS),
          .COEFF_BITS(COEFF_BITS),
          .COEFF_FRAC_BITS(COEFF_FRAC_BITS)
      ) filter_1 (
          .clk(clk),
          .rst(!reset_n),
          .clk_enable(clk_enable),
          .phase_min(phase_min),
          .amplified_filter_in(filter_in[31:16]),
          .current_count(current_count),
          .coeffs_feed(coeffs[inte_deci_num]),
          .filtered_out(filter_out_1)
      );
endmodule