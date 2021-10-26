%- Carlos J. Soto cjs7363@psu.edu
%- Generate random samples using Wishart and then add laplace noise

%This script compares the SPDM approach and the SM approach.

clear; path(pathdef); close all
addpath('../functions/')



numRounds = 1000;
minSampleSize = 25;
maxSampleSize = 500;
StepSize = 25;
sequence = [(minSampleSize:StepSize: maxSampleSize)];
ToSave = 1;

d = zeros(1,length(sequence));
d1 = zeros(length(sequence),numRounds);
d2 = d1;
tic
[EmpUpperBound,~] = empirical_2r(pi/8);
for ii = 1:length(sequence)
    %- first create our data
    n2 = sequence(ii)

    %- create random sample
    [X,r_m] = Create_sim_data_Sphere(n2);
    r = r_m;
    %- calculate the FM
    [Xhat,~] = frechet_mean_Sphere(X);



    %- Sphere Laplace parameters
    % put correct R here.
%         Delta = (1/n2)*(tan(2*r));
    Delta = EmpUpperBound/ (2*n2*r_m*cot(2*r_m));
    Epsilon = 1;
    sigma = Delta /Epsilon;
    Lsamp = Laplace_sphere_MCMC2(sigma,numRounds);
    AA = Xhat'*[0,0,1];
    [a,~,c] = svd(AA);
    S = eye(3);
%     if det(AA) < 0
%         S(:,end) = -S(:,end);
%     end
    RotatMat = a*S*c';

    RotatedLap = RotatMat*Lsamp';
%     Y = Laplace_sphere_Rejection_Sampler(Xhat,sigma,1);  
    for jj = 1:numRounds
        PrivXhat = RotatedLap(:,jj);
        d1(ii,jj) = dist_Sphere(Xhat,PrivXhat);
        d2(ii,jj) = norm(Xhat-PrivXhat');
    end


    %- Euclid sphere Laplace parameters
    r_E = 2*sin(r/2);
    Delta = (1/n2)*(2*r_E);

    Epsilon = 1;
    sigma = Delta /Epsilon;
    for jj = 1:numRounds
        Y = Laplace_Vector(Xhat, sigma);
        PrivXhat = Y;
        d3(ii,jj) = norm(Xhat-PrivXhat);
    end


end

toc



figure
for i=1:numRounds
    hold on
    plot(sequence,d2(:,i),'LineWidth',2,'Color','Blue')
    hold on
    plot(sequence,d3(:,i),'LineWidth',2,'Color','Red')
end



if ToSave == 1
%     FileName = ['..\..\data\processed\Compare_Sphere_To_Euclid_Empirical_Epsilon_',num2str(Epsilon),'_minSampleSize_',num2str(minSampleSize),'_maxSampleSize_',num2str(maxSampleSize),'_MCMC_rm',num2str(round(1000*r_m))];
    FileName = ['..\..\data\processed\Compare_Sphere_To_Euclid_Empirical_Epsilon_',num2str(Epsilon),'_replicates_',num2str(numRounds),'_minSampleSize_',num2str(minSampleSize),'_maxSampleSize_',num2str(maxSampleSize),'_MCMC_rm',num2str(round(1000*r_m))];
    save(FileName,'sequence','d1','d2','d3','Epsilon','r_m')
    %saveas(gcf,'..\..\images\DmeanAndPrivMean.png') 
end





