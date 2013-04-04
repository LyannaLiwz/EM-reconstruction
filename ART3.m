function [Xx] = ART3(A,R,lambda,k)
% ART3 -  Algebraic Reconstruction Technique (ART) method in 3D images
%   it reconstruct the 3D image using ART 

% parameter:
%   A, SystemMatrix
%   R, projection
%   lambda, constance
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
    Xkacz = ART2(A,b(:),lambda,k);
    X(:,:,j) = reshape(Xkacz,v_length,v_width);
end
Xx = tom_rotate(X,[0,0,-90],'linear');
Xx = tom_rotate(Xx,[270,90,180],'linear');
