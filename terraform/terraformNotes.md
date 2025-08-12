# DevOps
DevOps are a set of practices that combines software development (Dev) and IT operations (Ops)
Aims to Shorten the systems development life cycle
Provide continuous delivery with high software quality

- IaC
    - Infrastructure Provisioning Tools
        - Terraform , cloudoformation, bicep
           
    - configureation management tools
        - Ansible, Chef, Puppet
        - 2 models
            - pull 
            - push
        - ANSIBLE is pull and push model - the server pulls the facts from the instances and then pushes the modules needed to execute into the instances
    - server templating tools
        - Docker, Vagrant
- Moitoring

## Terraform
- Terraform init
    - intitializes backend - creates the tfstate file
    - intitializes plugins
    - creates a lock file
- Terraform is declarative
- apply method works on all the .tf files in the folder
- .tfstate file contains the information about what was created last time
- it also refers the cloud