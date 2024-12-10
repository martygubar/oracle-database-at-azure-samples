#!/bin/bash

# Copyright (c) 2024 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# ensure you update the config file to match your deployment prior to running the deployment

source ./config

# Ask for confirmation
echo ""
echo "Are you sure you want to delete the sample resources?"
echo "- ADB: $ADB_NAME"
echo "- Bucket: $BUCKET_NAME"
echo "- VM: $VM_NAME"
echo ""
echo "Enter (y/n)"
read confirmation

if [[ $confirmation == [yY] || $confirmation == [yY][eE][sS] ]]; then
    echo "Deleting Autonomous Database"
    gcloud oracle-database autonomous-databases delete $ADB_NAME --location=$REGION --quiet

    echo "Deleting storage bucket $BUCKET_NAME"
    gcloud storage rm -r gs://$BUCKET_NAME/*
    gcloud storage buckets delete gs://$BUCKET_NAME
    
    echo "Deleting VM"
    gcloud compute instances delete $VM_NAME --zone $REGION-a     

    echo "The network has not been deleted. You can do that using the console.".
else
    echo "Deletion cancelled."
fi