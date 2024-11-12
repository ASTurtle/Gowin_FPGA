% % 读取音频文件
% [file, Fs] = audioread('C:\Users\Asus\Desktop\1.wav'); % 假设音频文件名为input_audio.wav
% 
% % 确保音频是单通道的
% if size(file, 2) > 1
%     file = file(:, 1); % 如果是立体声，只取第一个通道
% end
% 
% % 设计FIR滤波器
% Fs = 44100; % 采样率
% f1 = 80; % 下截止频率
% f2 = 600; % 上截止频率
% N = 8; % 滤波器阶数
% 
% % 归一化截止频率
% f = [0 f1 f2 (Fs/2)]; % 频率向量，第一个和最后一个频率分别归一化为 0 和 1
% A = [1 0 0 1]; % 振幅响应，通带为 1，阻带为 0
% 
% % 使用 fir2 函数设计带阻滤波器
% b = fir2(N, f/(Fs/2), A);
% 
% % 应用滤波器
% filtered_audio = filter(b, 1, file);
% 
% % 保存滤波后的音频
% audiowrite('C:\Users\Asus\Desktop\2.wav', filtered_audio, Fs);
% 
% % 转换为定点并保存滤波器系数
% Coeff_Width = 16; % 定点宽度
% Scaled_Width = Coeff_Width - 1;
% b_fi = round(b * 2^Scaled_Width);
% 
% % % 保存滤波器系数到文件
% % file_name = "C:\Users\Asus\Desktop\gowin\ini\daitong.txt";
% % fid = fopen(file_name, 'w');
% % fprintf(fid, '%d\n', b_fi);
% % fclose(fid);
% 读取音频文件
[file, Fs] = audioread('C:\Users\Asus\Desktop\1.wav'); % 假设音频文件名为input_audio.wav

% 确保音频是单通道的
if size(file, 2) > 1
    file = file(:, 1); % 如果是立体声，只取第一个通道
end

% 设计FIR滤波器
Fs = 44100; % 采样率
f1 = 80; % 下截止频率
f2 = 600; % 上截止频率
N = 8; % 滤波器阶数

% 归一化截止频率
f = [0 f1 f2 (Fs/2)]; % 频率向量，第一个和最后一个频率分别归一化为 0 和 1
A = [1 0 0 1]; % 振幅响应，通带为 1，阻带为 0

% 使用 fir2 函数设计带阻滤波器
b = fir2(N, f/(Fs/2), A);

% 应用滤波器
filtered_audio = filter(b, 1, file);

% 裁剪数据以避免警告
filtered_audio = min(max(filtered_audio, -1.0), 1.0);

% 保存滤波后的音频
audiowrite('C:\Users\Asus\Desktop\2`.wav', filtered_audio, Fs);

% 转换为定点并保存滤波器系数
Coeff_Width = 16; % 定点宽度
Scaled_Width = Coeff_Width - 1;
b_fi = round(b * 2^Scaled_Width);

% % 保存滤波器系数到文件
% file_name = "C:\Users\Asus\Desktop\gowin\ini\daitong.txt";
% fid = fopen(file_name, 'w');
% fprintf(fid, '%d\n', b_fi);
% fclose(fid);