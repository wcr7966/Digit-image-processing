function [output] = CLAHE(input_channel)
hv=rgb2hsv(input_channel); 
%����ͨ������ĳ���һ��ͼ��HSV����ͨ�� 
H=hv(:,:,1);
S=hv(:,:,2);
V=hv(:,:,3);
[X, Y] = size(V);
for i = 1: X
    for j = 1: Y
        V(i, j) = V(i, j)*255;
    end
end
R = clahe_function(V);
R = mat2gray(R);
F = cat(3, H, S, R);
output = hsv2rgb(F);
