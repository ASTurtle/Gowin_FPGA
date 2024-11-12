module uart_cmd
#(
    parameter TOU = 8'hdd,
    parameter WEI = 8'hee
)
(
    Clk,
    Rst_n,
    uart_rx,
    
    my_uart_data,
    out_valid
 );
 
    parameter DATA_WIDTH = 256;
	parameter MSB_FIRST = 1;
	
    input Clk;
    input Rst_n;
    input uart_rx;
    
    output reg [239:0] my_uart_data;
    output reg out_valid;

    wire [DATA_WIDTH-1:0]rx_data;
    wire Rx_Done;
    wire [7:0]data_byte;
    reg bled;
    reg [7:0] bp;
    reg [7:0] ban;
    uart_data_rx 
    #(
		.DATA_WIDTH(DATA_WIDTH),
		.MSB_FIRST(MSB_FIRST)		
	)
	uart_data_rx(
        .Clk(Clk),
        .Rst_n(Rst_n),
        .uart_rx(uart_rx),
        
        .data(rx_data),
        .Rx_Done(Rx_Done),
        .timeout_flag(),
        
        .Baud_Set(3'd0)
     );
     always @(posedge Clk) 
    begin
        //换个时钟，把bps_clk拿来用
        //头帧DD,尾帧EE
        if((rx_data[255:248]==TOU) && (rx_data[7:0]==WEI)) 
        begin
            out_valid <= 1;
            my_uart_data <= rx_data[247:8];
        end
         else begin
                out_valid <= 0;
         end
    end  
    
    
endmodule
