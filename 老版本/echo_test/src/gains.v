module gains(
    input clk,
    input reset_n,
    input wire [15:0] integer_input, // 32位整数输入
    input wire [5:0] decimal_input,  // 表示0.125精度的小数输入（0到10）
    output reg [15:0] result_output  // 32位整数输出
);
reg [23:0]process_data;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        result_output <= 0;
    end
    else begin
        // 将乘积右移两位以获得整数结果
        process_data = (integer_input * decimal_input)>>3;//
        result_output<=process_data[15:0];
    end
end
endmodule