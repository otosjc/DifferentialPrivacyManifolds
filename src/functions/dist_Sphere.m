function [theta] = dist_Sphere(Y,Z)
%- Created by Carlos J. Soto cjs7363@psu.edu

%- This function computes the manifold distance between
%- two points on a sphere.

%- Input:
%- Y             		- an 1xd point on a sphere S^d
%- Z             		- an 1xd point on a sphere S^d
% note these can be dx1 but both must have same format

%- Output:
%- theta 				- The distance between Y,Z

theta   = acos(sum(Y.*Z));


end

