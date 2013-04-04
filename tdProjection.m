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

imgProj = zeros(height,width);
filter_size = 512;
H = linspace(256,-255,filter_size);
H = abs(H);

% 1d fft for each projection
[m,n] = size(R);
for i = 1: length(theta)
    %fftProj = H.*fftshift(fft(ifftshift(R(i,:))));
    fftProj = fftshift(fft(ifftshift(R(i,:))));
    
    x = -height : width-1;
    y = zeros(1,2*width);

% rotate to the original position
    rotate = [cos(theta(i)*pi/180), -sin(theta(i)*pi/180);
              sin(theta(i)*pi/180),  cos(theta(i)*pi/180)];  
    coords = [x;y];
    coordsp = rotate*coords; 

    xfp = coordsp(1,:);
    yfp = coordsp(2,:); 
    
    xfp = round(xfp) + height + 1;
    yfp = round(yfp) + width + 1;
      
    for j = 1:length(fftProj)
       if(0<xfp(j) && xfp(j)<=2*height && 0<yfp(j) && yfp(j)<=2*width)
            imgProj(xfp(j),yfp(j)) = fftProj(j);
       end
    end
    
end



fftImage = real(fftshift(ifft2(ifftshift(imgProj))));
fftImage = imrotate(fftImage, 90);
fftImage = fftImage(height/2+1:width+height/2,height/2+1:width+height/2);

fftImage = (fftImage - min(fftImage(:)))/ (max(fftImage(:)) - min(fftImage(:))) * 255;


figure; imshow(fftImage,map);


% nfft 
% 1d nfft for each projection

          
          
          
          
          
          
