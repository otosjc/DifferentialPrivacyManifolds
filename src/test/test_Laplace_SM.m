%- Carlos J. Soto cjs7363@psu.edu
%- test the Laplace SPDM

clear; path(pathdef); close all
addpath('../functions/')



Ybar = eye(2);
sigma = 0.1;
X0 = rand(1,2);
Y = Laplace_SM(Ybar, sigma)


