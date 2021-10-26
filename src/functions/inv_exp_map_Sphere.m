function [inv_exp_y_delta] = inv_exp_map_Sphere(Y,Z)
%- Created by Carlos J. Soto cjs7363@psu.edu

%- This function finds the shooting vector from Y to Z
% in S^d.

%- Input:
%- Y             			- an 1xd point on a sphere S^d
%- Z             			- an 1xd point on a sphere S^d

%- Output:
%- inv_exp_y_delta          - an 1xd shooting vector from Y to Z


%- Need this first condition because can't divide by zero in calculation
if isequal(Y,Z)
    inv_exp_y_delta = zeros(size(Y,1));
else
    theta   = acos(sum(Y.*Z));
    inv_exp_y_delta = theta/(sin(theta)) * (Z-(cos(theta)*Y));
end





end

