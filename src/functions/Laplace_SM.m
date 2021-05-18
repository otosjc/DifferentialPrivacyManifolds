function Y = Laplace_SM(Ybar,sigma)
%- Created by Carlos J. Soto cjs7363@psu.edu

%- This function generates a random sample from the Laplace of
%Symmetric matrices.

%- Input:
%- Ybar             - an nxn footprint of the Laplace
%- sigma            - an R^1 value sd of the Laplace that goes into sinh 

%- Output:
%- Y                - An nxn random sample from Laplace symmetric


n = size(Ybar,1);
VecSize = n*(n+1)/2;
% Create boolean indices and convert SPDM to vector.
Idx = reshape(triu(ones(n,n))',[1,n^2]); 
Idx = logical(Idx);
VecYbar = reshape(triu(Ybar)',[1,n^2]);
VecYbar = VecYbar(Idx);

%- Sample from Unit sphere
U = normrnd(0,1,[1,VecSize]);
U = U/norm(U);

%- Sample from Gamma
R = gamrnd(VecSize,1);

%- The random Laplace in R n(n+1)/2
LapSamp = VecYbar + R * sigma * U;



y = zeros(n);
idx = triu(true(n));
y(idx) = LapSamp; 
Y = y + y.' - diag(diag(y));

 

end
