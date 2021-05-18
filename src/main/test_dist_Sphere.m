%- Carlos J. Soto cjs7363@psu.edu
%- test create sim data sphere


clear; path(pathdef); close all
addpath('../functions/')



Y = [0,0,1]';
Z = [1,0,0]';
dist_Sphere(Y,Z)


n = 40;
D = zeros(n,n);
X = Create_sim_data_Sphere(n);
for i = 1:n
    for j=1:n
        D(i,j) = dist_Sphere(X{i},X{j});
    end
end
D= 0.5 * (D+D');
imagesc(D)
max(max(D))
min(min(D))
% 
% figure
% sphere 
% hold on
% for i = 1:n
%     hold on
%     scatter3(X{i}(1),X{i}(2),X{i}(3),'filled')
% end
% axis equal
