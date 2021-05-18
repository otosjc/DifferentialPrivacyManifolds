function [X,r_m] = Create_sim_data_Sphere(n,r_m,r,dim)
%- Created by Carlos J. Soto cjs7363@psu.edu


% This script is to generate data on the sphere. This is done 
% by uniformly sampling on the angles. This has only 
% been tested for 2 sphere and 1 sphere.

%- Input:
%- n                    - Sample size of the data to create
%- r_m 					- radius of the ball on the sphere 
%- r                    - radius of the sphere
%- dim 					- the dimension of the sphere S^dim

%- Output: 
%- X                    - The random data size nxdim
%- r_m 					- radius of the ball on the sphere 


if nargin == 1   
	r_m = pi/(8);     
    r = 1;
    dim = 3;
end
%radius of the ball on the manifold
theta = r_m*rand([n,1]);
phi = 2*pi*rand([n,1]);
[x,y,z] = spherical_to_cart_vectors(theta,phi);

X = [x,y,z];

end

