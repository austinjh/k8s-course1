sudo snap install microk8s --classic --channel=1.17/stable

https://slides.kubernetesmastery.com/#shpod
 kubectl apply -f https://k8smastery.com/shpod.yaml
kubectl attach --namespace=shpod -ti shpod
kubectl delete -f https://k8smastery.com/shpod.yaml

# Usefull commands
kubectl get services
kubectl get pods --all-namespaces 
kubectl get pods -A
kubectl get namespace
kubectl get 


https://microk8s.io/

IP=$(kubectl get services httpenv -o go-template --template '{{ .spec.clusterIP }}')

curl -s http://$IP:8888 | jq .HOSTNAME

kubectl run nginx --image nginx
1.18 way: kubectl create deployment nginx --image nginx

kubectl scale deployment httpenv --replicas 10

kubectl run littletomcat --image tomcat
kubectl get pods -o wide
kubectl delete pods littletomcat-658578b755-49kxj
kubectl expose deployment littletomcat --port 8888
kubectl get service
IP=$(kubectl get services littletomcat -o go-template --template '{{ .spec.clusterIP }}')


kubectl create deployment redis --image=redis
kubectl create deployment hasher --image=dockercoins/hasher:v0.1
kubectl create deployment rng --image=dockercoins/rng:v0.1
kubectl create deployment webui --image=dockercoins/webui:v0.1
kubectl create deployment worker --image=dockercoins/worker:v0.1

test
kubectl logs deploy/rng
kubectl logs deploy/worker

kubectl expose deployment redis --port 6379
kubectl expose deployment rng --port 80
kubectl expose deployment hasher --port 80

kubectl logs deploy/worker --follow

kubectl expose deploy/webui --type=NodePort --port=80

#find port
kubectl get services

kubectl get pods -w
kubectl get deployments -w
kubectl scale deployment worker --replicas=10

HASHER=$(kubectl get svc hasher -o go-template={{.spec.clusterIP}})
RNG=$(kubectl get svc rng -o go-template={{.spec.clusterIP}})

kubectl apply -f https://k8smastery.com/insecure-dashboard.yaml (or microk8s.enable dashboard)

kubectl get deploy/rng -o yaml > rng.yml
kubectl apply -f rng.yml --validate=false

kubectl label pods -l app=rng enabled=yes
kubectl edit service rng


kubectl label pod -l app=rng,pod-template-hash enabled-  #(Remove the 'enabled' label from the pod)

kubectl delete -f https://k8smastery.com/dockercoins.yaml
kubectl delete daemonset/rng

#Example of yaml output from a dry run
kubectl create deployment web --image nginx -o yaml --dry-run>> dryrun.yaml
#Dry run on Server
kubectl create deployment web --image=nginx -o yaml > web.yaml
kubectl apply -f web.yaml --server-dry-run --validate=false -o yaml

#Api Resources
kubectl api-resources
kubectl api-versions
kubectl explain pod
kubectl explain pod.spec
kubectl explain pod.spec.volumes
kubectl explain pod.spec --recursive

#Source testing
Yamllint
kubeval

curl -O https://k8smastery.com/just-a-pod.yaml
kubectl apply -f just-a-pod.yaml
#make change to yaml
kubectl diff -f just-a-pod.yaml
kubectl delete -f just-a-pod.yaml

# Update strategy
kubectl apply -f https://k8smastery.com/dockercoins.yaml

#in 4 terminals - rolling updates (1.8)
kubectl get pods -w 
kubectl get replicasets -w

kubectl set image deploy worker worker=dockercoins/worker:v0.2
kubectl set image deploy worker worker=dockercoins/worker:v0.3
kubectl rollout status deploy worker

kubectl describe deploy worker #Also check the dashboard from earlier

kubectl rollout undo deploy worker #reverse the latest rollout

kubectl rollout history worker

kubectl describe replicasets -1 app=worker | grep -A3 Annotations

kubectl rollout undo deployment worker --to-revision=1

#Health Probes
# See also: Apache Bench (ab) Load manager

#ConfigMaps
curl -O https://k8smastery.com/haproxy.cfg
kubectl create configmap haproxy --from-file=haproxy.cfg
kubectl get configmap haproxy -o yaml
kubectl apply -f https://k8smastery.com/haproxy.yaml
kubectl attach --namespace-shpod -ti shpod
kubectl get pod haproxy -o wide
IP=$(kubectl get pod haproxy -o json | jq -r .status.podIP)
or kubectl get pod haproxy -o wide

#Ingress
kubectl describe -n ingress-nginx deploy/nginx-ingress-controller