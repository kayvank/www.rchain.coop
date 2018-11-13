gcloud compute addresses create www-rchain-coop  --region us-west1-b 
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

kubectl create configmap AppNameConfig --from-literal API_HOST=http://api-host --from-literal STATIC_HOST=$STATIC_HOST

helm install \
  --name cert-manager \
  --namespace kube-system \
  --set ingressShim.defaultIssuerName=letsencrypt-staging \
  --set ingressShim.defaultIssuerKind=ClusterIssuer \
  stable/cert-manager \
  --version v0.3.0

kubectl create -f cert-manager-setup/letsencrypt-clusterissuer-staging.yaml

helm install stable/nginx-ingress \
  --name uck-nginx \
  --set rbac.create=true \
  --namespace kube-system
