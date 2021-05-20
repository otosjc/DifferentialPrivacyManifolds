%- Carlos J. Soto cjs7363@psu.edu

%- Generate random samples using the uniform polar coordinate approach
% then replaces the last element. we then calculate the frechet mean 
% of each of these samples and compute the distance between these means. 
% This is simulating the sensitivty.

clear; path(pathdef); %close all
addpath('../functions/')

ToSave = 0;

n10 = 100;                      % replicates per sample size
minSampleSize = 20;
maxSampleSize = 500;
StepSize = 10;
sequence = [(minSampleSize:StepSize: maxSampleSize)];


d = zeros(length(sequence),n10);
for ii = 1:length(sequence)
    %- create random sample
    n2 = sequence(ii);
    [X,r] = Create_sim_data_Sphere(n2);    
    [Xhat1,~] = frechet_mean_Sphere(X);

    
    X2 = X;
    for j = 1:n10
        X2(n2,:) = Create_sim_data_Sphere(1);
        %- calculate the FM
        [Xhat2,~] = frechet_mean_Sphere(X2);
        d(ii,j) = dist_Sphere(Xhat1,Xhat2);
    end


end



%- Create the scatter
scatXY = [];
for i = 1:n10
    scatXY = [scatXY;[sequence',d(:,i)]];
end


if ToSave == 1
    FileName = ['..\..\data\processed\Sphere_Sensitivity_',num2str(length(sequence)),'replicates_',num2str(n10)];
    save(FileName,'sequence','d','scatXY')
end



%-----------------------------------------------------------------------
%---                    Figure                                      ---%
%-----------------------------------------------------------------------
TextSize = 20;

averagesDs = zeros(length(sequence),2);
bound = repelem(1,length(sequence))./(sequence);
for i = 1: length(sequence)
    averagesDs(i,:) = mean(scatXY(scatXY(:,1)== sequence(i),:));
end


figure     
scatter(scatXY(:,1),scatXY(:,2),2)
hold on
plot(averagesDs(:,1),averagesDs(:,2),'LineWidth',2,'Color','Blue')
hold on
plot(sequence,bound,'LineWidth',2,'Color','r')
set(gca, 'YScale', 'log','FontSize', TextSize)
xlabel('Sample size') 
ylabel('Distance') 
xlim([0 500])
ylim([0.00001 0.1])
yticks([0.00001 0.0001 0.001 0.01 0.1])

if ToSave == 1
    saveas(gcf,'..\..\images\Sensitivity_Sphere.png') 
end






