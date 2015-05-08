%% Simulated Data
%addpath('barfoot_tro14')
clear all;

nIters = 100;
nNodes = 100;
 
x0 = [10 100 0 0 0 pi/2];
p0 = [0 0 0 0 0 0];
X = repmat([1 0.1 0 0 0 0.01],nNodes,1);
P = repmat([ 0 0 0 0 0 0.0009 ],nNodes,1);
[GT,GP,GT_noise] = compound_edges(X,P,nIters,x0,p0);
figure(1); clf; axis('equal');
axis([-65   100   -10  105]);
[handles,labels] = plot_compounded_edges(GT,GP,GT_noise);
legend(handles,labels);

%% Centennial Middle School Data
clear all;
nIters = 20;
% Import data from rosbag
[Xa,Pa] = import_pose_graph('~/rosbag/CENTENNIAL.bag');

% Alter data
jumps = find(diag(Xa(:,1:2)*Xa(:,1:2).') > 1.5);
Xa(jumps,1:2) = repmat([0 0],length(jumps),1);
Pa(jumps,1:2) = 500*Pa(jumps,1:2);
%P(50:60,6) = 500*P(50:60,6);

% Set location/attitude of initial node
x0 = [0 0 0 0 0 95*pi/180];
p0 = [0 0 0 0 0 0];
[GT,GP,GT_noise] = compound_edges(Xa,Pa,nIters,x0,p0);
axis([-10  170  -20   100])

% Plot results
figure(3); clf;
axis([-10  170  -20   100])
plot_centennial_truth
[handles,labels] = plot_compounded_edges(GT,GP,GT_noise)
labels{4} = 'Truth';
legend([handles h_gps],labels,'Location','SouthEast');

%% Centennial Middle School Data with Artifical Yaw Uncertainty
% Alter data
Xb = Xa;
Pb = Pa;
Pb(125:150,6) = 500*Pa(125:150,6); % Add yaw issue

% Set location/attitude of initial node
x0 = [0 0 0 0 0 95*pi/180];
p0 = [0 0 0 0 0 0];
[GT,GP,GT_noise] = compound_edges(Xb,Pb,nIters,x0,p0);
axis([-10  170  -20   100])

% Plot results
figure(4); clf;
axis([-10  170  -20   100])
plot_centennial_truth
plot_compounded_edges(GT,GP,GT_noise)


%% WSC Data
clear all;
nIters = 20;
% Import data from rosbag
[Xa,Pa,Na] = import_pose_graph('~/rosbag/03_WSC_2015_02_24.bag');

% Alter data
jumps = find(abs(Xa(:,2)) > 0.4);
Xa(jumps,1:2) = repmat([0 0],length(jumps),1);
Pa(jumps,1:2) = 500*Pa(jumps,1:2);

% Set location/attitude of initial node
x0 = [0 0 0 0 0 -90*pi/180];
p0 = [0 0 0 0 0 0];
[GT,GP,GT_noise] = compound_edges(Xa,Pa,nIters,x0,p0);
%axis([-10  170  -20   100])

% Plot results
figure(3); clf;
axis([  -19.4128   44.3546  -17.3552   22.5441])
%plot_centennial_truth
[handles,labels] = plot_compounded_edges(GT,GP,GT_noise)
labels{4} = 'Truth';
legend([handles h_gps],labels,'Location','SouthEast');