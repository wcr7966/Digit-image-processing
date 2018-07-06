function [output2] = clahe_function(input_channel)
[h, w] = size(input_channel);
minV = 0;
maxV = 255;
for i = 1: h
    for j = 1: w
        if input_channel(i, j) > maxV
            maxV = input_channel(i, j);
        end
        if input_channel(i, j) < minV
            minV = input_channel(i, j);
        end
    end
end
%imshow(input_channel)
output = input_channel;

NrX = 8;
NrY = 4;
HSize = ceil(h/NrY);
WSize = ceil(w/NrX);

deltay = NrY*HSize - h;
deltax = NrX*WSize - w;

tmpImg = zeros(h + deltay, w + deltax);
tmpImg(1:h, 1:w) = input_channel;

new_w = w + deltax;
new_h = h + deltay;

NrPixels = HSize * WSize;

NrBins = 256;

LUT = zeros(maxV+1,1);  
  
for i=minV:maxV  
    LUT(i+1) = fix(i - minV);  
end  
  
Bin = zeros(new_h, new_w);  
for m = 1 : new_h  
    for n = 1 : new_w  
        Bin(m,n) = 1 + LUT(tmpImg(m,n) + 1);  
    end  
end   

Hist = zeros(NrY, NrX, 256);  
for i=1:NrY  
    for j=1:NrX  
        tmp = uint8(Bin(1+(i-1)*HSize:i*HSize, 1+(j-1)*WSize:j*WSize)); 
        [Hist(i, j, :), ~] = imhist(tmp, 256);  
    end  
end 

ClipLimit = 4;  
ClipLimit = max(1,ClipLimit * HSize * WSize/NrBins);  

Hist = clipHistogram(Hist,NrBins,ClipLimit,NrY,NrX);  

Map=mapHistogram(Hist, minV, maxV, NrBins, NrPixels, NrY, NrX); 

yI = 1;  
for i = 1: NrY+1  
    if i == 1  
        subY = floor(HSize/2);  
        yU = 1;  
        yB = 1;  
    elseif i == NrY+1  
        subY = floor(HSize/2);  
        yU = NrY;  
        yB = NrY;  
    else  
        subY = HSize;  
        yU = i - 1;  
        yB = i;  
    end  
    xI = 1;  
    for j = 1: NrX+1  
        if j == 1  
            subX = floor(WSize/2);  
            xL = 1;  
            xR = 1;  
        elseif j == NrX+1  
            subX = floor(WSize/2);  
            xL = NrX;  
            xR = NrX;  
        else  
            subX = WSize;  
            xL = j - 1;  
            xR = j;  
        end  
        UL = Map(yU,xL,:);  
        UR = Map(yU,xR,:);  
        BL = Map(yB,xL,:);  
        BR = Map(yB,xR,:);  
        subImage = Bin(yI:yI+subY-1,xI:xI+subX-1);  
  
        sImage = zeros(size(subImage));  
        num = subY * subX;  
        for k = 0:subY - 1  
            inverseI = subY - k;  
            for s = 0:subX - 1  
                inverseJ = subX - s;  
                val = subImage(k+1,s+1);  
                sImage(k+1, s+1) = (inverseI*(inverseJ*UL(val) + s*UR(val)) ...  
                                + k*(inverseJ*BL(val) + s*BR(val)))/num;  
            end  
        end  
          
        output(yI:yI+subY-1, xI:xI+subX-1) = sImage;  
        xI = xI + subX;  
    end  
    yI = yI + subY;  
end  

[output2] = output(1:h, 1:w);

%  figure, imhist(input_channel);
%  figure, imhist(output2);




function [Hist] = clipHistogram(Hist,NrBins,ClipLimit,NrX,NrY)
for i = 1: NrX
    for j = 1: NrY
        % 计算所有超出部分像素的和
        NrExcess = 0;
        for k = 1: NrBins
            excess = Hist(i,j,k) - ClipLimit;
            if excess > 0
                NrExcess = NrExcess + excess;
            end
        end

        % 裁剪分布图并将面积重新分配
        binIncr = NrExcess / NrBins;
        upper = ClipLimit - binIncr;
        for k = 1: NrBins
            % 如果超过限制，直方图值为限制值
            if Hist(i,j,k) > ClipLimit
                Hist(i,j,k) = ClipLimit;
            else
                % 加上分配值会超过限制值
                if Hist(i,j,k) > upper
                    NrExcess = NrExcess + upper - Hist(i,j,k);
                    Hist(i,j,k) = ClipLimit;
                else
                    NrExcess = NrExcess - binIncr;
                    Hist(i,j,k) = Hist(i,j,k) + binIncr;
                end
            end
        end
        
        if NrExcess > 0
            stepSize = max(1,fix(1 + NrExcess/NrBins));
            for k = 1: NrBins
                NrExcess = NrExcess - stepSize;
                Hist(i,j,k) = Hist(i,j,k) + stepSize;
                if NrExcess < 1
                    break;
                end
            end
        end
        
    end
end






function [Map] = mapHistogram(Hist,Min,Max,NrBins,NrPixels,NrX,NrY)
Map=zeros(NrX,NrY,NrBins);

Scale = (Max - Min)/NrPixels;

for i = 1:NrX
    for j = 1:NrY
        
        Sum = 0;
        for nr = 1:NrBins
            Sum = Sum + Hist(i,j,nr);
            Map(i,j,nr) = fix(min(Min + Sum*Scale,Max));
        end
        
    end
end
