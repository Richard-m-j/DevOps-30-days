# Scaling
## HPA
- Horizontal Pod autoscaling
- Even has limit, but much higher - the limit is caused by the communication limit  
- HPA controller 
- Metrix server - capable of identifying the CPU and memory of pods and node
- This is a  set - it will be created and run in all node

## VPA
- Vertical Pod autoscaling
- Recommended to not do
- vertical scaling always has limit

## CA
- Cluster Auto scaler
- When the node is reaching the limit, automatically adds / removes nodes
- For this kubernetes should work with the underlying provider
