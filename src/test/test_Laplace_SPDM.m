%- Carlos J. Soto cjs7363@psu.edu
%- test the Laplace SPDM

clear; path(pathdef); close all
addpath('../functions/')



Ybar = eye(2);
sigma = 0.1;
X0 = rand(1,2);
Y = Laplace_SPDM(Ybar, sigma, X0)
dist_SPDM(Ybar,Y)


%- check if Y is SPDM
if all(eig(Y) > 0) && isequal(Y,Y')
    disp('Y is SPDM')
else
    disp('Y is not SPDM')
end

