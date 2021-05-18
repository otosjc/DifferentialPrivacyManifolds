function Y = Laplace_Vector(Ybar,sigma)
%- Carlos J. Soto cjs7363@psu.edu

%- This function generates a random sample from the Euclidean Laplace.

%- Input:
%- Ybar             - an nxn footprint of the Laplace
%- sigma            - an R^1 value sd of the Laplace  

%- Output:
%- Y                - An nxn random sample from Laplace symmetric



n = size(Ybar,2);


%- Sample from Unit sphere
U = normrnd(0,1,[1,n]);
U = U/norm(U);

%- Sample from Gamma
R = gamrnd(n,1);

%- The random Laplace
Y = Ybar + R * sigma * U;




 
 

end
