function [exp_y_delta] = exp_map_Sphere(Y,v,r)
%- Carlos J. Soto cjs7363@psu.edu

%- This function finds point in S^d starting at Y and going in 
% the direction of v.

%- Input:
%- Y             			- an 1xd point on a sphere S^d
%- v                		- an 1xd Shooting vector
%- r 						- Radius of the manifold sphere

%- Output:
%- exp_y_delta      		- The point on M reached by moving Y in the direction of v

if nargin == 2
    r = 1;
end


vnorm = norm(v);
exp_y_delta = cos(vnorm)*Y + r*sin(vnorm)*v/vnorm;




end

