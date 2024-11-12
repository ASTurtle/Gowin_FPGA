module switch_module #(
    parameter DATA_WIDTH = 32// 数据位宽
    //parameter THRESHOLD =  1 // 阈值参数
)(
    input wire clk,           // 时钟信号
    input wire rst_n,         // 复位信号，低电平有效
    input wire [DATA_WIDTH-1:0] data_in1, // 输入1
    input wire [DATA_WIDTH-1:0] data_in3, // 输入3
    input wire [DATA_WIDTH-1:0] control_in2, // 控制输入2
    output reg [DATA_WIDTH-1:0] data_out // 输出
);
//用作控制模块，联合上位机使用
// 根据控制输入2的条件选择输出
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // 同步复位
        data_out <= {DATA_WIDTH{1'b0}};
    end else begin
        if (control_in2 ) begin
            data_out <= data_in1; // 如果u2 = 1，输入1通过
        end else begin
            data_out <= data_in3; // 否则，输入3通过
        end
    end
end

endmodule