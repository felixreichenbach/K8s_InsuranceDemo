#!/bin/bash

# Create Services
echo "Create Services:"

kubectl create -f mainframe-simulator/kubernetes/service.yaml
kubectl create -f legacyportal/kubernetes/service.yaml
kubectl create -f insurance-data-service/kubernetes/service.yaml
kubectl create -f modernportal/kubernetes/service.yaml

# Create Pods
echo "Create Pods:"

kubectl create -f mainframe-simulator/kubernetes/mainframe-simulator.yaml

kubectl create -f legacyportal/kubernetes/legacyportal.yaml

kubectl create -f insurance-data-service/kubernetes/insurance-data-service.yaml

kubectl create -f modernportal/kubernetes/modernportal.yaml

kubectl create -f oracledb/kubernetes/oracledb.yaml

echo "Wait until provisioned! This may take a couple of minutes!
Then hit Enter to proceed!"

read

# Get Public IPs and configure Network
echo "Configure Services:"

echo "Configure Legacy Portal"
  var_mfs=( $(kubectl get services mainframe-simulator-service | grep mainframe-simulator-service ) )
  echo ${var_mfs[0]} ${var_mfs[3]} ${var_mfs[4]}

  kubectl exec -it legacyportal -- bash -c "sed -i 's/<MAINFRAME-SIMULATOR-SERVICE-IP>/${var_mfs[3]}/g' src/APIUtil.js"

echo "Configure Modern Portal"
  var_ids=( $(kubectl get services insurance-data-service | grep insurance-data-service ) )
  echo ${var_ids[0]} ${var_ids[3]} ${var_ids[4]}

  kubectl exec -it modernportal -- bash -c "sed -i 's/<INSURANCE-DATA-SERVICE-IP>/${var_ids[3]}/g' src/APIUtil.js"

  #DEBUG:
  #sed -i  's/35.198.131.115/<INSURANCE-DATA-SERVICE-IP>/g' src/APIUtil.js

echo "Done"