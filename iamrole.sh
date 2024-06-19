eksctl create iamserviceaccount \
  --cluster=eks1 \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::767398130612:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve \
  --region=us-east-1
