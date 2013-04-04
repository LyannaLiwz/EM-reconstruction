clear all;
[im,map] = imread('lena.bmp');
im = rgb2gray(im);
im = imresize(im,0.25);
figure(1); imshow(im,map);

% parameters
[height, width] = size(im);
N = height*width;

theta = 0:3:179;
R = zeros(size(im,1),length(theta));

% take 60 projections
for i = 1:length(theta)
    rotated_img = imrotate(im, -theta(i), 'bilinear', 'crop');
    R(:,i) = sum(rotated_img);    
end

%figure(2);imshow(R,map);
[A] = SystemMatrix(height,theta);
Xkacz = ART2(A,R(:),0.25,2);
%Xkacz = SIRT2(A,R(:),50);
figure(3); imshow(uint8(reshape(Xkacz,height,height)));
