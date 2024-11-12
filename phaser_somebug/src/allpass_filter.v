module allpass_filter(
    input clk,
    input reset,
    input signed [15:0] input_sample,
    input signed [15:0] feedback_coefficient, // 反馈系数，由LFO调制
    output reg signed [15:0] output_sample
);
    reg signed [15:0] delay_element;

    always @(posedge clk) begin
        if (reset) begin
            delay_element <= 16'd0;
            output_sample <= 16'd0;
        end else begin
            output_sample <= input_sample + ((feedback_coefficient * delay_element)>>12);
            delay_element <= input_sample - ((feedback_coefficient * output_sample)>>12);
        end
    end
endmodule