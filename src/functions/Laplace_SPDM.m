function Y = Laplace_SPDM(Ybar,sigma,X0)
%- Created by Carlos J. Soto cjs7363@psu.edu

%- This function generates a random sample from the Laplace of
%SPDM matrices.

%- Input:
%- Ybar             - an nxn footprint of the Laplace
%- sigma            - an R^1 value sd of the Laplace that goes into sinh 
%- X0               - 1xn initial random step

%- Output:
%- Y                - An nxn random sample from Laplace SPDM

% For details see Riemannian Laplace distribution on the space of 
% symmetric positive definite matrices by Hajri et al.

n = size(Ybar,1);
if nargin == 1
    sigma = 0.5;
    X0 = rand(1,n);
end


%- Metropolis step for sampling from sinh distribution
iter = 10000;
MX = zeros(iter,n);
prevX = X0;
for i = 1:iter
    % random uniform step
    Y = rand(1,n) - 0.5 + prevX;
    ARprob = exp((norm(prevX)-norm(Y))/sigma) * SinhPart(Y) / SinhPart(prevX);
    ARprob = min(ARprob,1);
    if  rand < ARprob
        MX(i,:) = Y;
    else
        MX(i,:) = prevX;
    end
    prevX = MX(i,:);
end
    

%- Randomly sample from the uniform
A = normrnd(0,1,n,n);
[Q,~] = qr(A);

%- Step 3
X = Q' * diag(exp(MX(end,:)))* Q;

%- Step 4
%- A dot B means   A' *B* A
YbarHalf = Ybar^(1/2);
Y = YbarHalf' * X * YbarHalf;

end
