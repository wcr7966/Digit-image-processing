function [output2] = hist_equal(input_channel)
    %you should complete this sub-function
    [R, C] = size(input_channel);
    
    % ͳ��ÿ������ֵ���ִ���
    cnt = zeros(1, 256);
    for i = 1 : R
        for j = 1 : C
            cnt(1, input_channel(i, j) + 1) = cnt(1, input_channel(i, j) + 1) + 1;
        end
    end

    f = zeros(1, 256);
    f = double(f); 
    cnt = double(cnt);

    % ͳ��ÿ������ֵ���ֵĸ���
    for i = 1 : 256
        f(1, i) = cnt(1, i) / (R * C);
    end
    
    %�ҵ�input_channel����ֵ�ķ�Χ
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

    % �������
    for i = 2 : 256
        f(1, i) = f(1, i - 1) + f(1, i);
    end
    
    % ʵ������ֵ[min, max]��ӳ�� 
    for i = 1 : 256
        f(1, i) = f(1, i) * (max - min);
    end

    % ÿ�����ص����ӳ��
    input_channel = double(input_channel);
    for i = 1 : R
        for j = 1 : C
            input_channel(i, j) = f(1, input_channel(i, j) + 1);
        end
    end
    output2 = uint8(input_channel);
end