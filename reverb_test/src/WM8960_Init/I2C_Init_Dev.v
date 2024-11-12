/*============================================================================
*
*  LOGIC CORE:          使用IIC初始化一个设备的寄存器顶层文件	
*  MODULE NAME:         I2C_Init_Dev()
*  COMPANY:             武汉芯路恒科技有限公司
*                       http://xiaomeige.taobao.com
*	author:					小梅哥
*	Website:					www.corecourse.cn
*  REVISION HISTORY:  
*
*    Revision 1.0  04/10/2019     Description: Initial Release.
*
*  FUNCTIONAL DESCRIPTION:
===========================================================================*/

module I2C_Init_Dev(
	Clk,
	Rst_n,
	
	Go,
	Init_Done,
	
	i2c_sclk,
	i2c_sdat
);

	input Clk;
	input Rst_n;
	input Go;
	output reg Init_Done;
	
	output i2c_sclk;
	inout i2c_sdat;
	
	wire [15:0]addr;
	reg wrreg_req;
	reg rdreg_req;
	wire [7:0]wrdata;
	
	wire [7:0]rddata;
	wire RW_Done;
	wire ack;
	
	wire [7:0]lut_size;	//初始化表中需要传输的数据总数
	
	reg [7:0]cnt;	//传输次数计数器
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		cnt <= 0;
	else if(Go) 
		cnt <= 0;
	else if(cnt < lut_size)begin
		if(RW_Done && (!ack))
			cnt <= cnt + 1'b1;
		else
			cnt <= cnt;
	end
	else
		cnt <= 0;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Init_Done <= 0;
	else if(Go) 
		Init_Done <= 0;
	else if(cnt == lut_size)
		Init_Done <= 1;

	reg [1:0]state;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		state <= 0;
		wrreg_req <= 1'b0;
	end
	else if(cnt < lut_size)begin
		case(state)
			0:
				if(Go)
					state <= 1;
				else
					state <= 0;
			
			1:
				begin
					wrreg_req <= 1'b1;
					state <= 2;
				end
				
			2:
				begin
					wrreg_req <= 1'b0;
					if(RW_Done)
						state <= 1;
					else
						state <= 2;
				end
				
			default:state <= 0;
		endcase
	end
	else
		state <= 0;

	wire [15:0]lut;
	wire [7:0]dev_id;
	wm8960_init_table wm8960_init_table(
		.dev_id(dev_id),
		.lut_size(lut_size),
		
		.addr(cnt),
		.clk(Clk),
		.q(lut)
	);
	
	assign addr = lut[15:8];
	assign wrdata = lut[7:0];
	
	i2c_control i2c_control(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.wrreg_req(wrreg_req),
		.rdreg_req(0),
		.addr(addr),
		.addr_mode(0),
		.wrdata(wrdata),
		.rddata(rddata),
		.device_id(dev_id),
		.RW_Done(RW_Done),
		.ack(ack),		
		.i2c_sclk(i2c_sclk),
		.i2c_sdat(i2c_sdat)
	);

endmodule
