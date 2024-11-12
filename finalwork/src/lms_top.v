module lms_top(
    input clk,
    input reset_n,
    input [15:0]audio_in,
    input en,
    input switch,
    output reg[15:0]audio_out
);
wire [15:0]yout_0,err_0,audio_in,audio_noise;
reg [15:0]din_0,xin_0;
lms lms_0(
    .clk(clk),
    .rst_n(reset_n),
    .en(en),
    .din(din_0),//noise
    .xin(xin_0),//audio_in
    .u(7'd10),
    .yout(yout_0),//去噪
    .err(err_0),//两个信号差值
    .wout(wout_0),
    .update(update)  
);

noise_audio noise_audio (
    .clk(clk),
    .reset_n(reset_n),
    .input_audio(audio_in),
    .random_bits(random_bits),
    .noise_audio(audio_noise)
);
always @ (posedge clk or negedge reset_n)
	begin
		if(~reset_n)
		audio_out<=0;
        else if (en)   begin
        if (switch)begin
            xin_0<=audio_in;
            din_0<=audio_noise;
            audio_out<=yout_0;
        end
        else begin
            audio_out<=audio_noise;
        end       
	end
    else begin
            audio_out<=audio_in;
        end
end
endmodule