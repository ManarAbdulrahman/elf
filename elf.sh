#!/bin/bash

k3d cluster create elf -v /etc/machine-id:/etc/machine-id:ro -v /var/log/journal:/var/log/journal:ro -v /var/run/docker.sock:/var/run/docker.sock --agents 3 -p 30000-32767:30000-32767@server[0]
kubectl apply -f elf.namespace.yaml
helm repo add elastic https://helm.elastic.co
helm repo add fluent https://fluent.github.io/helm-charts
helm repo update
helm install elasticsearch elastic/elasticsearch --version=7.9.0 --namespace=elf
helm install fluent-bit fluent/fluent-bit --namespace=elf
helm install kibana elastic/kibana --version=7.9.0 --namespace=elf --set service.type=NodePort 
kubectl run random-logger --image=chentex/random-logger

