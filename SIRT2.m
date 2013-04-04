function [x] = SIRT2(A,b,k)

[m,n] = size(A); 
sigma1tilde = svds(A,1);
lambda = 1/sigma1tilde^2;
% Prepare for iteration.
x = zeros(n,1);

% Iterate.
for j=1:k
      x = x - lambda*A'*(A*x-b);
end
