function [normDY] = norm_T_SPDM(Y,dY)
%- Carlos J. Soto cjs7363@psu.edu

%- Input:
%- Y                    - The point at which to do inner product
%- dy                   - The tangent vector

%- Output:
%- normDY               - |dY|_Y

normDY = trace(Y^(-1)* dY *Y^(-1)* dY);
normDY = sqrt(normDY);


end

