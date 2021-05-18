function [exp_y_delta] = exp_map_SPDM(Y,Delta)
%- Created by Carlos J. Soto cjs7363@psu.edu

%- This function finds point in SPDM starting at Y and going in 
% the direction of Delta.

%- Input:
%- Y             				- an nxn SPDM
%- Delta             			- an nxn shooting matrix in T_Y(M)

%- Output:
%- exp_y_delta             		- The point in SPDM starting at Y and going in Delta direction


exp_y_delta = Y^(1/2) * expm(Y^(-1/2) * Delta * Y^(-1/2)) * Y^(1/2);



end

