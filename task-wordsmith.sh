kubectl create deployment web --image=bretfisher/wordsmith-web
kubectl create deployment words --image=bretfisher/wordsmith-words
kubectl create deployment db --image=bretfisher/wordsmith-db

kubectl expose deployment web --type NodePort --port 80
kubectl expose deployment words --port 8080
kubectl expose deployment db --port 5432

kubectl scale deployment words --replicas=5
