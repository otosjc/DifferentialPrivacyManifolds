function [muhat,norms] = frechet_mean_SPDM(Y,epsilon,stepSize)
%- Created by Carlos J. Soto cjs7363@psu.edu

% This function does a gradient descent method to compute the
% mean of SPDM matrices. 

%- Input:
%- Y                    		- cell of matrices 
%- epsilon              		- precision
%- stepSize 					- step size for each gradient step

%- Output:
%- muhat 						- the frechet mean 
%- norms 						- the norm of the average moving direction at each step 
% (norms should go to zero as iterations increase)


%- tuning parameters
if nargin == 1
    stepSize = 0.5;                 %- can solve for this using a backtracking procedure
    epsilon = 0.00001;
end
Niter = 500;                        %- minimum number of iterations


muhat = Y{1};                       %- initialize the mean
n = size(Y,2);                      %- sample size
dimN = size(Y{1},1);                %- dimension of P(dimN)
normd = 100000;
v = zeros(dimN,dimN,n);
iter = 1;
while (normd > epsilon && iter < Niter)
    
    for i = 1:n
        v(:,:,i) = inv_exp_map_SPDM(muhat,Y{i});
    end
    Delta = 1/(n) * sum(v,3);
    Delta = squeeze(Delta);
    normd = norm_T_SPDM(muhat,Delta);
%     normd = norm_T_SPDM([1 0; 0 1],Delta);
    norms(iter) = normd;
    if normd > epsilon        
        muhat = exp_map_SPDM(muhat, stepSize*Delta);
    end
    iter = iter + 1;
    
end



end

