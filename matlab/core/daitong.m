Fs = 44100; % 采样率
f1 = 80; % 下截止频率
f2 = 600; % 上截止频率
N = 8; % 滤波器阶数

% 归一化截止频率
f = [0 f1 f2 (Fs/2)]; % 频率向量，第一个和最后一个频率分别归一化为 0 和 1
A = [1 0 0 1]; % 振幅响应，通带为 1，阻带为 0

% 设计FIR滤波器
b = fir2(N, f/(Fs/2), A); % 使用 fir2 函数设计带阻滤波器

% 转换为定点
Coeff_Width = 16; % 定点宽度
Scaled_Width = Coeff_Width - 1;
b_fi = round(b * 2^Scaled_Width);

% 保存文件
file_name = "C:\Users\Asus\Desktop\gowin\ini\daitong.txt";
fid = fopen(file_name, 'w');
fprintf(fid, '%d\n', b_fi);
fclose(fid);