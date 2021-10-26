function [EmpUpperBound,upperboundK] = empirical_2r(r_m)



kappa = 1;

if nargin == 0
    r_m = pi/4; 
end
n = 10000;
theta = r_m*ones([n,1]);
phi = [0:(2*pi)/(n-1):2*pi]';
[x,y,z] = spherical_to_cart_vectors(theta,phi);

X = [x,y,z];
Footpoint = X(1,:);
d1 = zeros(n-1,n-1);
d2 = zeros(n-1,n-1);
for i = 2:n
    X1 = X(i,:);
    for j = 2:n
        X2 = X(j,:);
        V1 = inv_exp_map_Sphere(Footpoint,X1);
        V2 = inv_exp_map_Sphere(Footpoint,X2);
        d2(i,j) = norm(V1-V2);   
     end
end
hrk = 2*r_m * sqrt(kappa) * cot(sqrt(kappa)*2*r_m);
upperboundK = 2*r_m*(2-hrk);
EmpUpperBound = max(max(d2));

end


