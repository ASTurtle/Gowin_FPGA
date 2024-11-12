module volume(
    input clk,
    input reset_n,
    input wire signed[31:0] integer_input, 
    input wire signed[5:0] decimal_input,  
    output reg signed[31:0] result_output  
);
reg signed[21:0]process_data_0 = 0;
reg signed[21:0]process_data_1 = 0;
reg signed[15:0]input_0=0;
reg signed[15:0]input_1=0;
always @(posedge clk or negedge reset_n) begin
   //process_data <= 0;
    if(!reset_n) begin
        result_output = 0;
    end
    else begin
        input_0 <=integer_input[15:0];
        input_1 <=integer_input[31:16];
        // 将乘积右移两位以获得整数结果
        process_data_0 = input_0 * decimal_input ;
        process_data_1 = input_1 * decimal_input ;
        result_output = {process_data_1[21],process_data_1[19:5],process_data_0[21],process_data_0[19:5]};
    end
end
endmodule