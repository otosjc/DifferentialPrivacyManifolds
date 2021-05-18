%- Carlos J. Soto cjs7363@psu.edu
%- Generate random samples using Wishart and then add laplace noise

% This script compares the SPDM approach and the SM approach.

clear; path(pathdef); close all
addpath('../functions/')


numRounds = 30;
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





