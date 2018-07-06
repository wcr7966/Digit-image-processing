% test histeq
current_dir = pwd;
% frame_dir = fullfile(current_dir, 'asset/');
% output_dir1 = fullfile(current_dir, 'result/result1/');
% output_dir2 = fullfile(current_dir, 'result/result2/');
% output_dir3 = fullfile(current_dir, 'result/result3/');
% output_dir4 = fullfile(current_dir, 'result/result4/');
frame_dir = 'asset/';
output_dir1 = 'result/result1/';
output_dir2 = 'result/result2/';
output_dir3 = 'result/result3/';
output_dir4 = 'result/result4/';
if ~exist(output_dir1)
    mkdir(output_dir1)
end
if ~exist(output_dir2)
    mkdir(output_dir2)
end
if ~exist(output_dir3)
    mkdir(output_dir3)
end
if ~exist(output_dir4)
    mkdir(output_dir4)
end
s = dir(fullfile(frame_dir, '*.jpg'));
file_list = {s.name};
n = length(file_list);

for i = 1: n
    disp(['Execute ' num2str(i)])
    image_name = file_list{i};% Í¼ÏñÃû             
    I = imread(strcat(frame_dir,image_name));
    [J, K, L] = Histogram_equalization(I);
    im = figure(i);
    subplot(2,2,1);imshow(I);title('original')  
    subplot(2,2,2);imshow(J);title('RGB') 
    subplot(2,2,3);imshow(K);title('HSV')
    subplot(2,2,4);imshow(L);title('CLAHE')
    filename = [output_dir1 'RGB_' image_name];
    filename2 = [output_dir2 'HSV_' image_name ];
    filename3 = [output_dir3 'CLAHE_' image_name ];
    filename4 = [output_dir4 'result_' image_name ];
    imwrite(J, filename);
    imwrite(K, filename2);
    imwrite(L, filename3);
    saveas(im, filename4, 'jpg');
end