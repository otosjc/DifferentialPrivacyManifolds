%- Make Figures

clear; path(pathdef); close all
addpath('../functions/')
ToSave = 1;

TextSize = 20;

%-----------------------------------------------------------------------
load('..\..\data\processed\Theorem2_49n1_30.mat')
averagesDs = zeros(length(sequence),2);
bound = repelem(4*maxR,length(sequence))./(sequence);
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
ylabel('Log distance') 
xlim([0 500])

if ToSave == 1
    saveas(gcf,'..\..\images\MeanNeighboringDatasets3.png') 
end
%-----------------------------------------------------------------------
%-----------------------------------------------------------------------



%-----------------------------------------------------------------------
load('..\..\data\processed\Theorem3_Epsilon_1_minSampleSize_20_maxSampleSize_500.mat')
%-----------------------------------------------------------------------
scatXY = [];
for i = 1:size(d,2)
    scatXY = [scatXY;[sequence',d(:,i)]];
end

averagesDs2 = zeros(length(sequence),2);
for i = 1: length(sequence)
    averagesDs2(i,:) = mean(scatXY(scatXY(:,1)== sequence(i),:));
end


%-----------------------------------------------------------------------
figure
scatter(scatXY(:,1),scatXY(:,2),2)
hold on
plot(averagesDs2(:,1),averagesDs2(:,2),'LineWidth',2,'Color','Blue')
hold on
set(gca, 'YScale', 'log','FontSize', TextSize)
xlim([0 500])

if ToSave == 1
    saveas(gcf,'..\..\images\DmeanAndPrivMean3.png') 
end
%-----------------------------------------------------------------------




%-SPDM v SM
%-----------------------------------------------------------------------
load('..\..\data\processed\Compare_SPDM_To_SM_Epsilon_1_minSampleSize_20_maxSampleSize_500.mat')
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
    saveas(gcf,'..\..\images\SPDMversusSM.png') 
end
%-----------------------------------------------------------------------









