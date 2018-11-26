#!/bin/bash
##
## create the gcp env

## reser
gcloud compute addresses create www-rchain-coop  --region global

kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

kubectl create -f ./tiller-clusterrolebinding.yaml

helm install  --name cert-manager \
     -f ./cert-manager-setup/cert-manager-values.yaml \
     stable/cert-manager


helm install \
     --name cert-manager \
     --namespace kube-system \
     --set rbac.create=true \
     stable/cert-manager

# helm install \
#      --name cert-manager \
#      --namespace kube-system \
#      --set ingressShim.defaultIssuerName=letsencrypt-staging \
#      --set ingressShim.defaultIssuerKind=ClusterIssuer \
#      stable/cert-manager 

helm install \
  --name cert-manager \
  --namespace kube-system \
  --set ingressShim.defaultIssuerName=letsencrypt-staging \
  --set ingressShim.defaultIssuerKind=ClusterIssuer \
  --set rbac.create=true \
  stable/cert-manager 

kubectl create -f cert-manager-setup/letsencrypt-clusterissuer-staging.yaml

helm install stable/nginx-ingress \
  --name coop-nginx \
  --set rbac.create=true \
  --namespace kube-system 
