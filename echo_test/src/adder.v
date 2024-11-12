module adder(
    input clk,        // 时钟信号
    input reset_n,    // 同步复位信号
    input signed[15:0] a,   // 输入a
    input signed[15:0] b,   // 输入b
    output reg signed[15:0] sum  // 输出：17位和，包括进位
);

// 临时变量用于存储加法结果和进位
reg signed[16:0] temp_sum;

// 初始化
initial begin
    sum = 0;
end

// 行为描述
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // 如果复位信号为低，则将输出置为0
        sum = 0;
    end else begin
        // 执行加法运算，并将结果和进位存储在临时变量中
        temp_sum = a + b;
        // 将临时变量赋值给输出
        sum <= {temp_sum[16], temp_sum[15:1]};
    end
end

endmodule