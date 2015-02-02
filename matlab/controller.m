%controller.m

topics = {  '/commands' 
            '/current_state' 
            '/desired_state' 
            '/evart/shredder/CG' 
            '/mavlink/to'};
      
bagfile = '~/rosbag/test_control5.bag';

data = processTopics(topics.',bagfile);


figure(1); clf
% Plot xyz
labels = {'forward','right','down'};
t = [data.desired_state.time.' data.desired_state.time.'];
t = reshape(t.',prod(size(t)),1);
for i = 1:3 
 subplot(3,1,i)
 y = [data.desired_state.pose(i,:).' data.desired_state.pose(i,:).'];
 y = reshape(y.',prod(size(y)),1);
 plot(data.current_state.time, data.current_state.transform.translation(i,:),'g.'); hold on;  
 plot([t;t(end)], [0;y],'b'); hold on;
 ylabel(strcat(labels{i},' (m)'));
 xlabel('time (sec)');
end
suptitle('Position')

figure(2); clf
plot(data.current_state.time, data.current_state.node_id)
suptitle('Node id')

figure(3); clf
% Plot commands
labels = {'roll','pitch','yawrate'};
for i = 1:3 
 subplot(3,1,i)
 plot(data.commands.time, 180/pi*data.commands.commands(i,:),'g.'); hold on;  
 plot(data.current_state.time, data.current_state.transform.euler(i,:),'r.'); hold on;  
 ylabel(strcat(labels{i},' (deg)'));
 xlabel('time (sec)');
 legend('commands','euler')
end
suptitle('Commands')

figure(4); clf
% Plot Euler
labels = {'roll','pitch','yaw'};
for i = 1:3 
 subplot(3,1,i)
 plot(data.current_state.time, data.current_state.transform.euler(i,:),'g.'); hold on;  
 ylabel(strcat(labels{i},' (deg)'));
 xlabel('time (sec)');
end
suptitle('Euler')


