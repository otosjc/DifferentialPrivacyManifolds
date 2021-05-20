%- Carlos J. Soto cjs7363@psu.edu

% This script compares the Sphere Utility and the Euclid Utility.

clear; path(pathdef); %close all
addpath('../functions/')



numRounds = 100;                %number of replicates per sample size
minSampleSize = 25;
maxSampleSize = 500;
StepSize = 25;
sequence = [(minSampleSize:StepSize: maxSampleSize)];
ToSave = 0;

d = zeros(1,length(sequence));
for jj = 1:numRounds
    for ii = 1:length(sequence)
        %- first create our data
        n2 = sequence(ii);
        %- create random sample
        [X,r_m] = Create_sim_data_Sphere(n2);
        r = r_m;
        %- calculate the FM
        [Xhat,~] = frechet_mean_Sphere(X);


        %- Sphere Laplace parameters
        Delta = (1/n2)*(tan(2*r));
        Epsilon = 1;
        sigma = Delta /Epsilon;
        Y = Laplace_sphere_Rejection_Sampler(Xhat,sigma);        
        PrivXhat = Y;
        d1(ii,jj) = dist_Sphere(Xhat,PrivXhat);
        d2(ii,jj) = norm(Xhat-PrivXhat);


        %- Euclid sphere Laplace parameters
        r_E = 2*sin(r/2);
        Delta = (1/n2)*(2*r_E);
        Epsilon = 1;
        sigma = Delta /Epsilon;
        Y = Laplace_Vector(Xhat, sigma);
        PrivXhat = Y;
        d3(ii,jj) = norm(Xhat-PrivXhat);  

    end
end

if ToSave == 1
    FileName = ['..\..\data\processed\Compare_Sphere_To_Euclid_Epsilon_',num2str(Epsilon),'_minSampleSize_',num2str(minSampleSize),'_maxSampleSize_',num2str(maxSampleSize),'_Rejection_sampler_rm',num2str(round(1000*r_m))];
    save(FileName,'sequence','d1','d2','d3','Epsilon','r_m')
end

%-----------------------------------------------------------------------
%---                    Figure                                      ---%
%-----------------------------------------------------------------------
TextSize = 20;



scatXYManifold = [];
scatXYEuclid = [];
for i = 1:size(d2,2)
    scatXYManifold = [scatXYManifold;[sequence',d2(:,i)]];
    scatXYEuclid = [scatXYEuclid;[sequence',d3(:,i)]];
end

n = size(d1,2);
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
    
    
    tmp(i) = MeanManifold(i,2)/MeanEuclid(i,2);
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
xlim([25 500])
if ToSave == 1
    saveas(gcf,['..\..\images\Utility_SpherevsEuclid_replicates_',num2str(size(d1,2)),'_CI.png']) 
end
%-----------------------------------------------------------------------



