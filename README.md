# Plan 

<img src="plan.png">

## setup Cluster --

<img src="setup.png">

## setup minikube based cluster in local pc 

<img src="minikube.png">

### Installing on MAC 

```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube
```

### checking 

```
 minikube version 
minikube version: v1.25.2
commit: 362d5fdc0a3dbee389b3d3f1034e8023e72bd3a7
```

### start mac 

<img src="min.png">

## Namespace in k8s

<img src="ns.png">

```
% kubectl  get  namespace
NAME                   STATUS   AGE
default                Active   22d
kube-node-lease        Active   22d
kube-public            Active   22d
kube-system            Active   22d
kubernetes-dashboard   Active   26h
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  get  ns       
NAME                   STATUS   AGE
default                Active   22d
```

### creating namespace 

```
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  create  namespace  ashu-space 
namespace/ashu-space created
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  get ns                        
NAME                   STATUS   AGE
ashu-space             Active   4s
default                Active   22d
```
### setting default namespace 

```
 kubectl get  pods
No resources found in default namespace.
fire@ashutoshhs-MacBook-Air k8s_deploy % 
fire@ashutoshhs-MacBook-Air k8s_deploy % 
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  config  set-context --current --namespace=ashu-space
Context "kubernetes-admin@kubernetes" modified.
fire@ashutoshhs-MacBook-Air k8s_deploy % 
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl get  pods                                            
No resources found in ashu-space namespace.
fire@ashutoshhs-MacBook-Air k8s_deploy % 
```

## Networking in k8s

### container networking 

<img src="cnet.png">

### CNI 

<img src="cni.png">

## Intro to k8s internal LB using -- 

<img src="svc.png">

## service use label to find Pod 

<img src="lb.png">

### service type 

<img src="stype.png">

## Nodeport service in k8s

<img src="np.png">

## Implement pod and Nodeport service 

### create pod 
```
kubectl  run  ashuwebapp  --image=dockerashu/ashuhttpd:v1  --port 80 --dry-run=client -o yaml       >webapp.yaml 

```

### Deploy pod 
<img src="podlb.png">

### create service 

```
 kubectl  create  service  
Create a service using a specified subcommand.

Aliases:
service, svc

Available Commands:
  clusterip    Create a ClusterIP service
  externalname Create an ExternalName service
  loadbalancer Create a LoadBalancer service
  nodeport     Create a NodePort service
```

### 

```
kubectl  create  service   nodeport  ashusvc1  --tcp  1234:80  --dry-run=client -o yaml 
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashusvc1
  name: ashusvc1
spec:
  ports:
  - name: 1234-80
    port: 1234
    protocol: TCP
    targetPort: 80
  selector:
    app: ashusvc1
  type: NodePort
status:
  loadBalancer: {}
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  create  service   nodeport  ashusvc1  --tcp  1234:80  --dry-run=client -o yaml >websvc.yaml
fire@ashutoshhs-MacBook-Air k8s_deploy % 
```
### mathching selector 

<img src="selector.png">

### deploy service 

```
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl apply  -f  websvc.yaml 
service/ashusvc1 created
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  get service 
NAME       TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
ashusvc1   NodePort   10.110.64.63   <none>        1234:30851/TCP   14s
fire@ashutoshhs-MacBook-Air k8s_deploy % 

```

### merging pod and service file 

```
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl apply -f  webapp.yaml 
pod/ashuwebapp created
service/ashusvc1 created
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl get po
NAME         READY   STATUS    RESTARTS   AGE
ashuwebapp   1/1     Running   0          6s
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl get svc
NAME       TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
ashusvc1   NodePort   10.110.225.66   <none>        1234:32174/TCP   7s
```

### app deployment using Deployment resource in k8s 

<img src="dep.png">

### creating deployment 

```
kubectl  create  deployment ashudep  --image=dockerashu/ashuhttpd:v1  --port 80 --dry-run=client        -o yaml >deployfile.yaml
```

### 

```
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl apply -f deployfile.yaml 
deployment.apps/ashudep created
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl get deployment 
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
ashudep   1/1     1            1           9s
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl get deploy     
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
ashudep   1/1     1            1           13s
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  get  po 
NAME                       READY   STATUS    RESTARTS   AGE
ashudep-5bf687b9bd-bwjzs   1/1     Running   0          27s
fire@ashutoshhs-MacBook-Air k8s_deploy % 
```
### recreation 

```
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  delete pod ashudep-5bf687b9bd-bwjzs
pod "ashudep-5bf687b9bd-bwjzs" deleted
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  get  po                            
NAME                       READY   STATUS    RESTARTS   AGE
ashudep-5bf687b9bd-kmsvx   1/1     Running   0          4s
```

### creating service by expose 

```
kubectl  get deploy 
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
ashudep   1/1     1            1           5m55s
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  expose  deployment  ashudep  --type NodePort  --port 80  --name ashusvc333 
service/ashusvc333 exposed
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  get  svcNAME         TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
ashusvc333   NodePort   10.96.54.42   <none>        80:32740/TCP   108s
fire@ashutoshhs-MacBook-Air k8s_deploy % 

```

### scaling 

```
1161  kubectl  scale deploy ashudep  --replicas=3
 1162  kubectl  get deploy 
 1163  kubectl  get deploy 
 1164  kubectl  get  po 
 1165  kubectl  get deploy ashudep -o yaml 
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl get  po --show-labels
NAME                       READY   STATUS    RESTARTS   AGE   LABELS
ashudep-5bf687b9bd-88h7q   1/1     Running   0          77s   app=ashudep,pod-template-hash=5bf687b9bd
ashudep-5bf687b9bd-kmsvx   1/1     Running   0          13m   app=ashudep,pod-template-hash=5bf687b9bd
ashudep-5bf687b9bd-xr52j   1/1     Running   0          77s   app=ashudep,pod-template-hash=5bf687b9bd
fire@ashutoshhs-MacBook-Air k8s_deploy % kubectl  get svc -o wide
NAME         TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE   SELECTOR
ashusvc333   NodePort   10.96.54.42   <none>        80:32740/TCP   11m   app=ashudep
```
