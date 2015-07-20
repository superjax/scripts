%%

%data = processTopics({'/shredder/CG'},'~/rosbag/flight.bag');
data = processTopics({'/shredder/CG'},'~/rosbag/scan_matcher.bag');

figure(); clf;
  subplot(2,3,1); plot(data.shredder.CG.time,data.shredder.CG.transform.translation(1,:),'.')
  subplot(2,3,2); plot(data.shredder.CG.time,data.shredder.CG.transform.translation(2,:),'.')
  subplot(2,3,3); plot(data.shredder.CG.time,data.shredder.CG.transform.translation(3,:),'.')
  subplot(2,3,4); plot(data.shredder.CG.time,data.shredder.CG.transform.euler(:,1),'.')
  subplot(2,3,5); plot(data.shredder.CG.time,data.shredder.CG.transform.euler(:,2),'.')
  subplot(2,3,6); plot(data.shredder.CG.time,data.shredder.CG.transform.euler(:,3),'.')

%% Test vo_sim
 clear all
 %data = processTopics({'/vo_sim','/vo','/vo_sm'},'~/.ros/vo_cmu_vs_sim.bag',1436566133);
 data = processTopics({'/vo_sm','/vo','/vo_sim','/relative_state','/imu/data'},'~/.ros/sm_rmekf_all.bag');
 
 %data.vo_sim = data.vo_sm_relay;
 
 % Simulated
 t1 = data.vo_sim.time;
 xyz1 = data.vo_sim.transform.translation;
 euler1 = data.vo_sim.transform.euler.';
 m1 = data.vo_sim.new_keyframe;
 
 % VO
 %t2 = data.vo.time;
 %xyz2 = data.vo.transform.translation;
 %euler2 = data.vo.transform.euler.';
 %m2 = data.vo.new_keyframe;
 
 % SM
 t3 = data.vo_sm.time;
 xyz3 = data.vo_sm.transform.translation;
 euler3 = data.vo_sm.transform.euler.';
 m3 = data.vo_sm.new_keyframe;
 
 hold on;  
 figure(1); clf; 
  h(1) = subplot(3,2,1); hold on;
    plot(t1,   xyz1(1,:),'b.')
    %plot(t2,   xyz2(1,:),'g.')
    plot(t3,   xyz3(1,:),'r.') 
    legend('vo sim','vo','vo sm'); xlabel('time (s)'); ylabel('x (m)');
  h(2) = subplot(3,2,3); hold on;
    plot(t1,   xyz1(2,:),'b.')
    %plot(t2,   xyz2(2,:),'g.')
    plot(t3,   xyz3(2,:),'r.')
    legend('vo sim','vo','vo sm'); xlabel('time (s)'); ylabel('y (m)')
  h(3) = subplot(3,2,5); hold on;
    plot(t1,    xyz1(3,:),'b.')
    %plot(t2,   xyz2(3,:),'g.')
    plot(t3,    xyz3(3,:),'r.');
    legend('vo sim','vo','vo sm'); xlabel('time (s)'); ylabel('z (m)') 
  h(4) = subplot(3,2,2); hold on; 
    plot(t1, euler1(1,:),'b.')
    %plot(t2, euler2(1,:),'g.')
    plot(t3, euler3(1,:),'r.'); legend('vo sim','vo','vo sm'); xlabel('time (s)'); ylabel('roll (deg)');
  h(5) = subplot(3,2,4); hold on; 
    plot(t1, euler1(2,:),'b.')
    %plot(t2, euler2(2,:),'g.')
    plot(t3, -euler3(2,:),'r.'); legend('vo sim','vo','vo sm'); xlabel('time (s)'); ylabel('pitch (deg)')
  h(6) = subplot(3,2,6); hold on; 
    plot(t1, euler1(3,:),'b.')
    %plot(t2, euler2(3,:),'g.')
    plot(t3, euler3(3,:),'r.'); legend('vo sim','vo','vo sm'); xlabel('time (s)'); ylabel('yaw (deg)') 

  figure(2); clf
   t1     = data.imu.data.time;
   vel1   = data.imu.data.acc(3,:);
  
   %t1     = data.relative_state.time;
   %vel1   = data.relative_state.velocity;
   h(7) = subplot(1,1,1);
   plot(t1,vel1,'r.'); hold on;
   
   N = 50
   wts = [repmat(1/N,N,1)];
   yS = conv(abs(vel1),wts,'same');
   plot(t1,yS,'c.');
   
   legend('velocity,z','moving average');
  
   
   
    linkaxes(h,'x')
  
%% Test rmekf (with scans) vs truth
clear all
data = processTopics({'/truth/relative_state','/relative_state','/rmekf/ekf/hx','/rmekf/ekf/y'},'~/.ros/sm_rmekf.bag');
%data = processTopics({'/truth/relative_state','/relative_state','/rmekf/ekf/hx','/rmekf/ekf/y'},'~/.ros/cmu_rmekf.bag');
t1     = data.truth.relative_state.time;
xyz1   = data.truth.relative_state.transform.translation;
euler1 = data.truth.relative_state.transform.euler.';
q1     = data.truth.relative_state.transform.rotation;
vel1   = data.truth.relative_state.velocity;

t2     = data.relative_state.time;
xyz2   = data.relative_state.transform.translation;
euler2 = data.relative_state.transform.euler.';
q2     = data.relative_state.transform.rotation;
vel2   = data.relative_state.velocity;

