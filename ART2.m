function [x] = ART2(A,b,lambda,k)

[m,n] = size(A); 
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
