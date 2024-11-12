N=32;
L = N+1;             % L为滤波器长度;
Npt = 256;           % 绘制频响曲线图时的频点个数
Nfil = 6;            % 滤波器的数量
xinc=0.5/(Nfil-1);   % 分数延时增量
 
w = (0:1:(Npt-1))/Npt;  % 频率归一化
wpi = w*pi;             % 频率间隔
 
h = zeros(1,(N+1));     % 子滤波器的系数矩阵
mag = zeros(Nfil,Npt);  % 滤波器的幅频响应矩阵
 
x_vec=zeros(Nfil,1);    % 分数延时向量，与滤波器数量相等
h_vec=zeros(Nfil,N+1);  % 子滤波器组的系数矩阵
C=zeros(Np+1,N+1);      % 子滤波器组的多项式估计系数矩阵
 
% 设计原型滤波器
for i=1:Nfil
  x=(i-1)*xinc+0.0000001;  % 避免出现sin(0)/0
  x_vec(i)=x;              % 存储对应的分数时延
  h=hgls(L,x,wp);          % 根据广义最小二乘法求解子滤波器的系数矩阵
  h_vec(i,:)=h';           % 存储设计得到的子滤波器的系数矩阵
end  
% 进行系数矩阵的多项式逼近
for k=1:(N+1)
  cc=polyfit(x_vec,h_vec(:,k),Np);   
  C(:,k)=cc';              % 对多项式逼近得到的系数矩阵进行数据拟合     
end 
 
% 得到Farrow结构滤波器的频响特性
for j=1:Nfil
  x=(j-1)*xinc + 0.0001;   % 避免出现sin(0)/0
  h = C(Np+1,:);           % 由拟合后的子滤波器系数矩阵
  for n=1:Np
    h=h+x^n*C(Np+1-n,:);   % 得到子滤波器的系数和矩阵
  end 
  h=h/sum(h);                 % 综合滤波器组的系数矩阵
  H = freqz(h,1,wpi);
  mag(j,:) = abs(H);
end 
up2179