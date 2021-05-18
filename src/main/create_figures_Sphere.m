%- Make Figures

clear; path(pathdef); close all
addpath('../functions/')
ToSave = 1;

TextSize = 20;
%-----------------------------------------------------------------------
load('..\..\data\processed\Theorem2_49n1_100_Sphere.mat')
maxR = pi/8;
averagesDs = zeros(length(sequence),2);
bound = repelem(1,length(sequence))./(sequence);
for i = 1: length(sequence)
    %scatXY(scatXY(:,1)== 25,:)
    averagesDs(i,:) = mean(scatXY(scatXY(:,1)== sequence(i),:));
end


figure(100)        
scatter(scatXY(:,1),scatXY(:,2),2)
hold on
plot(averagesDs(:,1),averagesDs(:,2),'LineWidth',2,'Color','Blue')
hold on
plot(sequence,bound,'LineWidth',2,'Color','r')
set(gca, 'YScale', 'log','FontSize', TextSize)
xlabel('Sample size') 
ylabel('Log distance') 
xlim([0 500])
ylim([0.00001 0.1])
%ylim([1 0.0001])
yticks([0.00001 0.0001 0.001 0.01 0.1])



if ToSave == 1
    saveas(gcf,'..\..\images\MeanNeighboringDatasets_Sphere.png') 
end



%- Sphere vs Euclid
%-----------------------------------------------------------------------
load('..\..\data\processed\Compare_Sphere_To_Euclid_Epsilon_1_minSampleSize_25_maxSampleSize_500_Rejection_sampler_rm393.mat')
%-----------------------------------------------------------------------
scatXYManifold = [];
scatXYEuclid = [];
for i = 1:size(d2,2)
    scatXYManifold = [scatXYManifold;[sequence',d2(:,i)]];
    scatXYEuclid = [scatXYEuclid;[sequence',d3(:,i)]];
end


MeanManifold = zeros(length(sequence),2);
MeanEuclid = zeros(length(sequence),2);

for i = 1: length(sequence)
    MeanManifold(i,:) = mean(scatXYManifold(scatXYManifold(:,1)== sequence(i),:));
    MeanEuclid(i,:) = mean(scatXYEuclid(scatXYEuclid(:,1)== sequence(i),:));
    tmp999(i) = MeanManifold(i,2)/MeanEuclid(i,2);
end


%-----------------------------------------------------------------------
figure
scatter(scatXYManifold(:,1),scatXYManifold(:,2),2,'Blue')
hold on
scatter(scatXYEuclid(:,1),scatXYEuclid(:,2),2,'Red')
hold on
plot(MeanManifold(:,1),MeanManifold(:,2),'LineWidth',2,'Color','Blue')
hold on
plot(MeanEuclid(:,1),MeanEuclid(:,2),'LineWidth',2,'Color','Red')
hold on
set(gca, 'YScale', 'log','FontSize', TextSize)
xlabel('Sample size') 
ylabel('Log distance') 
xlim([0 500])

if ToSave == 1
    ImageName = ['..\..\images\SpherevsEuclid_replicates_',num2str(size(d1,2)),'.png'];
    saveas(gcf,ImageName) 
end
%-----------------------------------------------------------------------



%-----------------------------------------------------------------------
%-----------------------------------------------------------------------
load('..\..\data\processed\Compare_Sphere_To_Euclid_Epsilon_1_minSampleSize_25_maxSampleSize_500_Rejection_sampler_rm393.mat')
%-----------------------------------------------------------------------
scatXYManifold1 = [];
scatXYEuclid1 = [];
for i = 1:size(d2,2)
    scatXYManifold1 = [scatXYManifold1;[sequence',d2(:,i)]];
    scatXYEuclid1 = [scatXYEuclid1;[sequence',d3(:,i)]];
end

%-sort and filter
LB = round(0.025*size(scatXYManifold(scatXYManifold(:,1)== sequence(1),:),1));
UB = round(0.975*size(scatXYManifold(scatXYManifold(:,1)== sequence(1),:),1));
scatXYManifold2 = [];
scatXYEuclid2 = [];
for i = 1: length(sequence)
    tmp = sort(scatXYManifold1(scatXYManifold1(:,1)== sequence(i),:));
    scatXYManifold2 = [scatXYManifold2;tmp(LB:UB,:)];
    
    tmp = sort(scatXYEuclid1(scatXYEuclid1(:,1)== sequence(i),:));
    scatXYEuclid2 = [scatXYEuclid2;tmp(LB:UB,:)];
end

MeanManifold = zeros(length(sequence),2);
MeanEuclid = zeros(length(sequence),2);

for i = 1: length(sequence)
    MeanManifold(i,:) = mean(scatXYManifold2(scatXYManifold2(:,1)== sequence(i),:));
    MeanEuclid(i,:) = mean(scatXYEuclid2(scatXYEuclid2(:,1)== sequence(i),:));
    tmp99(i) = MeanManifold(i,2)/MeanEuclid(i,2);
end
%-----------------------------------------------------------------------
%-----------------------------------------------------------------------
figure
scatter(scatXYManifold2(:,1),scatXYManifold2(:,2),2,'Blue')
hold on
scatter(scatXYEuclid2(:,1),scatXYEuclid2(:,2),2,'Red')
hold on
plot(MeanManifold(:,1),MeanManifold(:,2),'LineWidth',2,'Color','Blue')
hold on
plot(MeanEuclid(:,1),MeanEuclid(:,2),'LineWidth',2,'Color','Red')
hold on
set(gca, 'YScale', 'log','FontSize', TextSize)
xlabel('Sample size') 
ylabel('Log distance') 
xlim([0 500])

if ToSave == 1
    ImageName = ['..\..\images\SpherevsEuclid_replicates_',num2str(size(d1,2)),'_Filtered.png'];
    saveas(gcf,ImageName) 
end
%-----------------------------------------------------------------------
%-----------------------------------------------------------------------
%-----------------------------------------------------------------------
figure
scatter(scatXYManifold2(:,1),scatXYManifold2(:,2),2,'Blue')
hold on
scatter(scatXYEuclid2(:,1),scatXYEuclid2(:,2),2,'Red')
hold on
plot(MeanManifold(:,1),MeanManifold(:,2),'LineWidth',2,'Color','Blue')
hold on
plot(MeanEuclid(:,1),MeanEuclid(:,2),'LineWidth',2,'Color','Red')
hold on
set(gca, 'YScale', 'log','FontSize', TextSize)
xlabel('Sample size') 
ylabel('Log distance') 
xlim([0 500])
ylim([0.0003 0.5])
yticks([0.001 0.01 0.1])

if ToSave == 1
    ImageName = ['..\..\images\SpherevsEuclid_replicates_',num2str(size(d1,2)),'_Filtered2.png'];
    saveas(gcf,ImageName) 
end
%-----------------------------------------------------------------------





