module delay_changable #(
    parameter DELAY_WIDTH = 12,  // 最大延迟的位宽
    parameter DATA_WIDTH = 16
)
(
    input                       clk,
    input                       rst_n,
    input   [DELAY_WIDTH-1:0]   delay,
    input   [DATA_WIDTH-1:0]    inputData,
    output  [DATA_WIDTH-1:0]    outputData,
    output                      delayFull
);

localparam ADDRWIDTH = DELAY_WIDTH - 1;

reg [ADDRWIDTH:0] wr_ptr_reg = {DELAY_WIDTH{1'b0}};
reg [ADDRWIDTH:0] rd_ptr_reg = {DELAY_WIDTH{1'b0}};
reg [ADDRWIDTH:0] delayReg0;
reg [ADDRWIDTH:0] delayReg1;
reg [DATA_WIDTH-1:0] outputDataTemp;
reg [DATA_WIDTH-1:0] mem[(1<<DELAY_WIDTH)-1:0];

wire empty;
wire full;
wire wr_req;
wire rd_req;
wire delayChange;
wire dropData;

assign empty = (wr_ptr_reg == rd_ptr_reg);
assign full  = (wr_ptr_reg + 1 == rd_ptr_reg);
assign wr_req = 1'b1;
assign rd_req = (rd_ptr_reg + delay == wr_ptr_reg) || full;
assign delayFull = full;
assign delayChange = (delayReg1 != delayReg0);
assign dropData = delayChange && (delayReg1 > delayReg0);
assign outputData = rd_req ? ((delay == {DELAY_WIDTH{1'b0}}) ? inputData : outputDataTemp) : {DATA_WIDTH{1'b0}};

// 延迟寄存器更新
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        delayReg0 <= {DELAY_WIDTH{1'b0}};
        delayReg1 <= {DELAY_WIDTH{1'b0}};
    end else begin
        delayReg0 <= delay;
        delayReg1 <= delayReg0;
    end
end

// 写指针和读指针更新
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        wr_ptr_reg <= {DELAY_WIDTH{1'b0}};
        rd_ptr_reg <= {DELAY_WIDTH{1'b0}};
        outputDataTemp <= {DATA_WIDTH{1'b0}};
    end else begin
        if (wr_req) begin
            mem[wr_ptr_reg] <= inputData;
            wr_ptr_reg <= wr_ptr_reg + 1'b1;
        end

        if (rd_req) begin
            outputDataTemp <= mem[rd_ptr_reg];
            rd_ptr_reg <= rd_ptr_reg + 1'b1;
        end else if (dropData) begin
            rd_ptr_reg <= rd_ptr_reg + delayReg1 - delayReg0 + 2'd2;
        end
    end
end

endmodule