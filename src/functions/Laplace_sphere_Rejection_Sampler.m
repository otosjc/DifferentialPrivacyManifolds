function [Y] = Laplace_sphere_Rejection_Sampler(meanX,sigma)
%- Created by Carlos J. Soto cjs7363@psu.edu

%- This function generates a random sample from the Laplace on
% the sphere.

%- Input:
%- meanX             	- an 1xd footprint of the Laplace
%- sigma            	- an R^1 value sd of the Laplace 

%- Output:
%- Y                	- An 1xd random sample from Laplace 

if nargin == 2
    sigma = .1;
end


exitcond = -1;
while exitcond < 0
    X = normrnd(0,1,size(meanX));
    X = X/norm(X);
    dists = dist_Sphere(meanX,X);
    expo = -1 *  dists/sigma ;
    Xweight = exp(expo);
    if binornd(1,Xweight) == 1
        exitcond = 1;
    end
end

Y = X;    
    
end

