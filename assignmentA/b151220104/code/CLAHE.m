function [output] = CLAHE(input_channel)
hv=rgb2hsv(input_channel); 
%可以通过下面的程序看一幅图的HSV三个通道 
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
