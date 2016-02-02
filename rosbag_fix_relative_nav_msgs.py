#!/usr/bin/env python

import rosbag
from relative_nav.msg import DesiredState
import sys

def fix_bag(in_bag, out_bag):
	print "reading", in_bag
	print "writing", out_bag
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

					print "relative_nav topics to change", relative_nav_topics

					for topic, msg, t in bag.read_messages():
						if topic in relative_nav_topics:
							if topic_mapping[topic] == 'relative_nav/DesiredState':
								new_message = relative_nav.DesiredState
								new_message.node_id = msg.node_id
								new_message.pose = msg.pose
								new_message.velocity = msg.velocity
								new_message.acceleration = msg.acceleration
								new_message.position_valid = msg.position_valid
								new_message.velocity_valid = msg.velocity_valid
								new_message.acceleration_valid = msg.accleration_valid
								print new_message
								print msg
								outbag.write(topic, new_message, t)

if __name__ == "__main__":
	fix_bag(sys.argv[1], sys.argv[2])