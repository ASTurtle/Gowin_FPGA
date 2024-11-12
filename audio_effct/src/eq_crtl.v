module eq_crtl(
    input clk,
    input reset_n,
    input en,
    input [15:0] data_in,
    input [39:0] gain_all,
    output in_ready,
    output reg out_valid,
    output reg [15:0] data_out
);
    wire [3:0] gain_data [9:0];
    reg in_valid;
    wire gain_reload;
    reg gainwe;
    reg gainset;
    reg [3:0] gain;
    wire [15:0] din;
    wire [18:0] dout;
    wire in_ready;
    // 定义状态机状态
    parameter IDLE = 2'b00,
          LOAD_GAIN = 2'b01,
          PROCESS_DATA = 2'b10;
    reg [1:0] state, next_state;
    reg [3:0] gain_index;
    reg [3:0] current_gain;
    assign gain_data[0] = gain_all[3:0];
    assign gain_data[1] = gain_all[7:4];
    assign gain_data[2] = gain_all[11:8];
    assign gain_data[3] = gain_all[15:12];
    assign gain_data[4] = gain_all[19:16];
    assign gain_data[5] = gain_all[23:20];
    assign gain_data[6] = gain_all[27:24];
    assign gain_data[7] = gain_all[31:28];
    assign gain_data[8] = gain_all[35:32];
    assign gain_data[9] = gain_all[39:36];
    // 状态机逻辑
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= IDLE;
            gain_index <= 0;
            gainwe <= 0;
            gainset <= 0;
            out_valid <= 0;
            data_out <= 0;
            current_gain <= 0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    if (en) begin
                        next_state <= LOAD_GAIN;
                        gainwe <= 1;
                        gain_index <= 0;
                    end else begin
                        next_state <= IDLE;
                        data_out <= data_in;
                    end
                end
                LOAD_GAIN: begin
                    gainwe <= 1;
                    gainset<=0;
                    gain <= gain_index;
                    current_gain <= gain_data[gain_index];
                    if (gain_index == 9) begin
                        next_state <= PROCESS_DATA;
                        gainwe <= 1;
                        gainset <= 0;
                    end else begin
                        gain_index <= gain_index + 1;
                    end
                end
                PROCESS_DATA: begin
                    gainwe <= 0;
                    gainset <= 1;
                     // 设置 in_valid 为高电平
                    out_valid <= 1;
                    data_out <= dout[18:3];
                    if(in_ready)
                        in_valid <= 1; 
                    else
                        in_valid <=0;
                    if (!en) begin
                    next_state <= IDLE;
                    end
                end
            endcase
        end
    end

    // 实例化 Equalizer_Top 模块
    Equalizer_Top U1(
        .clk(clk),                 // 时钟信号
        .rstn(reset_n),            // 复位信号（低电平有效）
        .ce(en),                   // 时钟使能信号
        .in_valid(in_valid),       // 高电平时表示此时输入数据有效
        .din(data_in),               // 输入信号
        .gainwe(gainwe),           // 载入gain时置为高电平
        .gainset(gainset),         // 载入gain完成后下一个时钟周期置为高电平，表示gain载入完成
        .gain(current_gain),       // 输入gain信号编号
        .in_ready(in_ready),       // 可输入指示信号，高电平时表示数据可以输入
        .out_valid(),     // 输出有效信号，高电平时表示此时输出信号为有效值
        .dout(dout)                // 输出信号
    );

endmodule