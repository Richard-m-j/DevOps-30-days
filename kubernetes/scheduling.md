# Scheduling
- we can specify which machine to put the pod we want - in the spec
- When the  resquest from client itself specifies which node to use - the etcd entry will itself have the info on which node to put the pod in, so scheduler will not come into picture
- we can use selector to specify this

## Taint
- when a pod is tainted
    - any pod created will not go into that node
- if a pod has toleration for a particular taint, it can go into a machine with that taint - but it can also go into other machines as well
- this is used to customize which machines are used for which machine 

### No schedule
- pod which is already there does not matter if it does not have the tolerance for the taint

### prefer no schedule
- preference is to abide by the taint rule. but if other nodes are not in a good situation then use it

### No execute
- any pod that does not abide by the toleration rule of the taint, will be removed
- can also be anti affinity

## Affinity
- Can be specified in percentages

### node
- this pod will go to this node or anti affinity
 
### pod
- this pod will go to a node with this other pod is there or the anti affinity
