# generic_scripts

# Put Log retention on cloudwatch log group
for lg in `aws --profile poc logs describe-log-groups |grep api-ecs-test|awk '{print $4}'`; do aws --profile poc logs put-retention-policy --log-group-name $lg --retention-in-days 7; done
# Delete Log streams from a log group
for stream in `aws --profile poc logs describe-log-streams --log-group-name api-ecs-dev/wx-api-xml-parser|awk '{print $7}'`;do echo $stream;done
