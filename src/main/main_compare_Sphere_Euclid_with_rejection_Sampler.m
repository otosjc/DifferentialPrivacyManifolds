%- Carlos J. Soto cjs7363@psu.edu

% This script compares the Sphere approach and the Euclid approach.

clear; path(pathdef); close all
addpath('../functions/')



numRounds = 100;
minSampleSize = 25;
maxSampleSize = 500;
StepSize = 25;
sequence = [(minSampleSize:StepSize: maxSampleSize)];
ToSave = 1;

d = zeros(1,length(sequence));
tic
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
        Y = Laplace_sphere_Rejection_Sampler(Xhat,sigma,1);        
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
toc



if ToSave == 1
    FileName = ['..\..\data\processed\Compare_Sphere_To_Euclid_Epsilon_',num2str(Epsilon),'_minSampleSize_',num2str(minSampleSize),'_maxSampleSize_',num2str(maxSampleSize),'_Rejection_sampler_rm',num2str(round(1000*r_m))];
    save(FileName,'sequence','d1','d2','d3','Epsilon','r_m')
end





