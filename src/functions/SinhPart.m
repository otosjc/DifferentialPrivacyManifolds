function [sinhProd] = SinhPart(X)
%- Created by Carlos J. Soto cjs7363@psu.edu

%- This function generates the product sinh part of the Laplace 
% density on SPDM see the overarching function Laplace_SPDM for its usage. 

%- Input:
%- X 

%- Output:
%- singProd                     - prod_i<j sinh ((x_i-x_j)/2)

m = length(X);

sinhProd = 1;
for i = 1:m-1
    for j = i:m-1
        sinhProd = sinhProd * sinh(abs(X(i)-X(j+1))/2);
%         [i,j+1]
    end
end


end

