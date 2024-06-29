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





Deploying a Gaming App with Ingress Controller on Amazon EKS"

Content:

Implemented DevOps practices to deploy a scalable gaming app on Amazon EKS.
Utilized Fargate, Kubernetes resources, Ingress, and ALB for external access.
Configured Ingress Controller, reducing load balancer costs.
Achieved scalability, availability, and security while optimizing performance and cost-efficiency.
Pre-requisites:

"kubectl: Kubernetes documentation"
"eksctl: AWS EMR on EKS Development Guide"
"awscli: AWS CLI User Guide"
"helm: Helm documentation"
Commands Used:

"To create the cluster: eksctl create cluster --name gaming2048 --region us-east-1 --fargate"
"To connect to the cluster: aws eks update-kubeconfig --name gaming2048"
"To create a fargate profile: eksctl create fargateprofile --cluster gaming2048 --region us-east-1 --name alb-gaming-app --namespace game-2048"
"To create a new namespace resource: kubectl apply -f namespace.yaml"
"To create a deployment resource: kubectl apply -f deployment.yaml"
"To create a service resource: kubectl apply -f service.yaml"
"To create an ingress resource: kubectl apply -f ingress.yaml"
"To connect to the OIDC provider: eksctl utils associate-iam-oidc-provider --cluster gaming2048 --approve"
"To download IAM permissions required for the role: curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json"
"To create the role: aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json"
"To create a service account and attach it to the role: eksctl create iamserviceaccount --cluster=gaming2048 --namespace=kube-system --name=aws-load-balancer-controller --role-name AmazonEKSLoadBalancerControllerRole --attach-policy-arn=arn:aws:iam::211125556539:policy/AWSLoadBalancerControllerIAMPolicy --approve"
"To download and update the helm for load balancer: helm repo add eks https://aws.github.io/eks-charts helm repo update eks"
"To install the load balancer: helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=gaming2048 --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller --set region=us-east-1 --set vpcId=vpc-050b1e93673dbfcf4"

