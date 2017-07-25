function [ GT, GP, GT_noise ] = compound_edges( X , P , nIters, x0, p0 )
%COMPOUND_EDGES Express set of relative edges w.rt. global frame
%   Detailed explanation goes here

loc0 = x0(1:3);
att0 = x0(4:6);
X = [loc0 0 0 0; 0 0 0 att0;X];
P = [zeros(1,6);p0;P];

nTrans = size(P,1);

% Set truth (no noise added
GT = cell(1,nTrans); % Global transform of step {k}
GP = cell(1,nTrans); % Global covariance of step {k}
GT{1} = vec2tran( X(1,:)' );
GP{1} = diag(P(1,:));
for k = 2:nTrans
    %T_truth{k} = vec2tran(X(k,:)') * T_truth{k-1};
    [GT{k},GP{k}] = compound(vec2tran(X(k,:)'),diag(P(k,:)),GT{k-1},GP{k-1},2);
end

% Set iterations (noise added)
GT_noise = cell(nIters,nTrans); % Global transform of step {k}, iterations {i}
for i = 1 : nIters
    GT_noise{i,1} = vec2tran( X(1,:)' );
    for k = 2:nTrans
        GT_noise{i,k} = vec2tran(mvnrnd(X(k,:),diag(P(k,:)))') * GT_noise{i,k-1};
    end
end
end

