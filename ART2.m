function [x] = ART2(A,b,lambda,k)
% ART2 -  Algebraic Reconstruction Technique (ART) method in 2D images
%   it reconstruct the 2D image using ART 

% parameter:
%   A, SystemMatrix
%   R, projection
%   lambda, constance
%   k, iteration times
%   x, result

[~,n] = size(A);
% Prepare for iteration.
x = zeros(n,1);
nai2 = full(sum(abs(A.*A),2));
I = find(nai2>0)';

% Iterate.
for j=1:k
   for i=I
      Ai = full(A(i,:));
      x = x + lambda*(b(i)-Ai*x)*Ai'/nai2(i);
   end
end 
