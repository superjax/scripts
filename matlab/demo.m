topics = {  '/estimator/ekf/state' 
            '/tf' 
            '/current_state' 
            '/estimator/ekf/y' 
            '/estimator/ekf/hx' 
            '/desired_state' 
            '/estimator/ekf/snapshot',
            '/rviz_goal'};
      
bagfile = '~/rosbag/worked_on_estimates_1.bag';

data = processTopics(topics.',bagfile);


new_node_mask = diff(data.estimator.ekf.state.node_id) == 1;
figure(1); clf
% Plot xyz
labels = {'forward','right','down'};
for i = 1:3
 subplot(3,1,i)
 plot(data.current_state.time, data.current_state.transform.translation(i,:),'g.'); hold on; 
 plot(data.estimator.ekf.state.time, data.estimator.ekf.state.transform.translation(i,:),'b.');
 plot(data.estimator.ekf.state.time(new_node_mask), data.estimator.ekf.state.transform.translation(i,new_node_mask),'ro');
 ylabel(strcat(labels{i},' (m)'));
 xlabel('time (sec)');
 %legend('Truth','Estimates')
end

new_node_mask2 = diff(data.desired_state.node_id) == 1;
figure(2); clf
% Plot xyz
labels = {'forward','right','down'};

t = [data.desired_state.time(new_node_mask2).' data.desired_state.time(new_node_mask2).'];
t = reshape(t.',prod(size(t)),1);

for i = 1:3
 subplot(3,1,i)
 y = [data.desired_state.pose(i,new_node_mask2).' data.desired_state.pose(i,new_node_mask2).'];
 y = reshape(y.',prod(size(y)),1);
 plot(data.desired_state.time, data.desired_state.pose(i,:),'k-'); hold on;
 plot(data.desired_state.time(new_node_mask2), data.desired_state.pose(i,new_node_mask2),'ro'); hold on;
 plot([t;t(end)], [0;y],'b'); hold on;
 ylabel(strcat(labels{i},' (m)'));
 xlabel('time (sec)');
 %legend('Truth','Estimates')
end

figure(3); clf
% Plot xyz
labels = {'forward','right','down'};
for i = 1:3
 subplot(3,1,i)
 y = [data.desired_state.pose(i,new_node_mask2).' data.desired_state.pose(i,new_node_mask2).'];
 y = reshape(y.',prod(size(y)),1);
 plot(data.current_state.time, data.current_state.transform.translation(i,:),'g.'); hold on; 
 plot(data.estimator.ekf.state.time, data.estimator.ekf.state.transform.translation(i,:),'b.');
 plot(data.estimator.ekf.state.time(new_node_mask), data.estimator.ekf.state.transform.translation(i,new_node_mask),'ro');
 plot([t;t(end)], [0;y],'b'); hold on;
 plot([data.rviz_goal.time;data.rviz_goal.time],[ones(size(data.rviz_goal.time));-ones(size(data.rviz_goal.time))],'k'); hold on;
 ylabel(strcat(labels{i},' (m)'));
 xlabel('time (sec)');
 %legend('Truth','Estimates')
end

% Plot RPY
figure(4); clf
labels = {'roll','pitch','yaw'};
for i = 1:3
 subplot(3,1,i)
 %data.truth.relative.state.transform.euler(i,:) = data.truth.relative.state.transform.euler(i,:) - data.truth.relative.state.transform.euler(i,1);
 plot(data.current_state.time, data.current_state.transform.euler(i,:),'g.'); hold on;
 plot(data.estimator.ekf.state.time, data.estimator.ekf.state.transform.euler(i,:),'b.');
 ylabel(strcat(labels{i},' (deg)'));
 xlabel('time (sec)');
 %legend('Truth','Estimates')
end

% Plot RPY
figure(5); clf
labels = {'yaw'};
i = 3;
plot(data.current_state.time, data.current_state.transform.euler(i,:),'g.'); hold on;
plot(data.estimator.ekf.state.time, data.estimator.ekf.state.transform.euler(i,:),'b.'); hold on;
plot([data.rviz_goal.time;data.rviz_goal.time],[30*ones(size(data.rviz_goal.time));-30*ones(size(data.rviz_goal.time))],'k'); hold on;
ylabel(strcat(labels{i},' (deg)'));
xlabel('time (sec)');