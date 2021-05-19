function [normDY] = norm_T_SPDM(Y,dY)
%- Carlos J. Soto cjs7363@psu.edu

%- Input:
%- Y                    - an nxn footprint of the Laplace
%- epsilon              - precision

%- Output:
normDY = trace(Y^(-1)* dY *Y^(-1)* dY);
normDY = sqrt(normDY);


end

