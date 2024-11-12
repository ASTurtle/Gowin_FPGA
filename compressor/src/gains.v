module gains(
    input clk,
    input reset_n,
    input wire signed[15:0] integer_input, 
    input wire signed[5:0] decimal_input,  
    output reg signed[15:0] result_output  
);
reg signed[21:0]process_data = 0;
always @(posedge clk or negedge reset_n) begin
   //process_data <= 0;
    if(!reset_n) begin
        result_output = 0;
    end
    else begin
        // 将乘积右移两位以获得整数结果
        process_data = integer_input * decimal_input ;
        result_output = {process_data[21],process_data[19:5]};
    end
end
endmodule