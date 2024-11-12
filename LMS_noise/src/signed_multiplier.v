module signed_multiplier (
    input signed [15:0] a, // 16位有符号输入a
    input signed [15:0] b, // 16位有符号输入b
    output signed [31:0] result // 32位有符号输出result
);

    assign result = a * b; // 使用Verilog内置乘法操作符进行有符号乘法

endmodule