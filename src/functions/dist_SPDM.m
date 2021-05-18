function [d] = dist_SPDM(Y,Z)
%- Created by Carlos J. Soto cjs7363@psu.edu

%- This function computes the manifold distance between
%- two SPDM matrices

%- Input:
%- Y             		- an nxn SPDM
%- Z             		- an nxn SPDM

%- Output:
%- d 					- The distance between Y,Z

d = trace(logm(Y^(-1/2) * Z * Y^(-1/2))^2);
d = sqrt(d);

end

