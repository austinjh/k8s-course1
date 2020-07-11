kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --type=NodePort --port=80
kubectl edit service nginx

kubectl label deploy -l app=nginx myapp=web #not working, use pod instead

kubectl create deployment httpd --image=httpd
kubectl label deploy -l app=httpd myapp=web #not working, used pod instead
kubectl label deploy -l app=httpd myapp=web #not working, used pod instead