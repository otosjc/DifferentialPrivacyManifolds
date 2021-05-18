%- Carlos J. Soto cjs7363@psu.edu
%- test the exp and inv exp

clear; path(pathdef); close all
addpath('../functions/')

X = wishrnd([2,3;3,8],2);
Y = wishrnd([2,3;3,8],2);

dist_SPDM(X,Y)
dist_SPDM(Y,X)

shoot = inv_exp_map_SPDM(X,Y);

Y_hopefully = exp_map_SPDM(X,shoot);