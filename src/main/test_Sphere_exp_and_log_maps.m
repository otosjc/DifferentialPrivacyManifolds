%- Carlos J. Soto cjs7363@psu.edu
%- test exp map and inv exp map of sphere


clear; path(pathdef); close all
addpath('../functions/')


Y = [0,0,1]';
Z = [1,0,0]';

V = inv_exp_map_Sphere(Y,Z);
Zhope = exp_map_Sphere(Y,V,1)

%- 05/04/2021 these seem to work with the unit sphere. There is no check
%for if they are on same sphere but can implement if needed