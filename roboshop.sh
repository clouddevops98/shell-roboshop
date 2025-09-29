#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
$G_ID="sg-04f9b24ffc7783a86"

for instance in $@
do
   aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids 
   sg-04f9b24ffc7783a86 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,
   Value=$instance}]" --query 'Instances[0].InstanceId' --output text
   
   #Get Private IP
   if [ $instance != "frontend" ]; then
       IP=$(aws ec2 describe-instances --instance-ids i-0bd78c4903e53c4bb --query 'Reservations[0].Instances
       [0].PublicIpAddress' --output text)
    else
       IP=$(aws ec2 describe-instances --instance-ids i-0bd78c4903e53c4bb --query 'Reservations[0].Instances
       [0].PrivateIpAddress' --output text)
   fi

   echo "$instance: $IP"
done