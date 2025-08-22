
# Storage
- NFS
- EFS
- EBS
    - region specific
- S3
    - Dedicated storage service
    - We can have hot, hot-cold, cold storage
    - can be accessed from any region

## Volumes
- S3 is not supported for volumes
- multiple pods in any machine can connect to the same volume

### Types
#### Empty Dir
- Stored in memory
#### Host Path
- gets created on the machine where the pod gets created 
- not very useful as it is machine specific
- different pods can't access this

#### PVC
- what is the access mode
- storage class
- size 
- no info on which machien the volume is in 
- Storage administrator will create a PV
    - PV is very tightly bound with the storage
- PV and PVC are 1 to 1, once they are bound can't be separated
- most of the parameters are not updatable
- reclaim policy 

##### Storage in use protection
- You cannot delete a pv as long as a pvc is present
- you can't delete a pvc as long a pod is using it

##### Reclaiming

- retain
    - both the data and object is retained but the pv is deleted
- delete
    - if it is okay to delete the data and the service
- recycle
    - data gone, but the service or volume is present
- The reclaim policy can be modified

##### Access Mode

- Readwriteonce
    - all the pods that are running on the machine that the first pod came can write
- Readonlymany
- Readwritemany
- readwriteoncepod
    - only the first pod can write - everone else can just read
    - added only in 1.22

##### Static and Dynamic Provisioning
- Static
    - create a pv,pvc and attch the volume
- Dynamic
    - create of kind storage class
    - create a storage class to create a volume(eg ebs)
    - when we create a pvc, it will automaticcaly crete a pv of matching configuration
    - also possible to cretae multiple storage classes

    - only define the storage class and the pv and ebs be created automatically