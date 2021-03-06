function data = processTopics(topics, bagfile, tstart, tend)
%clear rosbag_wrapper;
%clear ros.Bag;

  if nargin < 3
    tstart = 0;
  end
  
  if nargin < 4
      tend = inf;
  end

addpath('./matlab_rosbag-0.4.1-linux64')
addpath('./navfn')
t0 = -1

bag = ros.Bag.load(bagfile);
for topic = topics
    ind = find(ismember(bag.topics,topic),1);
    if isempty(ind)
        fprintf('Could not find topic: %s\n',topic{:});
        continue;
    end
    fprintf('   Processing topic: %s\n',topic{:});
    type = bag.topicType(topic{:});    
    [msgs, meta] = bag.readAll(topic);
    
    a = [msgs{:,:}];
    c = [meta{:,:}];
    d = [c.time];
    
    % use header time if it exists
    t = [];
    if isfield(a, 'header')
        e = [a.header];
        f = [e.stamp];
        t = [f.time];
    else
        t = [d.time];
    end
    
    if t0 < 0
        t0 = t(1);
    end
    
    clear struct
    struct.t = t - t0;
    switch type{:}
        case 'std_msgs/Float32'
            struct.a = a;
        case 'sensor_msgs/Temperature'
            struct.temp = [a.temperature];
            struct.cov = [a.variance];
        case 'sensor_msgs/MagneticField'
            struct.mag = [a.magnetic_field];
            struct.cov = [a.magnetic_field_covariance];
        case 'rosflight_msgs/OutputRaw'
            struct.values = [a.values];
        case 'rosflight_msgs/Status'
            struct.failsafe = [a.failsafe];
            struct.armed = [a.armed];
            struct.rc_override = [a.rc_override];
            struct.num_errors = [a.num_errors];
            struct.loop_time_us = [a.loop_time_us];
        case 'rosgraph_msgs/Log'
            struct.level = [a.level];
            struct.msg = {a.msg};
        case 'std_msgs/String'
            struct.msg = {a.data};
        case 'rosflight_msgs/Attitude'
            struct.q = [a.attitude];
            [r,p,y] = rollPitchYawFromQuaternion(struct.q');
            struct.q_euler = [r,p,y]*180/pi;
            struct.omega = [a.angular_velocity];
        case 'geometry_msgs/Vector3Stamped'
            struct.vec = [a.vector];            
        case 'rosflight_msgs/Barometer'
            struct.altitude = [a.altitude];
            struct.pressure = [a.pressure];
            struct.temperature = [a.temperature];
        case 'rosflight_msgs/GPS'
            struct.fix = [a.fix];
            struct.num_sat = [a.NumSat];
            struct.latitude = [a.latitude];
            struct.longitude = [a.longitude];
            struct.altitude = [a.altitude];
            struct.speed = [a.speed];
            struct.ground_course = [a.ground_course];
            struct.covariance = [a.covariance];
        case 'rosflight_msgs/Command'
            struct.mode = [a.mode];
            struct.ignore = [a.ignore];
            struct.x = [a.x];
            struct.y = [a.y];
            struct.z = [a.z];
            struct.F = [a.F];
        case 'std_msgs/Bool'
            struct.data = a;
        case 'rosflight_msgs/RCRaw'
            struct.vals = [a.values];
        case 'relative_nav/FilterState'
            b = [a.transform];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            [r,p,y] = rollPitchYawFromQuaternion(struct.transform.rotation.');
            struct.transform.euler = [r,p,y]*180/pi;
            struct.velocity = [a.velocity];     
            struct.node_id = [a.node_id];
         case 'sensor_msgs/NavSatFix'
            struct.latitude = [a.latitude];
            struct.longitude = [a.longitude];
            cov = [a.position_covariance];
            struct.hAcc = cov(1,:);
        case 'geometry_msgs/Transform'
            struct.transform.translation = [a.translation];
            struct.transform.rotation = [a.rotation];
            [r,p,y] = rollPitchYawFromQuaternion(struct.transform.rotation.');
            struct.transform.euler = [r,p,y]*180/pi;
        case 'geometry_msgs/TransformStamped'
            b = [a.transform];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            [r,p,y] = rollPitchYawFromQuaternion(struct.transform.rotation.');
            struct.transform.euler = [r,p,y]*180/pi;
        case 'relative_nav/DesiredState'
            struct.pose = [a.pose];
            struct.velocity = [a.velocity];
            struct.acceleration = [a.acceleration];
            struct.node_id = [a.node_id];
        case 'relative_nav/Snapshot'
            struct.state = [a.state];
            struct.covariance = [a.covariance_diagonal];
            struct.node_id = [a.node_id];
        case 'geometry_msgs/PoseStamped'
            b = [a.pose];
            struct.pose.position = [b.position];
            struct.pose.orientation = [b.orientation];
        case 'sensor_msgs/Range'
            struct.range = [a.range];
        case 'relative_nav/VOUpdate'
            b = [a.transform];
            struct.current_keyframe_id = [a.current_keyframe_id];
            struct.new_keyframe = [a.new_keyframe];
            struct.valid_transformation = [a.valid_transformation];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            [r,p,y] = rollPitchYawFromQuaternion(struct.transform.rotation.');
            struct.transform.euler = [r,p,y]*180/pi;
        case 'relative_nav/Command'
            struct.commands = [a];
        case 'evart_bridge/transform_plus'
            b = [a.transform];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            struct.transform.euler = rollPitchYawFromQuaternion(struct.transform.rotation.')*180/pi;
            struct.euler = [a.euler];
            struct.velocity = [a.velocity];
        case 'relative_nav/Edge'
            b = [a.transform];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            struct.transform.euler = rollPitchYawFromQuaternion(struct.transform.rotation.')*180/pi;
            struct.from_node_id = [a.from_node_id];
            struct.to_node_id = [a.to_node_id];
            struct.covariance = [a.covariance];   
        case 'nav_msgs/Odometry'
            b = [a.pose];
            c = [b.pose];
            struct.pose.position = [c.position];
            struct.pose.orientation = [c.orientation];  
        case 'geometry_msgs/Point'
            struct.point = a;
        case 'ublox_msgs/NavPOSLLH'
            struct.lon = double([a.lon])/1e7;
            struct.lat = double([a.lat])/1e7;
            struct.hAcc = [a.hAcc];
            [struct.x,struct.y,struct.zone] = deg2utm(struct.lat,struct.lon);
        case 'sensor_msgs/NavSatFix'
            struct.lon = [a.longitude];
            struct.lat = [a.latitude];
            cov = [a.position_covariance];
            struct.cov = cov(1,:);
            [struct.x,struct.y,struct.zone] = deg2utm(struct.lat,struct.lon);  
        case 'sensor_msgs/Imu'
            struct.acc = [a.linear_acceleration];
            struct.gyro = [a.angular_velocity];   
        case 'sensor_msgs/LaserScan'
            struct.angle_min = [a.angle_min];
            struct.angle_max = [a.angle_max];
            struct.angle_increment = [a.angle_increment];
            struct.time_increment = [a.time_increment];
            struct.range_min = [a.range_min];
            struct.range_max = [a.range_max];
            struct.ranges = [a.ranges];
            struct.intensities = [a.intensities];
        case 'rosflight_msgs/Airspeed'
            struct.velocity = [a.velocity];
            struct.diff_press = [a.differential_pressure];
            struct.temperature = [a.temperature];
        case 'visualization_msgs/Marker'
            number = 1;
            for i = a(end:-1:1)
               if(size(i.points,2) > 2)
                   if(number == 1)
                       struct.opt.points = i.points;
                       number = 2;
                   elseif(number == 2)
                      
                       struct.unopt.points = i.points;
                       break
                   else
                    break
                   end
               end
            end            
        otherwise
            fprintf('     Type: %s not yet supported!\n',type{:});
            continue
    end
    
    struct = filter_struct(struct, (struct.t > tstart & struct.t < tend));
    
    % Split topic name into sections
    topic_parts = strsplit(topic{1},'/');
    topic_parts(cellfun('isempty', topic_parts)) = [];
    switch size(topic_parts,2)
        case 1
            data.(topic_parts{1}) = struct;
        case 2
            data.(topic_parts{1}).(topic_parts{2}) = struct;
        case 3
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}) = struct;
        case 4
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).(topic_parts{4}) = struct;
        case 5
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).(topic_parts{4}).(topic_parts{5}) = struct;
        otherwise
            fprintf('Too long');
    end
    
end
end

function struct = filter_struct(struct, indexes)
    fields = fieldnames(struct);
    for i = 1:numel(fields)
        if isstruct(struct.(fields{i}))
            struct.(fields{i}) = crop_struct(struct.(fields{i}));
        else
            shape = size(struct.(fields{i}));
            if shape(2) < shape(1)
                struct.(fields{i}) = struct.(fields{i})'; 
            end
            struct.(fields{i}) = struct.(fields{i})(:, indexes);
        end
    end
end
