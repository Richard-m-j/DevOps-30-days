# Kubernetes services
- When you create a nodeport it will internally crete a cluster IP
- A Node is a machine
- unless a port a is free on all machines, you cannot create a nodeport with that port

## Load Balancer
- when you create a load balancer it will also create a node port
- when createing cluster ip 3 params
    - target port
    - port (mandatory)
    - node port

    - if you skip target port if will assume port as target port

