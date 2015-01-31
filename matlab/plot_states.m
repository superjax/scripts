% plot_states.m

figure(1); clf
% Plot xyz
labels = {'forward','right','down'};
new_node_mask = diff(data.estimator.ekf.state.node_id) == 1;
for i = 1:3
 
 subplot(3,1,i)
 plot(data.truth.relative.state.time, data.truth.relative.state.transform.translation(i,:),'g.'); hold on; 
 plot(data.estimator.ekf.state.time, data.estimator.ekf.state.transform.translation(i,:),'b.');
 plot(data.estimator.ekf.state.time(new_node_mask), data.estimator.ekf.state.transform.translation(i,new_node_mask),'ro');
 
 % Plot Covariance
 data.estimator.ekf.snapshot.truth.covariance(i,:) = interp1(data.estimator.ekf.snapshot.time,data.estimator.ekf.snapshot.covariance(i,:),data.truth.relative.state.time);
 plot(data.truth.relative.state.time, data.truth.relative.state.transform.translation(i,:) + sqrt(data.estimator.ekf.snapshot.truth.covariance(i,:)),'k');
 plot(data.truth.relative.state.time, data.truth.relative.state.transform.translation(i,:) - sqrt(data.estimator.ekf.snapshot.truth.covariance(i,:)),'k');
 
 %legend('Truth','Estimates')
 ylabel(strcat(labels{i},' (m)'));
 xlabel('time (sec)');
end
suptitle('Position')
plot(data.sensors.alt_msgs.time, data.sensors.alt_msgs.range,'co');

figure(2); clf
% Plot euler
labels = {'roll','pitch','yaw'};
for i = 1:3
 subplot(3,1,i)
 plot(data.truth.relative.state.time, data.truth.relative.state.transform.euler(i,:)-data.truth.relative.state.transform.euler(i,1),'g.'); hold on; 
 plot(data.estimator.ekf.state.time, data.estimator.ekf.state.transform.euler(i,:),'b.');
 plot(data.estimator.ekf.state.time(new_node_mask), data.estimator.ekf.state.transform.euler(i,new_node_mask),'ro');
 ylabel(strcat(labels{i},' (deg)'));
 xlabel('time (sec)');
 %legend('Truth','Estimates')
end
suptitle('Euler')

figure(3); clf
% Plot uvw
labels = {'u','v','w'};
for i = 1:3
 subplot(3,1,i)
 plot(data.truth.relative.state.time, data.truth.relative.state.velocity(i,:),'g.'); hold on; 
 plot(data.estimator.ekf.state.time, data.estimator.ekf.state.velocity(i,:),'b.');
 plot(data.estimator.ekf.state.time(new_node_mask), data.estimator.ekf.state.velocity(i,new_node_mask),'ro');
 
 % Plot Covariance
 data.estimator.ekf.snapshot.truth.covariance(7+i,:) = interp1(data.estimator.ekf.snapshot.time,data.estimator.ekf.snapshot.covariance(7+i,:),data.truth.relative.state.time);
 plot(data.truth.relative.state.time, data.truth.relative.state.velocity(i,:) + sqrt(data.estimator.ekf.snapshot.truth.covariance(7+i,:)),'k');
 plot(data.truth.relative.state.time, data.truth.relative.state.velocity(i,:) - sqrt(data.estimator.ekf.snapshot.truth.covariance(7+i,:)),'k'); 
 
 ylabel(strcat(labels{i},' (deg)'));
 xlabel('time (sec)');
 %legend('Truth','Estimates')
end
suptitle('Velocity')

figure(4); clf
% Plot Beta
labels = {'Bx','By','Bz'};
for i = 1:3
 subplot(3,1,i)
 plot(data.estimator.ekf.snapshot.time, data.estimator.ekf.snapshot.state(10+i,:),'b.');
 ylabel(strcat(labels{i},''));
 xlabel('time (sec)');
end
suptitle('Gyro Biases')


figure(5); clf
% Plot Beta
labels = {'Ax','Ay','mu'};
for i = 1:3
 subplot(3,1,i)
 plot(data.estimator.ekf.snapshot.time, data.estimator.ekf.snapshot.state(13+i,:),'b.');
 ylabel(strcat(labels{i},''));
 xlabel('time (sec)');
end
suptitle('Accel Biases')

figure(6); clf
% Plot Residuals
%labels = {'Ax','Ay','mu'};
 plot(data.estimator.ekf.y.time, data.estimator.ekf.y.transform.translation(3,:),'r.'); hold on
 plot(data.estimator.ekf.hx.time, data.estimator.ekf.hx.transform.translation(3,:),'b.');
 %ylabel(strcat(labels{i},''));
 xlabel('time (sec)');
suptitle('Residual')