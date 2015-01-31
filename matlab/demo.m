topics = {  '/estimator/ekf/state' 
            '/tf' 
            '/truth/relative/state' 
            '/estimator/ekf/y' 
            '/estimator/ekf/hx' 
            '/desired_state' 
            '/estimator/ekf/snapshot'
            '/rviz_goal'
            '/sensors/alt_msgs'};
      
bagfile = '~/rosbag/worked_on_estimates_1.bag';
bagfile = '~/rosbag/vo_cmu_worked.bag';


[data,t0] = processTopics(topics.',bagfile);
data2 = processTopics({'/sensors/alt_msgs'},'~/rosbag/poor_control_on_truth.bag');

new_node_mask = diff(data.estimator.ekf.state.node_id) == 1;
figure(1); clf
% Plot xyz
labels = {'forward','right','down'};
for i = 1:3
 subplot(3,1,i)
 plot(data.truth.relative.state.time, data.truth.relative.state.transform.translation(i,:),'g.'); hold on; 
 plot(data.estimator.ekf.state.time, data.estimator.ekf.state.transform.translation(i,:),'b.');
 plot(data.estimator.ekf.state.time(new_node_mask), data.estimator.ekf.state.transform.translation(i,new_node_mask),'ro');
 ylabel(strcat(labels{i},' (m)'));
 xlabel('time (sec)');
 %legend('Truth','Estimates')
end

% new_node_mask2 = diff(data.desired_state.node_id) == 1;
% figure(2); clf
% % Plot xyz
% labels = {'forward','right','down'};
% 
% t = [data.desired_state.time(new_node_mask2).' data.desired_state.time(new_node_mask2).'];
% t = reshape(t.',prod(size(t)),1);
% 
% for i = 1:3
%  subplot(3,1,i)
%  y = [data.desired_state.pose(i,new_node_mask2).' data.desired_state.pose(i,new_node_mask2).'];
%  y = reshape(y.',prod(size(y)),1);
%  plot(data.desired_state.time, data.desired_state.pose(i,:),'k-'); hold on;
%  plot(data.desired_state.time(new_node_mask2), data.desired_state.pose(i,new_node_mask2),'ro'); hold on;
%  plot([t;t(end)], [0;y],'b'); hold on;
%  ylabel(strcat(labels{i},' (m)'));
%  xlabel('time (sec)');
%  %legend('Truth','Estimates')
% end

% figure(3); clf
% % Plot xyz
% labels = {'forward','right','down'};
% for i = 1:3
%  subplot(3,1,i)
%  y = [data.desired_state.pose(i,new_node_mask2).' data.desired_state.pose(i,new_node_mask2).'];
%  y = reshape(y.',prod(size(y)),1);
%  plot(data.truth.relative.state.time, data.truth.relative.state.transform.translation(i,:),'g.'); hold on; 
%  plot(data.estimator.ekf.state.time, data.estimator.ekf.state.transform.translation(i,:),'b.');
%  plot(data.estimator.ekf.state.time(new_node_mask), data.estimator.ekf.state.transform.translation(i,new_node_mask),'ro');
%  plot([t;t(end)], [0;y],'b'); hold on;
%  plot([data.rviz_goal.time;data.rviz_goal.time],[ones(size(data.rviz_goal.time));-ones(size(data.rviz_goal.time))],'k'); hold on;
%  ylabel(strcat(labels{i},' (m)'));
%  xlabel('time (sec)');
%  %legend('Truth','Estimates')
% end

% Plot RPY
figure(4); clf
labels = {'roll','pitch','yaw'};
for i = 1:3
 subplot(3,1,i)
 %data.truth.relative.state.transform.euler(i,:) = data.truth.relative.state.transform.euler(i,:) - data.truth.relative.state.transform.euler(i,1);
 plot(data.truth.relative.state.time, data.truth.relative.state.transform.euler(i,:),'g.'); hold on;
 plot(data.estimator.ekf.state.time, data.estimator.ekf.state.transform.euler(i,:),'b.');
 ylabel(strcat(labels{i},' (deg)'));
 xlabel('time (sec)');
 %legend('Truth','Estimates')
end

% Plot RPY
figure(5); clf
labels = {'yaw'};
i = 3;
plot(data.truth.relative.state.time, data.truth.relative.state.transform.euler(i,:),'g.'); hold on;
plot(data.estimator.ekf.state.time, data.estimator.ekf.state.transform.euler(i,:),'b.'); hold on;
%plot([data.rviz_goal.time;data.rviz_goal.time],[30*ones(size(data.rviz_goal.time));-30*ones(size(data.rviz_goal.time))],'k'); hold on;
ylabel(strcat(labels{1},' (deg)'));
xlabel('time (sec)');

figure(6); clf
% Plot uvw
labels = {'u','v','w'};
for i = 1:3
 subplot(3,1,i)
 plot(data.truth.relative.state.time, data.truth.relative.state.velocity(i,:),'g.'); hold on; 
 plot(data.estimator.ekf.state.time, data.estimator.ekf.state.velocity(i,:),'b.');
 ylabel(strcat(labels{i},' (m)'));
 xlabel('time (sec)');
 %legend('Truth','Estimates')
end


figure(7); clf
% Plot altimeter
 plot(data.truth.relative.state.time, -data.truth.relative.state.transform.translation(3,:)+0.04,'g.'); hold on; 
 plot(data.estimator.ekf.state.time, -data.estimator.ekf.state.transform.translation(3,:),'b.'); hold on;
 plot(data2.sensors.alt_msgs.time+28.1 , data2.sensors.alt_msgs.range,'r.'); hold on;
 ylabel('Z (m)');
 xlabel('time (sec)');
 %legend('Truth','Estimates')
