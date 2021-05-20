%- Carlos J. Soto cjs7363@psu.edu


%- Generate random samples using Wishart then replaces the last element.
% we then calculate the frechet mean of each of these samples and compute
% the distance between these means. This is simulating the sensitivty of
% the Frechet mean.

clear; path(pathdef); %close all
addpath('../functions/')

ToSave = 0;

n10 = 30;                            % replicates per sample size
minSampleSize = 20;
maxSampleSize = 500;
StepSize = 10;
sequence = [(minSampleSize:StepSize: maxSampleSize)];


d = zeros(length(sequence),n10);
for ii = 1:length(sequence)
    %- create random sample
    n2 = sequence(ii);
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



%- Create the scatter for plots
scatXY = [];
for i = 1:n10
    scatXY = [scatXY;[sequence',d(:,i)]];
end

if ToSave == 1
    FileName = ['..\..\data\processed\SPDM_Sensitivity_',num2str(length(sequence)),'replicates_',num2str(n10)];
    save(FileName,'sequence','d','V','df','maxR','scatXY')
end



%-----------------------------------------------------------------------
%---                    Figure                                      ---%
%-----------------------------------------------------------------------
TextSize = 20;
averagesDs = zeros(length(sequence),2);
bound = repelem(2*maxR,length(sequence))./(sequence);
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

if ToSave == 1
    saveas(gcf,'..\..\images\Sensitivity_SPDM.png') 
end







