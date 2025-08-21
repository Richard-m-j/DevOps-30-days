# Statefulset

## what is ingress
- In a microservice world, when we have a lot of microservices, having separate loadbalancer for each microservice is expensive
- Ingress helps to do path based routing
- loadbalancer should be able to do
    - path based routing
    - load balancing between the diferent pods - Cluster Ip
- Path based routing can be acheived through ingress
- in eks always deploy the eks ingress controller
- kubectl expose deploy my-deploy --port 8080 --type=clusterip 

## Namespace
- Not everything in k8 is part of namespace - pv
- pods created by kubernetes are part of kube-system namespace
- this is a logical separation created by kubernetes unlike the physical separation as in the case how linux handles namespace
- namespaces help to enforce network policies

