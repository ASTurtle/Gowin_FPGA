module add_0(
    input wire clk,        // 时钟信号
    input wire reset_n,      // 复位信号，低电平有效
    input wire [15:0] a, 
    input wire [15:0]b, // 两个32位输入加数
    output reg [16:0] result // 输出结果
);

// 寄存器用于存储结果
reg [16:0] sum_0;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // 如果复位信号为低，则清零结果
        sum_0 <= 17'b0;
    end else begin
         
            sum_0 <= a + b;
        
    end
end

// 将寄存器的值赋给输出
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        result <= 17'b0;
    end else begin
        result <= sum_0;
    end
end

endmodule