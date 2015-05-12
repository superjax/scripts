function [ X , P ] = import_pose_graph( bagfile )
%IMPORT_POSE_GRAPH Import the edges and covariances from a ROS bag
%   Detailed explanation goes here

data = processTopics({'/estimator/ekf/edge'},bagfile);

%%
n = size(data.estimator.ekf.edge.time,2);
X = zeros(n,6);
P = zeros(n,6);

% Define Edge Transformation (T) and Edge Covariance (P)
for i = 1:n
    % Define transforms T_i and Covariance P_i
    [roll,pitch,yaw] = rollPitchYawFromQuaternion(data.estimator.ekf.edge.transform.rotation(:,i));
    X(i,:) = [data.estimator.ekf.edge.transform.translation(:,i)' roll pitch -yaw];
    P(i,:) = diag(reshape(data.estimator.ekf.edge.covariance(:,i),6,6));     
    
    % Zero out z, roll, and pitch
    P(i,3:5) = [0 0 0];
end


end

