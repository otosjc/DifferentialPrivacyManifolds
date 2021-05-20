%- Carlos J. Soto cjs7363@psu.edu
%- Generate random samples using Wishart and then add laplace noise

% This script compares the SPDM Utility and the SM Utility.

clear; path(pathdef); %close all
addpath('../functions/')


numRounds = 30;                     % number of replicates per sample size
minSampleSize = 20;
maxSampleSize = 500;
StepSize = 10;
sequence = [(minSampleSize:StepSize: maxSampleSize)];
ToSave = 0;

d = zeros(1,length(sequence));
count = d;
for jj = 1:numRounds
    for ii = 1:length(sequence)
        %- first create our data
        %- parameters for wishart
        n2 = sequence(ii);
        V = 1/2 * eye(2);
        df = 2;
        r = 1.5;
        %- create random sample
        [X,maxR] = Create_sim_data(n2,V,df,r);
        %- calculate the FM
        [Xhat,norms] = frechet_mean_SPDM(X);



        %- SPDM Laplace parameters
        r = maxR;
        Delta = 4*r/n2;
        Epsilon = 1;
        sigma = Delta /Epsilon;
        X0 = rand(1,2);
        Y = Laplace_SPDM(Xhat, sigma, X0);
        PrivXhat = Y;
        d1(ii,jj) = dist_SPDM(Xhat,PrivXhat);
        d2(ii,jj) = norm(VectorizeMatrix(Xhat)-VectorizeMatrix(PrivXhat));


        %- SM Laplace parameters
        r = exp(r) -1;
        Delta = 4*r/n2;
        Epsilon = 1;
        sigma = Delta /Epsilon;
        Y = Laplace_SM(Xhat, sigma);
        PrivXhat = Y;
        d3(ii,jj) = norm(VectorizeMatrix(Xhat)-VectorizeMatrix(PrivXhat));
        % d4(ii) = dist_SPDM(Xhat,PrivXhat);
        if ~ all(eig(PrivXhat) > 0) 
            count(ii) = count(ii) +1;
        end  

    end
    end
%- percentage of matrices not SPDM at each sample size
propNotSPDM = count(ii)/(numRounds);


if ToSave == 1
    FileName = ['..\..\data\processed\Compare_SPDM_To_SM_Epsilon_',num2str(Epsilon),'_minSampleSize_',num2str(minSampleSize),'_maxSampleSize_',num2str(maxSampleSize)];
    save(FileName,'sequence','d1','d2','d3','V','df','Epsilon','propNotSPDM')
end



%-----------------------------------------------------------------------
%---                    Figure                                      ---%
%-----------------------------------------------------------------------
TextSize = 20;
n = numRounds;
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







