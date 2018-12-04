#!/bin/sh
kubectl create -f ./sc-ond.yaml && kubectl create -f ./pvc-ond.yaml
