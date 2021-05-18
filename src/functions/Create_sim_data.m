function [X,maxR] = Create_sim_data(n,V,df,r)
%- Created by Carlos J. Soto cjs7363@psu.edu

% This script is to generate simulated data using the Wishart distribution.
% We need SPDM matrices and while this could be done in any manner, if they
% come from the Wishart we know some information of their nature rather
% than completely random.

%- Input:
%- n                    - Sample size of the data to create
%- V                    - An dim x dim SPDM matrix to put into the Wishart
%- df                   - df for the Wishart 
%- r                    - radius of the ball in the manifold

%- Output: 
%- X 					- cell of simulated data 
%- maxR					- Exact radius 

X = cell(1,n);
% Default parameters
if nargin == 1        
    V = [0.5,0;   0,0.5];
    df = 2;
    r = 1.5;
end
distrMean = V*df;
%- create random sample
maxR = 0;
for i = 1:n
    tmp = wishrnd(V,df);
    d = dist_SPDM(distrMean,tmp);
    while d > r
        tmp = wishrnd(V,df);
        d = dist_SPDM(distrMean,tmp);
    end
    maxR = max(maxR,d);
    X{i} = tmp;
end

end

