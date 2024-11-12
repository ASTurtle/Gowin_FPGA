% 读取音频文件
[file, Fs] = audioread('C:\Users\Asus\Desktop\1.wav'); % 音频文件路径

% 确保音频是单通道的
if size(file, 2) > 1
    file = file(:, 1); % 如果是立体声，只取第一个通道
end

% 初始设置
N = 9; % 滤波器阶数
fs0 = 44.1e3; % 采样频率
fpass0 = 11e3; % 通带频率
fstop0 = 13e3; % 阻带开始频率

% 归一化频率
wn_fpass0 = fpass0 / (fs0/2); % 归一化通带频率
wn_fstop0 = fstop0 / (fs0/2); % 归一化阻带频率

% 设计低通FIR滤波器
b = fir1(N-1, wn_fpass0, 'low');

% 应用滤波器
filtered_audio = filter(b, 1, file);

% 裁剪数据以避免警告
filtered_audio = min(max(filtered_audio, -1.0), 1.0);

% 保存滤波后的音频
audiowrite('C:\Users\Asus\Desktop\2.wav', filtered_audio, Fs);