function [x,y,z] = spherical_to_cart_vectors(theta,phi,r)
%- Carlos J. Soto cjs7363@psu.edu

%- This function converts vectors of theta, phi, r into cartesian coordinates.

%- Input:
%- theta, phi, r        - vectors of polar coordinates

%- Output:
%- x,y,z                - corresponding converted cartesian coordinates

if nargin == 2
    r = 1;
end

x = r.*sin(theta).*sin(phi);
y = r.*sin(theta).*cos(phi);
z = r.*cos(theta);

end