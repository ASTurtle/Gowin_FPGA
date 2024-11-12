module all_pass_filter(
    input clk,
    input reset_n, // 低电平有效的复位信号
    input signed [15:0] input_sample,
    input signed [11:0] feedback_coefficient, // 反馈系数
    output reg signed [15:0] output_sample
);
    reg signed [15:0] delay_element;
    reg signed[26:0]coe_delay;
    reg signed[26:0]coe_out;
    reg signed[26:0]input_fan;
    reg signed [11:0] feedback_fan;
    reg signed [15:0]process_data;
    wire signed [11:0] feedback_coefficient;
    reg signed [15:0] output_sample;
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            delay_element <= 16'd0;
            output_sample <= 16'd0;
            feedback_fan <= 12'd0;
            coe_delay<=27'd0;
             input_fan<=27'd0;
            coe_out<=27'd0;
        end else begin
            // 对无符号数执行按位取反操作
            // 将取反后的无符号数转换回有符号数
            feedback_fan <= {feedback_coefficient[11],~(feedback_coefficient[10:0])};
            coe_delay<=feedback_coefficient * delay_element;
             coe_out<=feedback_coefficient * output_sample;
              input_fan<=feedback_fan * input_sample;
              process_data<=(coe_delay>>18);
         //  output_sample <= (input_fan + coe_delay)>>16;
          // delay_element <= (input_fan - coe_out)>>16;
            output_sample <= input_sample ;//- process_data;
          delay_element <= output_sample;
        end
    end
endmodule