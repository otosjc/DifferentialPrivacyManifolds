%- Carlos J. Soto cjs7363@psu.edu
%- test the Laplace Sphere

clear; path(pathdef); close all
addpath('../functions/')

load('../../data/interim/Uniform_Grid_samples_5000.mat')
XGrid = X;
clear X


n = 40;
X = Create_sim_data_Sphere(n);


Xhat = frechet_mean_Sphere(X);


%- test the weights function
[Xweights,dists] = Laplace_Sphere_weights(Xhat,X);
[aa,bb] = max(Xweights);
[aa2,bb2] = min(Xweights);

figure
sphere 
hold on
for i = 1:n
    hold on
    scatter3(X(i,1),X(i,2),X(i,3),'filled','blue')
end
hold on
scatter3(X(bb,1),X(bb,2),X(bb,3),'filled','red')
hold on
scatter3(X(bb2,1),X(bb2,2),X(bb2,3),'filled','black')
axis equal



% test the actual laplace
[Y] = Laplace_sphere(Xhat,XGrid);
figure
sphere 
hold on
for i = 1:n
    hold on
    scatter3(X(i,1),X(i,2),X(i,3),'filled','blue')
end
hold on
scatter3(Y(1),Y(2),Y(3),'filled','red')
axis equal



