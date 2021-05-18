function [YdotA] = action_SPDM(Y,A)
%- Created by Carlos J. Soto cjs7363@psu.edu
%
%- Input:
%- Y             		- an nxn SPDM
%- A 					- an nxn symmetric matrix

%- Output: 				
%- YdotA 				- The group action of A on Y, A'YA. 

YdotA =  A' * Y * A;

end

