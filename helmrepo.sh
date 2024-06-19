helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system \
  --set clusterName=eks1 \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=us-east-1 \
  --set vpcId=vpc-0dd7d48b5b8e7d8a1
