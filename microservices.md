dns firewall

load balancer - path based routing & distribute
    - autehntication & authorization
    - CAPs theorem - 3 axes of scalability
      - consistency
      - availability
      - partition tolerance
    - 2 main capabilities 
      - distribute the traffic
      - service discovery
Node Port vs Cluster IP vs load balancer


Redis 
  - separate database is kept for each microservice

Session services 

Microservice communications
  - direct communication - must have loadbalancer between 
  - indirect communication - publish to queue/ broker - eventual consistency
    - best queue in market is Kafka
    - 2 modes
      - queue - does not need load balancer
      - pub sub model - brokers are intelligent to do load balancing so separate load balancing is not necessary

API gateway
  - work with authentication and authorization

Logging
  - needs to be externalised not inside an application
  - cloudwatch
  - ELK
  - Splunk
  - datadog and dynatrees

Event sinking

Scheduling
  - in kubernetes 'jobs'
  - trigger is given using  schedulers
  - do not have the exact business logic



    