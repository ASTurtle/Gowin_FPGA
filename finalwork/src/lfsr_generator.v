module lfsr_generator(
    input clk,
    input reset_n,
    output reg signed[31:0] random_bits
);

    // LFSR的初始值，应该选择一个非零值
    initial begin
        random_bits = 32'hACE1; // 一个常见的初始值
    end

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            // 如果复位信号为低，则重置LFSR的值
            random_bits <= 32'hACE1;
        end else begin
            // LFSR的反馈位，可以根据需要选择不同的位
            random_bits <= {random_bits[30:0], random_bits[31] ^ random_bits[0]};
        end
    end

endmodule