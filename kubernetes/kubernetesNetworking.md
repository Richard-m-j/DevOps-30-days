# Kubernetes Networking

## how containers in the same pod talk to each other using localhost
- simple linux capability
- in the same namespace they can talk - linux kernel capability

## how the containers in different pods talk to eachother using ip
- There is a CBR - custom bridge
- CBR works like a switch
- similar to docker networking

## how containers in pods in different machines talk with ip
- uses network plugin (Eg: weave)
- Specification is given by kubernetes, the plugins can do this implementations as they like
- There are plenty of algorithms for this
- The network plugin already has the network specifications for all the machines, 
- The network plugin can figure out the machine from the IP address itself
- the plugin delivers to the destination machine it is then given to the CBR

## how using CLUSTER IP
- kube-proxy
- the kube proxy always talks to the api server and gives the pods associated with each service
- when cluster ip or the service gets a request, it will chose a pod associated with it, do the denating and change the to address and forward the request to the pod
- cluster ip is just an entry in etcd. NOT A physical 
### ip in ip
- the ip of the cluster ip is wraped by message with the ip of the destination

## DNS
- There is a service for dns, kube-dns
- this is responsibe for giving the ip address associated with the domain names
- This is how we are able to communicate with cluster IP

https://github.com/vilasvarghese/docker-k8s/blob/master/notes/day4/KubernetesNetworking.txt