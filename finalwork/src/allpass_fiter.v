module allpass_filter(
    input clk,
    input reset,
    input signed [15:0] input_sample,
    input signed [15:0] feedback_coefficient, // 反馈系数，由LFO调制
    output  signed [15:0] output_sample
);
    reg signed [15:0] delay_element;
    wire signed [15:0] feedback;
    assign feedback =  ((feedback_coefficient * delay_element)>>>15);
    assign output_sample = delay_element - feedback;


    always @(posedge clk) begin
        delay_element <= input_sample + feedback;
    end
endmodule