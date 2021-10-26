function [rsamp] = Laplace_sphere_MCMC2(sigma,k,burnin)
% Sampling from laplace on the sphere

%- Input:
%- r_m              - ball radius for proposals
%- sigma            - rate parameter for the Laplace
%- k                - how many sample we want
%- burnin           - burn in period, default to 50000

%- Output:

if nargin == 2
    burnin = 10000;
end
EveryN = 200;
% initialize data
rsamp = zeros(k*EveryN,3);
eta = [0; 0; 1];

% Need an initial p so just start at north pole
p = eta;
for ii = 1:burnin
    dlength = sigma * rand;
    theta = 2*pi*rand;
    phi = pi*rand;
    [x,y,z] = spherical_to_cart(theta,phi,dlength);
    v = [x; y; z];
    v = v+p;
%     size(v)
    vtilde = (eye(3)-p*p')*v;
%     size(vtilde)
%     size(p)
%     vtilde'*p;  %For debugging should always be zero
    
    proposalpoint = exp_map_Sphere(p',vtilde');
    proposalpoint = proposalpoint';
    d1 = dist_Sphere(eta,p);
    d2 = dist_Sphere(eta,proposalpoint);
    % acceptance probability
    AccProb = exp(-d2/sigma)/exp(-d1/sigma);
    AccProb = min(1,AccProb);
    % accept or reject
    if binornd(1,AccProb)
        p = proposalpoint;     
    end
end


exitCond = -1;
counter = 1;
rsamp(1,:) = p';
if k == 1
    exitCond = 100;
end
while exitCond < 0  
    p = rsamp(counter,:);
    p = p';
    dlength = sigma * rand;
    theta = 2*pi*rand;
    phi = pi*rand;
    [x,y,z] = spherical_to_cart(theta,phi,dlength);
    v = [x; y; z];
    v = v + p;
    vtilde = (eye(3)-p*p')*v;
    
    
    
    proposalpoint = exp_map_Sphere(rsamp(counter,:),vtilde');
    proposalpoint = proposalpoint';
    d1 = dist_Sphere(eta,rsamp(counter,:));
    d2 = dist_Sphere(eta,proposalpoint);
    % acceptance probability
    AccProb = exp(-d2/sigma)/exp(-d1/sigma);
    AccProb = min(1,AccProb);
    % accept or reject
    if binornd(1,AccProb)
        counter = counter + 1;
        rsamp(counter,:) = proposalpoint';
        if counter == k*EveryN
            exitCond = 100;
        end
    end  
    
end

Indx = [1:EveryN:k*EveryN];
rsamp = rsamp(Indx,:);


end

