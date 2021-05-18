%- Carlos J. Soto cjs7363@psu.edu
%- test Frechet mean

clear; path(pathdef); close all
addpath('../functions/')



Ybar = eye(2);
sigma = 0.1;
X0 = rand(1,2);
n = 1000;
Y = cell(1,n);
for i =1:n
    Y{i} = Laplace_SPDM(Ybar, sigma, X0);
end

Yhat = frechet_mean_SPDM(Y);


%- parameters
n2 = 1000;
V = [2,1;1,6];
df = 20;
%- create random sample
for i = 1:n2
    X{i} = wishrnd(V,df);
end
%- calculate the FM
[Xhat,norms] = frechet_mean_SPDM(X);


%- population mean
df * V
%- sample mean
Xhat
figure
plot(1:size(norms,2),norms,'LineWidth',2.2)