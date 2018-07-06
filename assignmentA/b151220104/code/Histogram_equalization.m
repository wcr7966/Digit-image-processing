function [output1, output2, output3] = Histogram_equalization(input_image)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    r=input_image(:,:,1);
    v=input_image(:,:,2);
    b=input_image(:,:,3);
    r1 = hist_equal(r);
    v1 = hist_equal(v);
    b1 = hist_equal(b);
    [output1] = cat(3,r1,v1,b1);    %RGB
    [output2] = hsv(input_image);   %HSV
    [output3] = CLAHE(input_image);    %CLAHE
else
    %this is a gray image
    [output1] = hist_equal(input_image);
    [output2] = hist_equal(input_image);
    [output3] = hist_equal(input_image);
    
end