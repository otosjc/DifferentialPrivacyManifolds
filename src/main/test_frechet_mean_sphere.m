%- Carlos J. Soto cjs7363@psu.edu
%- test Frechet mean sphere

clear; path(pathdef); close all
addpath('../functions/')


n = 40;
X = Create_sim_data_Sphere(n);

[Xhat,norms] = frechet_mean_Sphere(X);


%- population mean
% df * V
%- sample mean
Xhat
figure
plot(1:size(norms,2),norms,'LineWidth',2.2)



figure
sphere 
hold on
for i = 1:n
    hold on
    scatter3(X(i,1),X(i,2),X(i,3),'filled','blue')
end
hold on 
scatter3(Xhat(1),Xhat(2),Xhat(3),'filled','red')
axis equal