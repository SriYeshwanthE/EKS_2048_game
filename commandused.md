####Create EKS cluster 

#Install using Fargate####

eksctl create cluster --name eks1 --region us-east-1 --fargate


#####Crteating Fargate Profile
 
eksctl create fargateprofile \
    --cluster demo-cluster \
    --region us-east-1 \
    --name alb-sample-app \
    --namespace game-2048

###Creating Deployments,svc,ingress

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/examples/2048/2048_full.yaml 











#Download IAM policy
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json

#Create IAM Policy
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

#create iam role 

eksctl create iamserviceaccount \
  --cluster=<your-cluster-name> \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::<your-aws-account-id>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve





#Deploy ALB Controller#
#>>>>>>>>>>>>>>>>>>>>>>Helm Repo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

####Add helm repo

helm repo add eks https://aws.github.io/eks-charts


##Update the repo

helm repo update eks



####Install

helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system \
  --set clusterName=<your-cluster-name> \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=<region> \
  --set vpcId=<your-vpc-id>


####Verify that the deployments are running.

kubectl get deployment -n kube-system aws-load-balancer-controller

