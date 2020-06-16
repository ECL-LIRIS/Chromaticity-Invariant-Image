function [W,H] = nmfsc( V, rdim, sW, sH)
% nmfsc - non-negative matrix factorization with sparseness constraints
%
% SYNTAX:
% [W,H] = nmfsc( V, rdim, sW, sH);
%
% INPUTS:
% V          - data matrix
% rdim       - number of components (inner dimension of factorization)
% sW         - sparseness of W, in [0,1]. (give [] if no constraint)
% sH         - sparseness of H, in [0,1]. (give [] if no constraint)
%

% Check that we have non-negative data
if min(V(:))<0, error('Negative values in data!'); end

% Globally rescale data to avoid potential overflow/underflow
V = V./255;

% Data dimensions
vdim = size(V,1);
samples = size(V,2);

% Create initial matrices
W = abs(randn(vdim,rdim));
H = abs(randn(rdim,samples));
H = H./(sqrt(sum(H.^2,2))*ones(1,samples));

% Make initial matrices have correct sparseness
if ~isempty(sW),
    L1a = sqrt(vdim)-(sqrt(vdim)-1)*sW;
    for i=1:rdim, W(:,i) = projfunc(W(:,i),L1a,1,1); end
end
if ~isempty(sH),
    L1s = sqrt(samples)-(sqrt(samples)-1)*sH;
    L1h = sqrt(samples)-(sqrt(samples)-1)*0.1;
    H(1,:) = (projfunc(H(1,:)',L1h,1,1))';
    H(2,:) = (projfunc(H(2,:)',L1s,1,1))';
end

% Calculate initial objective
objhistory = 0.5*sum(sum((V-W*H).^2));

% Initial stepsizes
stepsizeH = 1;

% Start iteration
iter = 0;
while 1,
    
    % Update iteration count
    iter = iter+1;
    
    % ----- Update H ---------------------------------------
    
    % Gradient for H
    dH = W'*(W*H-V);
    begobj = objhistory(end);
    
    % Make sure we decrease the objective!
    while stepsizeH >= 1e-200,
        
        % Take step in direction of negative gradient, and project
        Hnew = H - stepsizeH*dH;
        Hnew(1,:) = (projfunc(Hnew(1,:)',L1h,1,1))';
        Hnew(2,:) = (projfunc(Hnew(2,:)',L1s,1,1))';
        
        % Calculate new objective
        newobj = 0.5*sum(sum((V-W*Hnew).^2));
        
        % If the objective decreased, we can continue...
        if newobj<=begobj,
            break;
        end
        
        % ...else decrease stepsize and try again
        stepsizeH = stepsizeH/2;
        
    end
    
    % Slightly increase the stepsize
    stepsizeH = stepsizeH*1.2;
    H = Hnew;
    
    % ----- Update W ---------------------------------------
    
    % Update using standard NMF multiplicative update rule
    W = W.*(V*H')./(W*H*H' + 1e-9);
    
    % Calculate objective
    newobj = 0.5*sum(sum((V-W*H).^2));
    
    if abs(newobj-objhistory(end)) < 0.000001 || stepsizeH < 1e-200 || iter > 2000
        fprintf('Algorithm converged.\n');
        return;
    end
    
    objhistory = [objhistory newobj];
    
    
end
