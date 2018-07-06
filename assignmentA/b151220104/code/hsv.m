function [output] = hsv(input_channel)
hv=rgb2hsv(input_channel);
H=hv(:,:,1);
S=hv(:,:,2);
V=hv(:,:,3);
[X, Y] = size(V);
for i = 1: X
    for j = 1: Y
        V(i, j) = V(i, j)*255;
    end
end
R = hist_equal(V);
R = mat2gray(R);
F = cat(3, H, S, R);
[output] = hsv2rgb(F);
