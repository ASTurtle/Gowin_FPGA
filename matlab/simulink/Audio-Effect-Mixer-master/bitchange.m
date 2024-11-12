% 打开十进制数字文件
fileID = fopen('C:\Users\Asus\Desktop\gowin\ini\sampleB.txt', 'r');
% 检查文件是否成功打开
if fileID == -1
    error('File cannot be opened');
end

% 读取文件中的所有数字
decimalNumbers = fscanf(fileID, '%d', [1, Inf]);
fclose(fileID); % 关闭文件

% 打开或创建二进制数字文件
newFileID = fopen('C:\Users\Asus\Desktop\gowin\ini\B.txt', 'w');

% 检查文件是否成功创建
if newFileID == -1
    error('File cannot be created');
end

% 规定二进制数的位数
binaryLength = 18;
% 遍历所有十进制数字并转换为二进制
for i = 1:length(decimalNumbers)
    % 转换为二进制并去除前缀'0b'
    binaryNumber = dec2bin(decimalNumbers(i),binaryLength);
    
    % 写入二进制数字到新文件
    fprintf(newFileID, '%s\n', binaryNumber);
end

% 关闭新文件
fclose(newFileID);