#!/bin/bash
#Script to discover ephemeral storage and mount them  as a single logical volume group.

# Get all ephemeral volumes
ephemeral_volumes=`curl -s http://169.254.169.254/latest/meta-data/block-device-mapping/ |grep ephemeral`

for each_volume in $ephemeral_volumes;
do
  mount_volume=`ls -l $each_volume |awk -F " " '{print $11}'`
  mount

~
