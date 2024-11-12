module add_sub(
    input wire clk,        // 时钟信号
    input wire reset_n,      // 复位信号，低电平有效
    input wire [31:0] a, 
    input wire [31:0]b, // 两个32位输入加数
    input wire op,         // 操作控制信号，0为加法，1为减法
    output reg [31:0] result // 输出结果
);

// 寄存器用于存储结果
reg [31:0] sum_sub;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // 如果复位信号为低，则清零结果
        sum_sub <= 32'b0;
    end else begin
        // 根据op信号执行加法或减法
        if (op) begin
            sum_sub <= a - b;
        end else begin
            sum_sub <= a + b;
        end
    end
end

// 将寄存器的值赋给输出
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        result <= 32'b0;
    end else begin
        result <= sum_sub;
    end
end

endmodule