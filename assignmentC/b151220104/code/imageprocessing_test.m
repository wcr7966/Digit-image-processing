%DIP16 Assignment 3
maindir = './image';
subdir  = dir( maindir );

for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir )
        continue;
    end

    subdirpath = fullfile( maindir, subdir( i ).name, '*.png' );
    png = dir( subdirpath );               % ���ļ������Һ�׺Ϊpng���ļ�

    for j = 1 : length( png )
        pngpath = fullfile( maindir, subdir( i ).name, png( j ).name);
        image = imread( pngpath );
        imtool(image);
        
        %bw=im2bw(image, 0.1);
        figure;imshow(image);
        processed_image = my_imageprocessing(image);
        figure;imshow(processed_image)
        filename = sprintf('./result-40/%d-p.png', j);
        imwrite(processed_image, filename);
    end
end
