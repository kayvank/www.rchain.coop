#!/bin/bash
## Create the Docker registry secret
## 
kubectl create secret generic $PROJECT_NAME \
        --from-file=key.json=./key.json
