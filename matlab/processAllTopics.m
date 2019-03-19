function [ data ] = processAllTopics( bagfile, t0, tf )

assert(exist(bagfile,'file') ~= 0,'Bag file does not exist');

clear rosbag_wrapper;
clear ros.Bag;

addpath('matlab_rosbag-0.4.1-linux64')
addpath('navfn')

bag = ros.Bag.load(bagfile);
switch nargin
    case(2)
    data = processTopics(bag.topics, bagfile, t0);
    case(3)
     data = processTopics(bag.topics, bagfile, t0, tf);
    case(1)
    data = processTopics(bag.topics, bagfile);
    otherwise
end
end

