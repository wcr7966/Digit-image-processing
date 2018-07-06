function [points, len] = search(input_image, x, y, dir1, dir2)
    points = [];
    len = 0;
    next1_x = x + dir1(1);
    next1_y = y + dir1(2);
    next2_x = x + dir2(1);
    next2_y = y + dir2(2);
    if(input_image(next1_x, next1_y) == 255)
        [points, len] = search(input_image, next1_x, next1_y, dir1, dir2);
        points = [points; next1_x, next1_y];
    elseif (input_image(next2_x, next2_y) == 255)
        [points, len] = search(input_image, next2_x, next2_y, dir1, dir2);
        points = [points; next2_x, next2_y];
    else
        points = [points; x, y];
    end
    len = len + 1;
end