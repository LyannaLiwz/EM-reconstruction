function [x] = SIRT2(A,b,k)
% SIRT2 - Simultaneous Iterative Reconstruction Technique (SIRT) 
%         method in 2D images
%   it reconstruct the 2D image using SIRT 

% parameter:
%   A, SystemMatrix
%   b, projection
%   k, iteration times
%   x, result

[~,n] = size(A); 
sigma1tilde = svds(A,1);
lambda = 1/sigma1tilde^2;
% Prepare for iteration.
x = zeros(n,1);

% Iterate.
for j=1:k
      x = x - lambda*A'*(A*x-b);
end
