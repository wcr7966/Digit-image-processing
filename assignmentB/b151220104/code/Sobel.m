function sobel = Sobel(image)
[m,n] = size(image); 
image = double(image);       
uSobel = image;
for i = 2: m - 1
    for j = 2: n - 1
        Gx = (image(i+1,j-1) + 2*image(i+1,j) + image(i+1,j+1)) - (image(i-1,j-1) + 2*image(i-1,j) + image(i-1,j+1));
        Gy = (image(i-1,j+1) + 2*image(i,j+1) + image(i+1,j+1)) - (image(i-1,j-1) + 2*image(i,j-1) + image(i+1,j-1));
        uSobel(i,j) = sqrt(Gx^2 + Gy^2); 
    end
end 
%归一化
Max = max(max(uSobel));
if Max ~= 0
     uSobel = uSobel / Max;
end
% 计算阈值
scale = 4; 
cutoff = scale*mean2(uSobel); 
thresh = sqrt(cutoff);
sobel = zeros(m, n);
%二值化
for i = 1: m
    for j = 1: n
        if uSobel(i, j) > thresh
            sobel(i, j) = 1;
        end
    end
end