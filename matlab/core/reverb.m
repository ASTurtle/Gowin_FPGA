function reverbAudio = hun(inputAudio, fs, reverbTime, mixRatio,huntime)
    % inputAudio: 输入音频信号（单声道）
    % fs: 采样频率
    % reverbTime: 混响时间（秒）
    % mixRatio: 原始信号与混响信号的混合比例（0到1之间）
    %huntime:   最大延迟时间
    % 计算混响的延迟样本数和衰减因子
    decayFactor = exp(-3 / reverbTime); % 衰减因子，基于混响时间
    maxDelay = floor(huntime * fs); % 最大延迟时间（3ms），可调整
    delaySamples = 1 : maxDelay; % 延迟样本序列

    % 创建延迟和衰减的混响信号
    reverbSignal = zeros(size(inputAudio));
    for i = 1:length(inputAudio)
        delayIndex = max(1, i - maxDelay);
        for j = delaySamples
            reverbSignal(i) = reverbSignal(i) + inputAudio(delayIndex + j - 1) * decayFactor^j;
        end
    end
    
    % 应用低通滤波器以模拟空气吸收高频的现象
   hpFilt = designfilt('highpassfir', ...
                    'PassbandFrequency', 0.5 * fs / 2, ... % 通带频率设置为采样率的0.5倍
                    'StopbandFrequency', 0.6 * fs / 2, ... % 阻带频率设置为采样率的0.6倍
                    'DesignMethod', 'butter', ...
                    'FilterOrder', 8);
reverbSignal = filter(hpFilt, reverbSignal);
    % 混合原始信号与混响信号
    reverbAudio = (1 - mixRatio) * inputAudio + mixRatio * reverbSignal;
end
