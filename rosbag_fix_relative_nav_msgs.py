#!/usr/bin/env python

import rospy
import roslib
import rosbag
from relative_nav.msg import DesiredState, Snapshot, FilterState, Command
from relative_nav.msg import NodeInfo, VOUpdate, Waypoint, Goal, Edge, Keyframe
import sys


def fix_bag(in_bag, out_bag):
    print('reading', in_bag)
    print('writing', out_bag)
    bag = rosbag.Bag(in_bag)
    with rosbag.Bag(out_bag, 'w') as outbag:
        topics = bag.get_type_and_topic_info()[1].keys()
        types = []
        for i in range(0,len(bag.get_type_and_topic_info()[1].values())):
            types.append(bag.get_type_and_topic_info()[1].values()[i][0])
            topic_mapping = dict(zip(topics, types))
            relative_nav_topics = []
        for t in topic_mapping:
            if topic_mapping[t][:12] == 'relative_nav':
                relative_nav_topics.append(t)
        print('relative_nav topics to change', relative_nav_topics)

        for topic, msg, t in bag.read_messages():
            if topic in relative_nav_topics:
                if topic_mapping[topic] == 'relative_nav_msgs/DesiredState':
                    new_message = DesiredState()
                    new_message.node_id = msg.node_id
                    new_message.pose = msg.pose
                    new_message.velocity = msg.velocity
                    new_message.acceleration = msg.acceleration
                    # new_message.position_valid = msg.position_valid
                    # new_message.velocity_valid = msg.velocity_valid
                    # new_message.acceleration_valid = msg.accleration_valid
                    outbag.write(topic, new_message, t)
                elif topic_mapping[topic] == 'relative_nav_msgs/Snapshot':
                    new_message = Snapshot()
                    new_message.header = msg.header
                    new_message.node_id = msg.node_id
                    new_message.state = msg.state
                    new_message.covariance_diagonal = msg.covariance_diagonal
                    outbag.write(topic, new_message, t)
                elif topic_mapping[topic] == 'relative_nav_msgs/FilterState':
                    new_message = FilterState()
                    new_message.node_id = msg.node_id
                    new_message.transform = msg.transform
                    new_message.velocity = msg.velocity
                    new_message.covariance = msg.covariance
                    outbag.write(topic, new_message, t)
                elif topic_mapping[topic] == 'relative_nav_msgs/Command':
                    new_message = Command()
                    new_message.roll = msg.roll
                    new_message.pitch = msg.pitch
                    new_message.yaw_rate = msg.yaw_rate
                    new_message.thrust = msg.thrust
                    outbag.write(topic, new_message, t)
                elif topic_mapping[topic] == 'relative_nav_msgs/VOUpdate':
                    new_message = VOUpdate()
                    new_message.header = msg.header
                    new_message.current_keyframe_id = msg.current_keyframe_id
                    new_message.new_keyframe = msg.new_keyframe
                    new_message.valid_transformation = msg.valid_transformation
                    new_message.transform = msg.transform
                    new_message.covariance = msg.covariance
                    outbag.write(topic, new_message, t)
                elif topic_mapping[topic] == 'relative_nav_msgs/Waypoint':
                    new_message = Waypoint()
                    new_message.x = msg.x
                    new_message.y = msg.y
                    new_message.z = msg.z
                    new_message.u = msg.u
                    new_message.v = msg.v
                    new_message.w = msg.w
                    new_message.yaw = msg.yaw
                    outbag.write(topic, new_message, t)
                elif topic_mapping[topic] == 'relative_nav_msgs/Edge':
                    new_message = Edge()
                    new_message.header = msg.header
                    new_message.from_node_id = msg.from_node_id
                    new_message.to_node_id = msg.to_node_id
                    new_message.transform = msg.transform
                    new_message.covariance = msg.covariance
                    outbag.write(topic, new_message, t)
                elif topic_mapping[topic] == 'relative_nav_msgs/Goal':
                    new_message = Goal()
                    new_message.node_id = msg.node_id
                    new_message.goal_id = msg.goal_id
                    new_message.pose.x = msg.pose.x
                    new_message.pose.y = msg.pose.y
                    new_message.pose.z = msg.pose.z
                    new_message.pose.yaw = msg.pose.yaw
                    outbag.write(topic, new_message, t)
                elif topic_mapping[topic] == 'relative_nav_msgs/Keyframe':
                    new_message = Keyframe()
                    new_message.header = msg.header
                    new_message.keyframe_id = msg.keyframe_id
                    new_message.rgb = msg.rgb
                    new_message.depth = msg.depth
                    outbag.write(topic, new_message, t)
                elif topic_mapping[topic] == 'relative_nav_msgs/NodeInfo':
                    new_message = NodeInfo()
                    new_message.header = msg.header
                    new_message.node_id = msg.node_id
                    new_message.keyframe_id = msg.keyframe_id
                    new_message.node_to_body = msg.node_to_body
                    new_message.camera_to_body = msg.camera_to_body
                    outbag.write(topic, new_message, t)
                else:
                    print('unhandled message type', topic_mapping[topic], 'at time', t)
            else:
                outbag.write(topic, msg)


if __name__ == "__main__":
    if len(sys.argv) == 3:
        fix_bag(sys.argv[1], sys.argv[2])
    else:
        print('')
        print('')
        print('rosbag relative_nav_msgs migration script')
        print('by James Jackson')
        print('')
        print('USAGE:')
        print('-h: \t show this menu')
        print('')
        print('[INPUT BAG FILE] \t [OUTPUT BAG FILE]')
