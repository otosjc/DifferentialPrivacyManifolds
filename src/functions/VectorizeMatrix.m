function [VecX] = VectorizeMatrix(X)
%- Created by Carlos J. Soto cjs7363@psu.edu

%- This function vectorizes a symmetrix matrix. See the overarching
% function Laplace_SM for its usage.

%- Input:
%- X 						- A symmetric matrix

%- Output:
%- VecX                     -the upper triangular portion stacked into a vector

n = size(X,1);
VecSize = n*(n+1)/2;
% Create boolean indices and convert SPDM to vector.
Idx = reshape(triu(ones(n,n))',[1,n^2]); 
Idx = logical(Idx);
VecX = reshape(triu(X)',[1,n^2]);
VecX = VecX(Idx);

end

