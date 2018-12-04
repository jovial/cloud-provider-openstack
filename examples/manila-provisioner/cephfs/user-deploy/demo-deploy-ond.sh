#!/bin/sh
./vol-deploy-ond.sh && kubectl create -f demo-ond.yaml
