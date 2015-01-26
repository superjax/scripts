topics = {  '/tf' 
            '/current_state' 
            '/estimator/ekf/state' 
            '/estimator/ekf/y' 
            '/estimator/ekf/hx' 
            '/desired_state' 
            '/estimator/ekf/snapshot'};
      
bagfile = '~/rosbag/worked_on_estimates_1.bag';

data = processTopics(topics.',bagfile)