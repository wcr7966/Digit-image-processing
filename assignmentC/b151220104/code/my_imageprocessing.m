%in this function, you should finish the image processing function to
%extract the longitude and latitude lines using any mothods you consider 
%appropriate.
%please output the image only contains the longitude and latitude lines 
%and the backgroud.
function output = my_imageprocessing(input_image)
[m, n] = size(input_image);
output = zeros(m, n);
image_plus = zeros(m+2, n+2);
image_plus(2: m+1, 2: n+1) = input_image;
direction = [1, 0; 1, 1; 0, 1; -1, 1; -1, 0; -1, -1; 0, -1; 1, -1];
for i = 2:m+1
    for j = 2:n+1
        if (image_plus(i, j) == 255 && output(i-1, j-1) == 0)
            for d1 = 1: 8
                if d1 < 8
                    d2 = d1 + 1;
                else
                    d2 = 1;
                end
                [points, len] = search(image_plus, i, j, direction(d1, :), direction(d2, :));
                if len > 40
                    points = points - 1;
                    for k = 1 : len
                        output(points(k, 1), points(k, 2)) = 255;
                    end
                end
            end
        end
    end
end
end