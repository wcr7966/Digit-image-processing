function boundary = my_edgetracing(binary_image, row, col)
%in this function, you should finish the edge linking utility.
%the input parameters are a matrix of a binary image containing the edge
%information and coordinates of one of the edge points of a obeject
%boundary, you should run this function multiple times to find different
%object boundaries
%the output parameter is a Q-by-2 matrix, where Q is the number of boundary
%pixels. B holds the row and column coordinates of the boundary pixels.
%you can use different methods to complete the edge linking function
%the better the quality of object boundary and the more the object boundaries, you will get higher scores
image = logical(binary_image);
[m, n] = size(image);
image_plus(m + 2, n + 2) = 0;
image_plus(2: m + 1, 2: n + 1) = image;


% ÆðÊ¼µã
first = [row, col] + 1;

%neigborhood = | 2 3 4 |
%              | 1 X 5 |
%              | 8 7 6 |
neighborhood = [ -1 0; -1 -1; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1 ];
exit_direction = [7 7 1 1 3 3 5 5];

for k = 1: 8 
    c = first + neighborhood( k, : );
    if image_plus(c( 2 ), c( 1 )) == 1
        initial_position = c;
        break;
    end
end
initial_direction = exit_direction( k );

boundary_size = 1;
boundary(boundary_size, : ) = initial_position;

position = initial_position;
direction = initial_direction;
while true
    for k = circshift(1: 8, [0, 1 - direction])
        c = position + neighborhood(k, :);
        if image_plus(c(2), c(1)) == 1
            position = c;
            break;
        end
    end
    direction = exit_direction( k );
    boundary_size = boundary_size + 1;
    boundary(boundary_size, :) = position;
    
    if all(position == initial_position) &&...
            (direction == initial_direction)
        break;
    end
end

boundary = boundary - 1;
% disp(boundary);
end