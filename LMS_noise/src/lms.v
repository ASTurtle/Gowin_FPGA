module lms
#(
parameter	X_W	=	16					,
parameter	E_W	=	16					,
parameter	W_W	=	16					,
parameter	O_N	=	16					,
parameter	D_W	=	16		
)
(
	input						clk			,
	input						rst_n		,
	input						en			,
	
	input			[ 7:0]		u			,
	input	signed	[X_W-1:0]	xin			,
	input	signed	[D_W-1:0]	din			,
	output 	reg	signed[E_W-1:0]	err			,
	output	reg				   	update		,
	output	signed[W_W*O_N-1:0]	wout		,
	output	signed[D_W-1:0]		yout		
);

reg	signed		[E_W-1:0]		err_tmp		;
wire							en_i		;
reg	signed		[D_W-1:0]		d_r			;
wire							lms_up		;
wire signed		[D_W-1:0]		lms_yout	;

assign yout = lms_yout	;
assign en_i = en		;

lms16_order 
#(
.X_W(X_W	)			,
.E_W(E_W	)			,
.W_W(W_W	)			,
.Y_W(D_W	)			
)
l_inst
(
	.clk		(clk)	,
	.rst_n		(rst_n)	,
	.en_i		(en_i)	,
	.xin		(xin)	,
	.err		(err_tmp),
	.update		(lms_up),
	.xnxt		()		,	
	.wout		(wout)	,
	.yout		(lms_yout)
);

always @ (posedge clk or negedge rst_n)
begin
	if (!rst_n)
	begin
		update		<=		1'b0;
		err			<=		'd0;
		d_r			<=		'd0;
	end
	else if (lms_up)
	begin
		update		<=		1'b1;
		err			<=		d_r	-	lms_yout;
		d_r			<=		din;
	end
	else
	begin
		update		<=		1'b0;
	end
end


always @ (*)
case (u)
8'd0: err_tmp	<=		err;
8'd1: err_tmp	<=		{err[E_W-1],err[E_W-1:1]};
8'd2: err_tmp	<=		{{2{err[E_W-1]}},err[E_W-1:2]};
8'd3: err_tmp	<=		{{3{err[E_W-1]}},err[E_W-1:3]};
8'd4: err_tmp	<=		{{4{err[E_W-1]}},err[E_W-1:4]};
8'd5: err_tmp	<=		{{5{err[E_W-1]}},err[E_W-1:5]};
8'd6: err_tmp	<=		{{6{err[E_W-1]}},err[E_W-1:6]};
8'd7: err_tmp	<=		{{7{err[E_W-1]}},err[E_W-1:7]};
8'd8: err_tmp	<=		{{8{err[E_W-1]}},err[E_W-1:8]};
8'd9: err_tmp	<=		{{9{err[E_W-1]}},err[E_W-1:9]};
8'd10: err_tmp	<=		{{10{err[E_W-1]}},err[E_W-1:10]};
8'd11: err_tmp	<=		{{11{err[E_W-1]}},err[E_W-1:11]};
8'd12: err_tmp	<=		{{12{err[E_W-1]}},err[E_W-1:12]};
8'd13: err_tmp	<=		{{13{err[E_W-1]}},err[E_W-1:13]};
8'd14: err_tmp	<=		{{14{err[E_W-1]}},err[E_W-1:14]};
8'd15: err_tmp	<=		{{15{err[E_W-1]}},err[E_W-1:15]};
default: err_tmp<=		err	;
endcase

endmodule