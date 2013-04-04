% Set up 3D test image
% load the 3D image of size 100
V = tom_emread();
value = V.Value;

% parameters
[v_length, v_width,v_height] = size(value);

theta = 0:5:179;
R = zeros(size(value,1), size(value,1),length(theta));

% take 36 projections
for i = 1:length(theta)
    %rotate matrix
    rotated_img = tom_rotate(value, [270,90,-theta(i)], 'linear');
    R(:,:,i) = sum(rotated_img);
end

X = zeros(v_length, v_width,v_height); 
[A] = SystemMatrix(v_width,theta);

% for each projection angle
b = zeros(v_width,length(theta));
for j = 1:v_height
    for i = 1:length(theta)
        b(:,i) = R(j,:,i);
    end
    %Xkacz = ART2(A,b(:),0.25,2);
    Xkacz = SIRT2(A,b(:),50);
    X(:,:,j) = reshape(Xkacz,v_length,v_width);
end
Xx = tom_rotate(X,[0,0,-90],'linear');
Xx = tom_rotate(Xx,[270,90,180],'linear');
tom_volxyz(Xx);
%figure(3); tom_imagesc(reshape(Xkacz,v_length,v_width));
        


