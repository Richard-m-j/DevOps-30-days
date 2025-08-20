# Docker Networking

- GNS - open source tool to simulate network
- ARP 
    - to get mac address of  the devices in the network, the switch finds the mac and route table
- default route
    - when all internal communication fails, the route taken
    - The switch first tries to communicate using the default route
- Gateways connect 2 different types of network
- 1 machine can be connected to multiple networks
- When the switch could not find the address internally, it will then route to the gateway or the default route

eth0
- default etherenet card 

- docker0
    - switch created by docker
    - pokes new rules into the ip table
    - 172.17.0.1 to 172.17.255.255
- veth0
    - virtual ethernet 
- All containers created have eth0, from each eth0 there is a veth to the switch docker0
- all containers will also have the lo
- You can create separate networks using docker the ip range will be from 172.18.0.1 to 172.18.255.255
- docker0 is the implementatio nof bridge network. 
- You can cretae only a bring network.  

Host Network
- Use the host machines network.
- Will not create docker0

None Network
- It will not connect to any network

