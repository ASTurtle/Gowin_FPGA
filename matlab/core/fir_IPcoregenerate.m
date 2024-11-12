% 初始设置
N = 9; % 滤波器阶数
% fs0 = 44.1e3; % 16kHz 采样频率
% fpass0 = 8e3; % 8kHz 通带频率
% wn_fpass0 = fpass0 / fs0; % 归一化通带频率
fs0 = 44.1e3; % 采样频率
fpass0 = 11e3; % 通带频率
fstop0 = 13e3; % 阻带开始频率

% % 生成低通 FIR 系数
% coeff0 = fir1(N-1, wn_fpass0, 'high');
% 归一化频率
wn_fpass0 = fpass0 / fs0; % 归一化通带频率
wn_fstop0 = fstop0 / fs0; % 归一化阻带频率

% 生成低通 FIR 系数
coeff0 = fir1(N-1, wn_fpass0, 'low');


% 转换为定点
Coeff_Width = 16  ; % 定点宽度
Scaled_Width = Coeff_Width - 1;
coeff0_fi = round(coeff0 * 2^Scaled_Width);


% 保存文件
file_name = "C:\Users\Asus\Desktop\gowin\ini\advance.txt";
fid = fopen(file_name, 'w');
fprintf(fid, '%d\n', coeff0_fi);
fclose(fid);