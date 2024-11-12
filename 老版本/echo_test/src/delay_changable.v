module delay(
    input wire clk,       // 时钟信号
    input wire reset_n,     // 复位信号，低电平有效
    input wire [31:0] in,  // 32位输入
    output reg [31:0] out // 32位输出
);

// 计数器，用于实现延时
reg [7:0] counter; // 8位计数器，足以计数到256

// 寄存器数组，用于实现256周期的延时
reg [31:0] shift_reg[255:0];

// 时钟沿边触发的寄存器，用于存储下一个要输出的值
reg [31:0] next_out;

// 复位操作
integer i; // 将循环变量声明移到这里
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        counter <= 8'd0;
        next_out <= 32'd0;
        // 清空移位寄存器
        for (i = 0; i < 256; i = i + 1) begin
            shift_reg[i] <= 32'd0;
        end
    end else begin
        // 移位操作
        if (counter == 0) begin
            // 当计数器为0时，加载新数据到移位寄存器的第一位
            shift_reg[0] <= in;
            next_out <= shift_reg[255]; // 将最后一位的值赋给next_out
            counter <= 8'd255; // 重置计数器
        end else begin
            counter <= counter - 1; // 计数器递减
            // 将移位寄存器的内容向前移动一位
            for (i = 255; i > 0; i = i - 1) begin
                shift_reg[i] <= shift_reg[i-1];
            end
            shift_reg[0] <= 32'd0; // 清零最前面的寄存器
        end
    end
end

// 更新输出值
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        out <= 32'd0;
    end else begin
        out <= next_out;
    end
end

endmodule