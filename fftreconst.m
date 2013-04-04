function [fftImage] = fftreconst(R,theta)
% FFTRECST - Computed tomography reconstrction 2D
%   This function takes the projected slices and projection theta angles
%   to reconstruct the original data in 2D.
%   
%   Assume the originial image is square.
%
%   Parameters:
%   R, projected slices, size[theta, 2*imsize], 
%   theta, dgree of the projectoin angles
%   imsize, original imsize


% length of angles and image size, assume square
[ThetaLength, HeightDouble] = size(R);
height = HeightDouble*0.5;
width = height;
imgProj = zeros(height,width);


% 1d fft for each projection
for i = 1: ThetaLength;
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

% get the image 
fftImage = real(fftshift(ifft2(ifftshift(imgProj))));
fftImage = imrotate(fftImage, 90);
fftImage = fftImage(height/2+1:width+height/2,height/2+1:width+height/2);

%Normalization
fftImage = (fftImage - min(fftImage(:)))/ (max(fftImage(:)) - min(fftImage(:))) * 255;
