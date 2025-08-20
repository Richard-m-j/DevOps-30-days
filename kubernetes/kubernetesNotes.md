# Kubernetes
- master and worker nodes
    - master 
        - kube-scheduler
            - works based on event driven architecture
            - runs an algorithm to figure out which is the best node to create the pod
            - Check the ETCD for the status of the nodes
            - updates the etcd by talking to the api server
        - kube controller
            - when the desired state is not matching the desired state, it works on it
            - ensures all automated processes work, else it will rectify
        - kube-apiserver
            - does authentication and authorization and Validate
            - communicate to etcd
            - kublet is constantly updating the API Server
        - ETCD 
            - stores info on what all are created
            - only thing that is stateful
            - NoSQL database
    - Worker
        - kubelet
            - not a pod
            - it is a program
            - systemctl status kublet
            - keeps the master informed 
            - the containers are created by kubelet
        - kube-proxy
            - runs on all nodes and understands the networking of all nodes
            - helps in networking
        
        - containerd/CRIO(CRI)/Pods
            - group of 1 or more containers
            - they are colocated
            - coscheduled 
            - share certain namespaces
                - network space
                - file system space 

## Pod
- kubectl will make a REST request to API server 
    - converts to the rest api
    - input to json
    - embedding the certificate within that request
- The api server will then authenticate and authorize and validate and enter into to ETCD
- When there is an entry in the ETCD the scheduler will get involved
- THe API server on the master node will talk to the kubelet
- The kublet will keep the API server updated
- If at any point a container goes down kulet will replaces and then updates the API server
    - This is called RESTART
## Replicaset
- There is a controller when there is an entry in the ETCD for the replicas, the replica a controller will then create entries in the ETCD for individual pods, this entry will then trigger the scheduler.

- loadbalancer is there between workers and master when there is more than 1 master nodes
- 