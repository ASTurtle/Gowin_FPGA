module noise_audio(
    input clk,
    input reset_n,
    input [31:0] input_audio,
    output signed[31:0] noise_audio,
    output [31:0] random_bits
);

    // 实例化LFSR生成器
    lfsr_generator lfsr_0(
        .clk(clk),
        .reset_n(reset_n),
        .random_bits(random_bits)
    );

    // 实例化加法器模块
    adder adder_0(
        .clk(clk),
        .reset_n(reset_n),
        .a(input_audio[15:0]),
        .b(random_bits[15:0]>>7),
        .sum(noise_audio[15:0])
    );
    adder adder_1(
        .clk(clk),
        .reset_n(reset_n),
        .a(input_audio[31:16]),
        .b(random_bits[31:16]>>7),
        .sum(noise_audio[31:16])
    );

endmodule