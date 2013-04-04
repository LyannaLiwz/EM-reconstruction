V = tom_emread();
value = V.Value;

% parameters
[v_length, v_width,v_height] = size(value);

theta = 0:5:179;
R = zeros(length(theta), size(value,1), size(value,1));

% take 60 projections
for i = 1:length(theta)
    %rotate matrix
    rotated_img = tom_rotate(value, [270, 90, -theta(i)], 'linear');
    R(i,:,:) = sum(rotated_img);
end

 x = -v_length/2 : v_length/2 -1;
 y = -v_width/2 : v_width/2 -1;


% display the projection 
% tom_volxyz(R);

imgProj = zeros(v_length,v_width,v_height);
% 2d fft for each projection

for i = 1: length(theta)
    %fftProj = H.*fftshift(fft(ifftshift(R(i,:))));
    fftProj = fftshift(fftn(ifftshift(R(i,:,:))));
    
%rotate to the original position
    rotate = [cos(theta(i)*pi/180), 0, -sin(theta(i)*pi/180);
              0, 1, 0; 
              sin(theta(i)*pi/180), 0, cos(theta(i)*pi/180)];  
    
%       rotate = [ 1,0,0;
%                  0,cos(theta(i)*pi/180), -sin(theta(i)*pi/180); 
%                  0,sin(theta(i)*pi/180),  cos(theta(i)*pi/180)];    
    
    coords2 = zeros(2,length(x)*length(y));
   
    temp1 = -v_length/2;
    for m = 1:length(x)*length(y)   
        coords2(1,m) = temp1;
        if mod(m,length(y)) == 0 
            temp1 = temp1+1;
        end
    end
    
    temp2 = -v_width/2;
    for m = 1:length(x)*length(y)
        coords2(2,m) = temp2;
        temp2 = temp2+1;
        if mod(m,length(y)) == 0 
            temp2 = -v_width/2;
        end
    end
    
    coords = [coords2;zeros(1,length(x)*length(y))];
    %coordsp = tom_rotate(coords, [0, -theta(i),0], 'linear');
    coordsp = rotate*coords; 

    xfp = coordsp(1,:);
    yfp = coordsp(2,:);
    zfp = coordsp(3,:);
    
    xfp = round(xfp) + v_length/2 + 1;
    yfp = round(yfp) + v_width/2 + 1;
    zfp = round(zfp) + v_height/2 + 1;
    
    [m,n,l] = size(fftProj);
    temp = reshape(fftProj,1,m*n*l);
    
    for j = 1:length(xfp)
        if(0<xfp(j) && xfp(j)<=v_length && 0<yfp(j) && yfp(j)<= v_width && 0<zfp(j) && zfp(j)<=v_height)
            imgProj(xfp(j),yfp(j),zfp(j)) = temp(j);
        end
    end
 
end

fftImage = real(fftshift(ifftn(ifftshift(imgProj))));
%fftImage = (fftImage - min(fftImage(:)))/ (max(fftImage(:)) - min(fftImage(:))) * 255;

tom_volxyz(fftImage);


