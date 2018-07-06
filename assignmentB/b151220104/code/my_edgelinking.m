function image_plus = my_edgelinking(image)
[m, n] = size(image);
image_plus(m + 2, n + 2) = 0;
image_plus(2 : m + 1, 2 : n + 1) = image;

for j = 2: n+1
    for i = 2: m+1
        if image_plus(i, j) == 1
            num = 0;
            for k = -1: 1
                for l = -1: 1
                    if all(~((k ==0) && (l==0)))&&(image_plus(i+k, j+l)==1)
                        num = num + 1;
                    end
                end
            end
            if num == 1
                for k = -2: 2
                    for l = -2: 2
                        if all(((k == -2)&&(l == 0)) || ((k == 2)&&(l == 0)) || ((k == 0)&&(l == 2)) || ((k == 0)&&(l == -2)))
                            if image_plus(i+k, j+l) == 1
                                image_plus(round((i+k+i)/2), round((j+l+j)/2)) = 1;
                            end
                        end
                    end
                end
            end
        end
    end
end
