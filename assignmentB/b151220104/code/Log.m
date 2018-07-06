function log = Log(input_image)
[m,n]=size(input_image);
% 高斯拉普拉斯
sigma=2;
fsize=ceil(sigma*3)*2+1;
op=fspecial('log',fsize,sigma);
op=op-sum(op(:))/numel(op);
b=filter2(op,input_image);
thresh=1.75*mean2(abs(b)); 
% 零点交叉判断边界
log = zeros(m, n);
for i=2:m-1
    for j=2:n-1
        if all(b(i, j)<0) && (b(i, j + 1)>0) && (abs(b(i, j + 1) - b(i, j)) > thresh)
            log(i, j) = 1;
        elseif all(b(i, j-1)>0) && (b(i, j)<0) && (abs(b(i,j-1)-b(i,j))>thresh)
            log(i, j) = 1;
        elseif all(b(i, j)<0) && (b(i+1,j)>0) && (abs(b(i,j)-b(i+1,j))>thresh)
            log(i, j) = 1;
        elseif all(b(i-1,j)>0) && (b(i,j)<0) && (abs(b(i-1,j)-b(i,j))>thresh)
            log(i, j) = 1;
        end
    end
end
