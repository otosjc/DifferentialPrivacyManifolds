%- Carlos J. Soto cjs7363@psu.edu
%- test the dist on SPDM

clear; path(pathdef); close all
addpath('../functions/')

X = wishrnd([2,3;3,8],2);
Y = wishrnd([2,3;3,8],2);

dist_SPDM(X,Y)
dist_SPDM(Y,X)


%- test the dist with the invariant action
A = wishrnd([2,3;3,8],2);
dist_SPDM(X,Y)
dist_SPDM(action_SPDM(X,A),action_SPDM(Y,A))


% % Ybar = eye(3);
% % sigma = 0.2;
% % X0 = rand(1,3);
% % Y = Laplace_SPDM(Ybar, sigma, X0);
% % 
% % %- check if Y is SPDM
% % if all(eig(Y) > 0) && isequal(Y,Y')
% %     disp('Y is SPDM')
% % else
% %     disp('Y is not SPDM')
% % end
% % 
% % % wishrnd([2,3;3,8],2)