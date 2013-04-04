[im,map] = imread('lena.bmp');
im = rgb2gray(im);
im = imresize(im,0.5);
figure(1); imshow(im,map);

% parameters
[height, width] = size(im);

theta = 0:1:179;
R = zeros(length(theta), 2*size(im,1));

% take 180 projections
for i = 1:length(theta)
    rotated_img = imrotate(im, -theta(i), 'bilinear', 'crop');
    R(i,height/2+1:width+height/2) = sum(rotated_img);
end

% allocate memory 
imgProj = zeros(height,width);

% reconstruct
[fftImage] = fftreconst(R,theta);

% result 
figure; imshow(fftImage,map);


          
          
          
          
          
          
