%- Carlos J. Soto cjs7363@psu.edu
%- Generate random samples using Wishart and then add laplace noise

clear; path(pathdef); close all
addpath('../functions/')

n = 50;
[X,r] = Create_sim_data(n);

[Xhat,norms] = frechet_mean_SPDM(X);

d = zeros(1,n)
for i = 1:n
    d(i) = dist_SPDM(Xhat,X{i});
end
