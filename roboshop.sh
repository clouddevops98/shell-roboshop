#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
$G_ID="sg-04f9b24ffc7783a86"

for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids 
    $G_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances
    [0].InstanceId' --output text)
   
   #Get Private IP
   if [ $instance != "frontend" ]; then
       IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].
       PrivateIpAddress' --output text)
    else
       IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].
       PrivateIpAddress' --output text)
   fi

   echo "$instance: $IP"
done