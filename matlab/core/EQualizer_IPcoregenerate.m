% 定义常量
EQORDER = 2; % 滤波器阶数
SAMPLERATE = 44100; % 采样率
FRACTION_WIDTH = 18; % 小数位宽度
STRUCTURE = 'Cascade'; % 均衡器结构（串联）
BANDWIDTH = '1 octave'; % 均衡器带宽（倍频程）
GAIN_RANGE = 12; % 增益范围
GAIN_NUM = 3; % 增益阶段数量

% 创建图形均衡器对象
equalizer = graphicEQ('EQOrder', EQORDER, 'Bandwidth', BANDWIDTH,'Structure',STRUCTURE,'SampleRate', SAMPLERATE);

% 获取优选频带
freq_bands = info(equalizer).PreferredFrequencies;
num_bands = length(freq_bands);

% 初始化系数数组
Coeff_B = zeros(EQORDER+1, GAIN_NUM, num_bands);
Coeff_A = zeros(EQORDER+1, GAIN_NUM, num_bands);

% 生成不同增益阶段的系数
for i = 1:GAIN_NUM
    GAINS = zeros(1, num_bands);
    for j = 1:num_bands
        GAINS(j) = GAIN_RANGE * (i - 1) - GAIN_RANGE * 2;
        equalizer.Gains = GAINS;
        [b, a] = coeffs(equalizer);
        Coeff_B(:, i, j) = b(:, j);
        Coeff_A(:, i, j) = a(:, j);
    end
end

% 转换为定点表示
Coeff_B_fi = round(Coeff_B * 2^FRACTION_WIDTH);
Coeff_A_fi_temp = round(Coeff_A*2^FRACTION_WIDTH);
Coeff_A_fi = Coeff_A_fi_temp ([2 3],:);

% 写入系数到外部文件
writematrix(Coeff_B_fi(:), 'C:\Users\Asus\Desktop\gowin\ini\sampleA');
writematrix(Coeff_A_fi(:), 'C:\Users\Asus\Desktop\gowin\ini\sampleB');