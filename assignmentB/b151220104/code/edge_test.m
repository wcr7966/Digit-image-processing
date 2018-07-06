%DIP16 Assignment 2
%Edge Detection
%In this assignment, you should build your own edge detection and edge linking 
%function to detect the edges of a image.
%Please Note you cannot use the build-in matlab edge and bwtraceboundary function
%We supply four test images, and you can use others to show your results for edge
%detection, but you just need do edge linking for rubberband_cap.png.
clc; clear all;
% Load the test image
% imgTest = imread('./asset/image/rubberband_cap.png');
imgTest = imread('./asset/image/moon.jpg');
imgTestGray = rgb2gray(imgTest);

% 高斯滤波
sigma = 1.5;
gausFilter = fspecial('gaussian', [5, 5], sigma);
filter_gray_image= imfilter(imgTestGray, gausFilter, 'replicate');


%now call your function my_edge, you can use matlab edge function to see
%the last result as a reference first
sobel = edge(imgTestGray, 'sobel');
mySobel = my_edge(imgTestGray, 'sobel');
log = edge(imgTestGray, 'log');
myLog = my_edge(imgTestGray, 'log');
canny = my_edge(filter_gray_image, 'canny');
myCanny = my_edge(filter_gray_image, 'canny');

figure;clf;
imshow(imgTestGray);
figure;clf;
subplot(3, 2, 1);imshow(sobel);title("自带的sobel");
subplot(3, 2, 2);imshow(mySobel);title("mysobel");
subplot(3, 2, 3);imshow(log);title("自带的log");
subplot(3, 2, 4);imshow(myLog);title("mylog");
subplot(3, 2, 5);imshow(canny);title("自带的canny");
subplot(3, 2, 6);imshow(myCanny);title("mycanny");

figure;imshow(sobel);
figure;imshow(mySobel);
figure;imshow(log);
figure;imshow(myLog);
figure;imshow(canny);
figure;imshow(myCanny);

%using imtool, you select a object boundary to trace, and choose
%an appropriate edge point as the start point 
% my_img_link = my_edgelinking(myCanny);
% figure;clf;
% background = im2bw(imgTest, 1);
% imshow(background);
% imtool(my_img_link);
% %now call your function my_edgelinking, you can use matlab bwtraceboundary 
% %function to see the last result as a reference first. please trace as many 
% %different object boundaries as you can, and choose different start edge points.
% 
% % Bxpc = bwtraceboundary(img_edge, [153, 109], 'N');
% Bxpc1 = my_edgetracing(my_img_link, 390, 164);
% Bxpc2 = my_edgetracing(my_img_link, 253, 64);
% Bxpc3 = my_edgetracing(my_img_link, 80, 152);
% Bxpc4 = my_edgetracing(my_img_link, 99, 151);
% Bxpc5 = my_edgetracing(my_img_link, 78, 230);
% Bxpc6 = my_edgetracing(my_img_link, 212, 294);
% Bxpc7 = my_edgetracing(my_img_link, 293, 90);
% Bxpc8 = my_edgetracing(my_img_link, 389, 151);
% Bxpc9 = my_edgetracing(my_img_link, 215, 128);
% hold on
% plot(Bxpc1(:,1), Bxpc1(:,2), 'w', 'LineWidth', 1);
% plot(Bxpc2(:,1), Bxpc2(:,2), 'w', 'LineWidth', 1);
% plot(Bxpc3(:,1), Bxpc3(:,2), 'w', 'LineWidth', 1);
% plot(Bxpc4(:,1), Bxpc4(:,2), 'w', 'LineWidth', 1);
% plot(Bxpc5(:,1), Bxpc5(:,2), 'w', 'LineWidth', 1);
% plot(Bxpc6(:,1), Bxpc6(:,2), 'w', 'LineWidth', 1);
% plot(Bxpc7(:,1), Bxpc7(:,2), 'w', 'LineWidth', 1);
% plot(Bxpc8(:,1), Bxpc8(:,2), 'w', 'LineWidth', 1);
% plot(Bxpc9(:,1), Bxpc9(:,2), 'w', 'LineWidth', 1);