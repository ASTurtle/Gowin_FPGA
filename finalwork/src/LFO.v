module LFO #(
    parameter WIDTH = 8,          // 输出信号的位宽
    parameter PHASE_WIDTH = 16,   // 相位累加器的位宽
    parameter PHASE_INC = 1       // 每周期相位增量，实际频率可以通过修改此值来调节
) (
    input clk,                    // 时钟输入
    input rst,                    // 复位信号
    output reg signed [WIDTH-1:0] cos,  // 余弦输出
    output reg signed [WIDTH-1:0] sin   // 正弦输出
);

// 正弦查找表，可以根据需要预定义或使用ROM
reg signed [WIDTH-1:0] sine_table[0:255];
initial begin
    // 初始化正弦表
    integer i;
    for (i = 0; i < 256; i++)q begin
        sine_table[i] = $sin(2*3.141592653589793*i/256) * (2**(WIDTH-1)) - 2**(WIDTH-1);
    end
end

// 相位累加器
reg [PHASE_WIDTH-1:0] phase_acc = 0;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        phase_acc <= 0;
        cos <= sine_table[0];
        sin <= sine_table[0];
    end else begin
        // 相位累加
        phase_acc <= phase_acc + PHASE_INC;
        // 防止相位累加器溢出
        if (phase_acc >= (1 << PHASE_WIDTH) - 1) begin
            phase_acc <= 0;
        end
        // 计算正弦和余弦值
        cos <= sine_table[phase_acc[PHASE_WIDTH-1:PHASE_WIDTH-WIDTH]];
        sin <= sine_table[(phase_acc[PHASE_WIDTH-1:PHASE_WIDTH-WIDTH] + 64) % 256];
    end
end

endmodule