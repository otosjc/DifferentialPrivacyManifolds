%- Make Figures

clear; path(pathdef); close all
addpath('../functions/')
ToSave = 1;

TextSize = 20;

DataDir = '..\..\data\processed\';%- Make Figures

%-----------------------------------------------------------------------
load('..\..\data\processed\Theorem2_49n1_30.mat')
averagesDs = zeros(length(sequence),2);
bound = repelem(2*maxR,length(sequence))./(sequence);
for i = 1: length(sequence)
    %scatXY(scatXY(:,1)== 25,:)
    averagesDs(i,:) = mean(scatXY(scatXY(:,1)== sequence(i),:));
end


figure        
% scatter(scatXY(:,1),log(scatXY(:,2)),1)
scatter(scatXY(:,1),scatXY(:,2),2)
hold on
plot(averagesDs(:,1),averagesDs(:,2),'LineWidth',2,'Color','Blue')
hold on
plot(sequence,bound,'LineWidth',2,'Color','r')
set(gca, 'YScale', 'log','FontSize', TextSize)
xlabel('Sample size') 
ylabel('Distance') 
xlim([0 500])

if ToSave == 1
    saveas(gcf,'..\..\images\Sensitivity_SPDM.png') 
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
    saveas(gcf,'..\..\images\Utility_SPDM.png') 
end
%-----------------------------------------------------------------------



%- Utility Comparison SPDM v SM with CI bands
%-----------------------------------------------------------------------
load('..\..\data\processed\Compare_SPDM_To_SM_Epsilon_1_minSampleSize_20_maxSampleSize_500.mat')
%-----------------------------------------------------------------------
n = size(d1,1);
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
    sdM(i,:) = var(scatXYManifold(scatXYManifold(:,1)== sequence(i),:));
    sdM(i,:) = sqrt(sdM(i,:));
    LBM(i,:) = MeanManifold(i,:) - 2*sdM(i,:)/sqrt(n);
    UBM(i,:) = MeanManifold(i,:) + 2*sdM(i,:)/sqrt(n);
    
    MeanEuclid(i,:) = mean(scatXYEuclid(scatXYEuclid(:,1)== sequence(i),:));
    sdE(i,:) = var(scatXYEuclid(scatXYEuclid(:,1)== sequence(i),:));
    sdE(i,:) = sqrt(sdE(i,:));
    LBE(i,:) = MeanEuclid(i,:) - 2*sdE(i,:)/sqrt(n);
    UBE(i,:) = MeanEuclid(i,:) + 2*sdE(i,:)/sqrt(n);
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
    saveas(gcf,'..\..\images\Utility_Comparison_SPDMversusSM.png') 
end
%-----------------------------------------------------------------------
%-----------------------------------------------------------------------
figure
plot(MeanManifold(:,1),MeanManifold(:,2),'LineWidth',2,'Color','Blue')
hold on
plot(LBM(:,1),LBM(:,2),'LineWidth',1,'Color','Blue')
hold on
plot(UBM(:,1),UBM(:,2),'LineWidth',1,'Color','Blue')
hold on
fill([sequence'; flipud(sequence')]', [LBM(:,2); flipud(UBM(:,2))], 'b', 'FaceAlpha',0.5); 
hold on
plot(MeanEuclid(:,1),MeanEuclid(:,2),'LineWidth',2,'Color','Blue')
hold on
plot(LBE(:,1),LBE(:,2),'LineWidth',1,'Color','Red')
hold on
plot(UBE(:,1),UBE(:,2),'LineWidth',1,'Color','Red')
hold on
fill([sequence'; flipud(sequence')]', [LBE(:,2); flipud(UBE(:,2))], 'r', 'FaceAlpha',0.5); 
set(gca, 'YScale', 'log','FontSize', TextSize)
xlabel('Sample size') 
ylabel('Distance') 
xlim([0 500])


if ToSave == 1
    saveas(gcf,'..\..\images\Utility_Comparison_SPDMversusSM_CI.png') 
end
%-----------------------------------------------------------------------









