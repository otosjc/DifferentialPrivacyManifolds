%- Carlos J. Soto cjs7363@psu.edu
%- test create uniform grid

%- 05/10/21 no longer a test, this is the main

clear; path(pathdef); close all
addpath('../functions/')

ToSave = 1;
n = 50000000;
X = Create_Uniform_Grid_Sphere(n);


% figure
% sphere 
% hold on
% for i = 1:n
%     hold on
%     scatter3(X(i,1),X(i,2),X(i,3),'filled')
% end
% axis equal

if ToSave == 1
    FileName = ['..\..\data\interim\Uniform_Grid_samples_',num2str(n)];
    save(FileName,'X')
end


