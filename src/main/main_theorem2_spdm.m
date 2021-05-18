%- Carlos J. Soto cjs7363@psu.edu


%- Generate random samples using Wishart then replaces the last element.
% we then calculate the frechet mean of each of these samples and compute
% the distance between these means. This is simulating the sensitivty of
% the Frechet mean.

clear; path(pathdef); close all
addpath('../functions/')

ToSave = 1;

n10 = 30;
minSampleSize = 20;
maxSampleSize = 500;
StepSize = 10;
sequence = [(minSampleSize:StepSize: maxSampleSize)];


d = zeros(length(sequence),n10);
for ii = 1:length(sequence)
    %- create random sample
    % n2 = 10*ii;
    n2 = sequence(ii);
%     V = [0.8,0.2;   0.2,1.4];
%     df = 20;
    V = 1/2 * eye(2);
    df = 2;
    r = 1.5;
    [X, maxR] = Create_sim_data(n2,V,df,r);
    [Xhat1,~] = frechet_mean_SPDM(X);

    
    X2 = X;
    for j = 1:n10
        dtmp = 5000000;
        while dtmp > maxR
            X2{n2} = wishrnd(V,df);
            dtmp = dist_SPDM(V*df,X2{n2});
        end
        %- calculate the FM
        [Xhat2,~] = frechet_mean_SPDM(X2);
        d(ii,j) = dist_SPDM(Xhat1,Xhat2);
    end


end


%- Create the scatter
scatXY = [];
for i = 1:n10
    scatXY = [scatXY;[sequence',d(:,i)]];
end

if ToSave == 1
    FileName = ['..\..\data\processed\Theorem2_',num2str(length(sequence)),'n1_',num2str(n10)];
    save(FileName,'sequence','d','V','df','maxR','scatXY')
    saveas(gcf,'..\..\images\MeanNeighboringDatasets.png') 
end







