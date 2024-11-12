module gains(
    input wire [31:0] integer_input, // 32位整数输入
    input wire [3:0] decimal_input,  // 表示0.25精度的小数输入（0到10）
    output reg [31:0] result_output  // 32位整数输出
);

// 将小数输入转换为定点数
wire [31:0] decimal_fixed;
assign decimal_fixed = decimal_input * 4; // 将小数乘以4以获得定点表示

// 执行乘法并缩放结果
always @(*) begin
    // 将乘积右移两位以获得整数结果
    result_output = (integer_input * decimal_fixed) >>> 2;
end

endmodule