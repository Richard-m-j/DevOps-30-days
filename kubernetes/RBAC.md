# RBAC
- Role Based Access Control
- internally all are done using certificates

## Roles
- Provide certain permissions
- They are namespaced objects - mandatory to have a namespace
- They are permissions for actions

## User or Group or Service account
- these are the entities that are assigned roles
- service account
    - used to give a certain permissions for a particular account and give permissions to that account

## Role binding
- This specifies what the role is and what the subject is as well
- Can be done in a many to many fashion

## cluster role
- There are some users who has access to all namespaces
- This is useful for kubernetes admin 
- cluster role binding
