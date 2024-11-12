
module gains(
    input clk,
    input reset_n,
    input wire signed[15:0] integer_input, 
    input wire signed[5:0] decimal_input,  
    output reg signed[15:0] result_output  
);
reg signed[21:0]process_data = 0;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        result_output = 0;
    end
    else begin
         //将乘积右移两位以获得整数结果
        process_data = integer_input * decimal_input ;
        result_output = {process_data[21],process_data[19:5]};
    end
end
endmodule


///////////////////////////////
//组合逻辑,有延迟，不好听
//module gains (
//    input clk,
//    input reset_n,
//    input wire signed [15:0] integer_input,  // 16位有符号数
//    input wire signed [5:0] decimal_input,   // 6位有符号数
//    output wire signed [15:0] result_output  // 22位有符号数
//);
     ////临时变量用于存储乘积的中间结果
//    reg signed [21:0] temp_product;
//    reg signed [21:0] term;
//    integer i;

     ////初始化输出乘积的符号
//    wire signed [21:0] sign_ext_a = {{6{integer_input[15]}}, integer_input}; // 将a扩展到22位
//    wire signed [21:0] sign_ext_b = {{16{decimal_input[5]}}, decimal_input}; // 将b扩展到22位

     ////初始化乘积为0
//    initial temp_product = 22'sb0;

     ////计算乘积的绝对值
//    always @(posedge clk or negedge reset_n) begin
//      if(!reset_n) begin
//        temp_product <= 22'sb0;
//      end else begin
//        temp_product = 22'sb0; // 重置乘积
//        for (i = 0; i < 6; i=i+1) begin
            //// 检查b的每一位是否为1
//            if (decimal_input[i]) begin
                //// 如果为1，则将a左移i位并加到乘积中
//                term = sign_ext_a << i;
//                temp_product = temp_product + term;
//            end
//        end
//    end
//    end
//    wire signed [21:0] product;
     ////根据输入数的符号确定最终乘积的符号
//    assign product = (integer_input[15] == decimal_input[5]) ? temp_product : -temp_product;
//    assign result_output = product[19:5];
//endmodule