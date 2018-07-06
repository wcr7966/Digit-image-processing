function [output2] = hist_equal(input_channel)
    %you should complete this sub-function
    [R, C] = size(input_channel);
    
    % 统计每个像素值出现次数
    cnt = zeros(1, 256);
    for i = 1 : R
        for j = 1 : C
            cnt(1, input_channel(i, j) + 1) = cnt(1, input_channel(i, j) + 1) + 1;
        end
    end

    f = zeros(1, 256);
    f = double(f); 
    cnt = double(cnt);

    % 统计每个像素值出现的概率
    for i = 1 : 256
        f(1, i) = cnt(1, i) / (R * C);
    end
    
    %找到input_channel像素值的范围
    max = 0;
    min = 255;
    for i = 1: R
        for j = 1: C
            if input_channel(i, j) > max
                max = input_channel(i, j);
            end
            if input_channel(i, j) < min
                min = input_channel(i, j);
            end
        end
    end

    % 计算积分
    for i = 2 : 256
        f(1, i) = f(1, i - 1) + f(1, i);
    end
    
    % 实现像素值[min, max]的映射 
    for i = 1 : 256
        f(1, i) = f(1, i) * (max - min);
    end

    % 每个像素点进行映射
    input_channel = double(input_channel);
    for i = 1 : R
        for j = 1 : C
            input_channel(i, j) = f(1, input_channel(i, j) + 1);
        end
    end
    output2 = uint8(input_channel);
end