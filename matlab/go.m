% go.m

topics = {  '/estimator/ekf/state' 
            '/truth/relative/state' 
            '/estimator/ekf/y' 
            '/estimator/ekf/hx' 
            '/sensors/vo_cmu' 
            '/vo_sim'
            '/estimator/ekf/snapshot'
            '/sensors/alt_msgs'};
      
bagfile = '~/.ros/saved_states.bag';

data = processTopics(topics.',bagfile);
%data2 = processTopics({'/sensors/alt_msgs'},'~/rosbag/poor_control_on_truth.bag');

%data.sensors.alt_msgs = data2.sensors.alt_msgs;

plot_states