function canny = Canny(input_image)
[Ax, Ay] = size(input_image);
src = double(input_image);
m = zeros(Ax, Ay); % 梯度幅值
gradx = zeros(Ax, Ay);
grady = zeros(Ax, Ay);
sector = zeros(Ax, Ay); % 梯度方向
tempCanny = zeros(Ax, Ay);
canny = zeros(Ax, Ay);
for x = 1:(Ax-1)
    for y = 1:(Ay-1)
        gx = (src(x, y+1) - src(x, y) + src(x+1, y+1)  - src(x+1, y))/2;
        gy = (src(x+1, y) - src(x, y) + src(x+1, y+1) - src(x, y+1))/2;
        m(x,y) = sqrt(gx^2+gy^2) ;
        gradx(x, y) = gx/gy;
        grady(x, y) = gy/gx;
        
        theta = atand(gy/gx) + 90; 
        if (theta >= 0 && theta < 45)
            sector(x,y) = 0;
        elseif (theta >= 45 && theta < 90)
            sector(x,y) = 1;
        elseif (theta >= 90 && theta < 135)
            sector(x,y) = 2;
        else
            sector(x,y) = 3;
        end      
    end    
end

% 归一化
Max = max(max(m));
if Max ~= 0
    m = m / Max;
end

% 设置双阈值
highThresh = 0.3;
lowThresh = highThresh * 0.4;

for x = 2:Ax-1
    for y = 2:Ay-1
        E =  m(x, y+1);
        S =  m(x+1, y);
        W =  m(x, y-1);
        N =  m(x-1, y);
        NE = m(x-1, y+1);
        SE = m(x+1, y+1);
        NW = m(x-1, y-1);
        SW = m(x+1, y-1);
        
        if sector(x,y) == 0
            d = abs(grady(x,y));
            m1 = E*(1-d) + NE*d;
            m2 = W*(1-d) + SW*d;
        elseif sector(x,y) == 1
            d = abs(gradx(x,y));
            m1 = N*(1-d) + NE*d;
            m2 = S*(1-d) + SW*d;
        elseif sector(x,y) == 2
            d = abs(gradx(x,y));
            m1 = N*(1-d) + NW*d;
            m2 = S*(1-d) + SE*d;
        elseif sector(x,y) == 3
            d = abs(grady(x,y));
            m1 = W*(1-d) + NW*d;
            m2 = E*(1-d) + SE*d;
        end
        if m(x,y) >= m1 && m(x,y) >= m2
            if m(x,y) >= highThresh
                canny(x, y) = 1;
               	tempCanny(x, y) = highThresh;
            elseif m(x, y) >= lowThresh
                tempCanny(x, y) = lowThresh;
            else
                tempCanny(x,y) = 0;
            end
        else
            tempCanny(x,y) = 0;
        end
    end
end

for x = 2:Ax-1
    for y = 2:Ay-1
        if tempCanny(x, y) == lowThresh
            tem = [tempCanny(x-1,y-1), tempCanny(x-1,y), tempCanny(x-1,y+1), ...
                tempCanny(x,  y-1), tempCanny(x,  y+1), tempCanny(x+1,y-1),...
                tempCanny(x+1,y), tempCanny(x+1,y+1)];
            if ~isempty(find(tem) == highThresh)
                canny(x,y) = 1;
            end
        end
    end
end