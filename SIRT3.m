function [Xx] = SIRT3(A,R,k)
% SIRT3 - Simultaneous Iterative Reconstruction Technique (SIRT) 
%         method in 3D images
%   it reconstruct the 3D image using SIRT 

% parameter:
%   A, SystemMatrix
%   R, projection
%   k, iteration times
%   Xx, result


[v_length,v_width,length_theta] = size(R);
v_height = v_width;
X = zeros(v_length, v_width,v_height); 

% for each projection angle
b = zeros(v_width,length_theta);
for j = 1:v_height
    for i = 1:length_theta
        b(:,i) = R(j,:,i);
    end
    Xkacz = SIRT2(A,b(:),k);
    X(:,:,j) = reshape(Xkacz,v_length,v_width);
end
Xx = tom_rotate(X,[0,0,-90],'linear');
Xx = tom_rotate(Xx,[270,90,180],'linear');
