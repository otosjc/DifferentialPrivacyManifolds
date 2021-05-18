%- Carlos J. Soto cjs7363@psu.edu
%- test create sim data sphere


clear; path(pathdef); close all
addpath('../functions/')

n = 300;
X = Create_sim_data_Sphere(n);


figure
sphere 
hold on
for i = 1:n
    hold on
    scatter3(X(i,1),X(i,2),X(i,3),'filled')
end
axis equal
