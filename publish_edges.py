#!/usr/bin/env python

import rospy
import argparse
import csv
import itertools
import os
import sys
from relative_nav_msgs.msg import Edge

parser = argparse.ArgumentParser(description="Publishing edges defined by a csv file.")
parser.add_argument('csvfile',   help='Name of CSV file to open')
#parser.add_argument('topic', 	help='Name of topic')
parser.add_argument('--topic', default="edges", help='Topic to publish edges on')
#parser.add_argument('--text',  action='store_true', help='Flag to display text to screen')
args = parser.parse_args()

if not os.path.exists(args.csvfile):
	print "Cannot find specified filename: %s" % args.csvfile
	sys.exit(1)

rospy.init_node("edge_publisher_node", anonymous=True)

edge_publisher = rospy.Publisher(args.topic, Edge)
waitshort = rospy.Rate(20)
waitlong  = rospy.Rate(1.0)
waitlong.sleep() #Needs to wait a little bit??

with open(args.csvfile, 'r') as f:
    reader = csv.reader(f)
    for i,row in enumerate(reader):
        edge = Edge()
        edge.header.frame_id         = 'ha'
        edge.header.stamp            = rospy.get_rostime()
        edge.from_node_id            = int(row[0])
        edge.to_node_id              = int(row[1])
        edge.transform.translation.x = float(row[2])
        edge.transform.translation.y = float(row[3])
        edge.transform.translation.z = float(row[4])
        edge.transform.rotation.x    = float(row[5])
        edge.transform.rotation.y    = float(row[6])
        edge.transform.rotation.z    = float(row[7])
        edge.transform.rotation.w    = float(row[8])
        edge_publisher.publish(edge)
        waitshort.sleep()
print 'done'
