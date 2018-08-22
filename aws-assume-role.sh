#!/bin/bash

ACC=$1
ROLE=$2
OUTPUT=`/usr/bin/aws --output text sts assume-role --role-arn arn:aws:iam::$ACC:role/$ROLE --role-session-name $ROLE | tail -n 1` 
export AWS_ACCESS_KEY_ID=`echo $OUTPUT | awk '{ print $2 }'`
export AWS_SECRET_ACCESS_KEY=`echo $OUTPUT | awk '{ print $4 }'`
export AWS_SESSION_TOKEN=`echo $OUTPUT | awk '{ print $5 }'`