figure(6); clf; 
 h(1) = subplot(3,2,1); plot(t1,   xyz1(1,:),'g.',t2,   xyz2(1,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('x (m)')
 h(2) = subplot(3,2,3); plot(t1,   xyz1(2,:),'g.',t2,   xyz2(2,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('y (m)')
 h(3) = subplot(3,2,5); plot(t1,   xyz1(3,:),'g.',t2,   xyz2(3,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('z (m)')
 h(4) = subplot(3,2,2); plot(t1, euler1(1,:),'g.',t2, euler2(1,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('roll (deg)')
 h(5) = subplot(3,2,4); plot(t1, euler1(2,:),'g.',t2, euler2(2,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('pitch (deg)') 
 h(6) = subplot(3,2,6); plot(t1, euler1(3,:),'g.',t2, euler2(3,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('yaw (deg)') 
 suptitle('Truth vs. RMEKF estimates (position, attitude)');
 
figure(7); clf; 
 h(7) = subplot(3,1,1); plot(t1,   vel1(1,:),'g.',t2,   vel2(1,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('x (m)')
 h(8) = subplot(3,1,2); plot(t1,   vel1(2,:),'g.',t2,   vel2(2,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('y (m)')
 h(9) = subplot(3,1,3); plot(t1,   vel1(3,:),'g.',t2,   vel2(3,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('z (m)')
 suptitle('Truth vs. RMEKF estimates (velocity)');
 
% % Check residuals
%clear all

t1     = data.rmekf.ekf.hx.time;
xyz1   = data.rmekf.ekf.hx.transform.translation;
euler1 = data.rmekf.ekf.hx.transform.euler.';
q1     = data.rmekf.ekf.hx.transform.rotation;


t2     = data.rmekf.ekf.y.time;
xyz2   = data.rmekf.ekf.y.transform.translation;
euler2 = data.rmekf.ekf.y.transform.euler.';
q2     = data.rmekf.ekf.y.transform.rotation;
mask = [diff(data.relative_state.node_id) == 1 0==0];

%xyz1(2,16:end) = xyz1(2,16:end) - 0.4;

figure(8); clf; 
 h(10) = subplot(3,1,1); plot(t1,   xyz1(1,:),'g.',t2,   xyz2(1,:),'b.'); legend('h(x)','z'); xlabel('time (s)'); ylabel('x (m)')
 h(11) = subplot(3,1,2); plot(t1,   xyz1(2,:),'g.',t2,   xyz2(2,:),'b.'); legend('h(x)','z'); xlabel('time (s)'); ylabel('y (m)');
 h(12) = subplot(3,1,3); plot(t1,   xyz1(3,:),'g.',t2,   xyz2(3,:),'b.'); legend('h(x)','z'); xlabel('time (s)'); ylabel('z (m)');
 suptitle('RMEKF residuals');
 
 linkaxes(h,'x')
   %plot(t1(16),   xyz1(2,16),'ro')
 %subplot(6,1,3); plot(t1,   xyz1(3,:),'g.',t2,   xyz2(3,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('z (m)')
 %subplot(6,1,4); plot(t1, euler1(1,:),'g.',t2, euler2(1,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('roll (deg)')
 %subplot(6,1,5); plot(t1, euler1(2,:),'g.',t2, euler2(2,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('pitch (deg)') 
 %subplot(6,1,6); plot(t1, euler1(3,:),'g.',t2, euler2(3,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('yaw (deg)') 
 
 
 %%
 
figure(5); clf; 
 subplot(7,1,1); plot(t1,   xyz1(1,:),'g.',t2,   xyz2(1,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('x (m)')
 subplot(7,1,2); plot(t1,   xyz1(2,:),'g.',t2,   xyz2(2,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('y (m)')
 subplot(7,1,3); plot(t1,   xyz1(3,:),'g.',t2,   xyz2(3,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('z (m)')
 subplot(7,1,4); plot(t1,     q1(1,:),'g.',t2,     q2(1,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('q_x (deg)')
 subplot(7,1,5); plot(t1,     q1(2,:),'g.',t2,     q2(2,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('q_y (deg)') 
 subplot(7,1,6); plot(t1,     q1(3,:),'g.',t2,     q2(3,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('q_z (deg)')
 subplot(7,1,7); plot(t1,     q1(3,:),'g.',t2,     q2(3,:),'b.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('q_w (deg)') 

 %%
data = processTopics({'/shredder2/CG'},'~/rosbag/scan_collect.bag');
t1      = data.shredder2.CG.time;
xyz1    = data.shredder2.CG.transform.translation;
euler1  = data.shredder2.CG.transform.euler.';
q1      = data.shredder2.CG.transform.rotation;
figure(6); clf; 
 subplot(6,1,1); plot(t1,   xyz1(1,:),'g.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('x (m)')
 subplot(6,1,2); plot(t1,   xyz1(2,:),'g.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('y (m)')
 subplot(6,1,3); plot(t1,   xyz1(3,:),'g.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('z (m)')
 subplot(6,1,4); plot(t1, euler1(1,:),'g.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('roll (deg)')
 subplot(6,1,5); plot(t1, euler1(2,:),'g.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('pitch (deg)') 
 subplot(6,1,6); plot(t1, euler1(3,:),'g.'); legend('truth','scanmatch'); xlabel('time (s)'); ylabel('yaw (deg)')
