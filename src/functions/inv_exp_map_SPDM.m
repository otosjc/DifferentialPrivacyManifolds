function [inv_exp_y_delta] = inv_exp_map_SPDM(Y,Z)
%- Created by Carlos J. Soto cjs7363@psu.edu

%- This function finds the shooting vector (matrix) from Y to Z
% in SPDM.

%- Input:
%- Y             				- an nxn SPDM
%- Z             				- an nxn SPDM

%- Output:
%- inv_exp_y_delta            	- an nxn shooting matrix from Y to Z


inv_exp_y_delta = Y^(1/2) * logm(Y^(-1/2) * Z * Y^(-1/2)) * Y^(1/2);


end

