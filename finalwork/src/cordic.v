module cordic(
	input 				reset_n,
	input 				clk,
	input 		[15:0] 	datain,
	output reg	[15:0]	sin,
	output reg	[15:0]  cos
);
//产生正弦波，模拟LFO
parameter[15:0] rot1 = 16'b0000110101001000,
rot2 = 16'b0000011100101110,
rot3 = 16'b0000001110010000,
rot4 = 16'b0000000111001010,
rot5 = 16'b0000000011100101,
rot6 = 16'b0000000001110011,
rot7 = 16'b0000000000111001,
rot0 = 16'b0001011010000000;

//parameter[15:0] k = 16'b0000000001001110;
parameter[15:0] k = 16'h004d;

reg[15:0] x0,y0,z0;
reg[15:0] x1,y1,z1;
reg[15:0] x2,y2,z2;
reg[15:0] x3,y3,z3;
reg[15:0] x4,y4,z4;
reg[15:0] x5,y5,z5;
reg[15:0] x6,y6,z6;
reg[15:0] x7,y7,z7;
reg[15:0] x8,y8,z8;

reg flag0,flag1,flag2,flag3,flag4,flag5,flag6,flag7,flag8;


//initial
always @(posedge clk or negedge reset_n)
begin
    if(!reset_n)
    begin
        x0 <= 0;
        y0 <= 0;
        z0 <= 0;
        flag0 <= 0;
    end
    else if(datain == 0)
    begin
        x0 <= 0;
        y0 <= 0;
        z0 <= 0;
        flag0 <= 0;
    end
    else
    begin
        x0 <= k;
        y0 <= 0;
        if(datain[15])
            z0 <= ~(datain-1);
        else
            z0 <= datain;
        flag0 <= datain[15];
    end
end

//1
always @(posedge clk or negedge reset_n)
begin
    if(!reset_n)
    begin   
        x1 <= 0;
        y1 <= 0;
        z1 <= 0;
        flag1 <= 0;
    end
    else
    begin
//      if(z0[15])
//      begin
//          x1 <= x0 + y0;
//          y1 <= x0 - y0;
//          z1 <= z0 + rot0;
//          flag1 <= flag0;
//      end
//      else
//      begin
            x1 <= x0 - y0;
            y1 <= x0 + y0;
            z1 <= z0 - rot0;
            flag1 <= flag0;
//      end
    end
end
//2
always @(posedge clk or negedge reset_n)
begin
    if(!reset_n)
    begin   
        x2 <= 0;
        y2 <= 0;
        z2 <= 0;
        flag2 <= 0;
    end
    else
    begin
        if(z1[15])
        begin
            x2 <= x1 + {y1[15],y1[15:1]};
            y2 <= y1 - {x1[15],x1[15:1]};
            z2 <= z1 + rot1;
            flag2 <= flag1;
        end
        else
        begin
            x2 <= x1 - {y1[15],y1[15:1]};
            y2 <= y1 + {x1[15],x1[15:1]};
            z2 <= z1 - rot1;
            flag2 <= flag1;
        end
    end
end
//3
always @(posedge clk or negedge reset_n)
begin
    if(!reset_n)
    begin   
        x3 <= 0;
        y3 <= 0;
        z3 <= 0;
        flag3 <= 0;
    end
    else
    begin
        if(z2[15])
        begin
            x3 <= x2 + {{2{y2[15]}},y2[15:2]};
            y3 <= y2 - {{2{x2[15]}},x2[15:2]};
            z3 <= z2 + rot2;
            flag3 <= flag2;
        end
        else
        begin
            x3 <= x2 - {{2{y2[15]}},y2[15:2]};
            y3 <= y2 + {{2{x2[15]}},x2[15:2]};
            z3 <= z2 - rot2;
            flag3 <= flag2;
        end
    end
end
//4
always @(posedge clk or negedge reset_n)
begin
    if(!reset_n)
    begin   
        x4 <= 0;
        y4 <= 0;
        z4 <= 0;
        flag4 <= 0;
    end
    else
    begin
        if(z3[15])
        begin
            x4 <= x3 + {{3{y3[15]}},y3[15:3]};
            y4 <= y3 - {{3{x3[15]}},x3[15:3]};
            z4 <= z3 + rot3;
            flag4 <= flag3;
        end
        else
        begin
            x4 <= x3 - {{3{y3[15]}},y3[15:3]};
            y4 <= y3 + {{3{x3[15]}},x3[15:3]};
            z4 <= z3 - rot3;
            flag4 <= flag3;
        end
    end
end
//5
always @(posedge clk or negedge reset_n)
begin
    if(!reset_n)
    begin   
        x5 <= 0;
        y5 <= 0;
        z5 <= 0;
        flag5 <= 0;
    end
    else
    begin
        if(z4[15])
        begin
            x5 <= x4 + {{4{y4[15]}},y4[15:4]};
            y5 <= y4 - {{4{x4[15]}},x4[15:4]};
            z5 <= z4 + rot4;
            flag5 <= flag4;
        end
        else
        begin
            x5 <= x4 - {{4{y4[15]}},y4[15:4]};
            y5 <= y4 + {{4{x4[15]}},x4[15:4]};
            z5 <= z4 - rot4;
            flag5 <= flag4;
        end
    end
end
//6
always @(posedge clk or negedge reset_n)
begin
    if(!reset_n)
    begin   
        x6 <= 0;
        y6 <= 0;
        z6 <= 0;
        flag6 <= 0;
    end
    else
    begin
        if(z5[15])
        begin
            x6 <= x5 + {{5{y5[15]}},y5[15:5]};
            y6 <= y5 - {{5{x5[15]}},x5[15:5]};
            z6 <= z5 + rot5;
            flag6 <= flag5;
        end
        else
        begin
            x6 <= x5 - {{5{y5[15]}},y5[15:5]};
            y6 <= y5 + {{5{x5[15]}},x5[15:5]};
            z6 <= z5 - rot5;
            flag6 <= flag5;
        end
    end
end
//7
always @(posedge clk or negedge reset_n)
begin
    if(!reset_n)
    begin   
        x7 <= 0;
        y7 <= 0;
        z7 <= 0;
        flag7 <= 0;
    end
    else
    begin
        if(z6[15])
        begin
            x7 <= x6 + {{6{y6[15]}},y6[15:6]};
            y7 <= y6 - {{6{x6[15]}},x6[15:6]};
            z7 <= z6 + rot6;
            flag7 <= flag6;
        end
        else
        begin
            x7 <= x6 - {{6{y6[15]}},y6[15:6]};
            y7 <= y6 + {{6{x6[15]}},x6[15:6]};
            z7 <= z6 - rot6;
            flag7 <= flag6;
        end
    end
end
//8
always @(posedge clk or negedge reset_n)
begin
    if(!reset_n)
    begin   
        x8 <= 0;
        y8 <= 0;
        z8 <= 0;
        flag8 <= 0;
    end
    else
    begin
        if(z7[15])
        begin
            x8 <= x7 + {{7{y7[15]}},y7[15:7]};
            y8 <= y7 - {{7{x7[15]}},x7[15:7]};
            z8 <= z7 + rot7;
            flag8 <= flag7;
        end
        else
        begin
            x8 <= x7 - {{7{y7[15]}},y7[15:7]};
            y8 <= y7 + {{7{x7[15]}},x7[15:7]};
            z8 <= z7 - rot7;
            flag8 <= flag7;
        end
    end
end
endmodule