# Plan 

<img src="plan.png">

## Docker engine data migration 

### FRom source system 

```
rsync -avp  /var/lib/docker/    root@3.88.139.0:/var/lib/docker/

```

### at target system 

```
[root@awsdocker ~]# docker  images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
[root@awsdocker ~]# docker  ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
[root@awsdocker ~]# 
[root@awsdocker ~]# systemctl restart  docker 
[root@awsdocker ~]# docker  ps -a
CONTAINER ID   IMAGE          COMMAND     CREATED          STATUS                     PORTS     NAMES
3d9583c1e016   e9adb5357e84   "/bin/sh"   33 minutes ago   Exited (0) 3 seconds ago             c1
[root@awsdocker ~]# docker images
REPOSITORY                     TAG        IMAGE ID       CREATED        SIZE
test                           v3         c857503b33d1   18 hours ago   5.57MB
<none>                         <none>     0027e8002982   18 hours ago   5.57MB
<none>                         <none>     ee43ba046f6e   18 hours ago   5.57MB
test                           v2         889781b07b99   18 hours ago   5.57MB
test                           v1         3ed7ecb78ccc   18 hours ago   5.57MB
poojaalp                       pycodev2   2cf6d87205d1   18 hours ago   54MB
poojaoracledockerid/poojaalp   pycodev2   2cf6d87205d1   18 hours ago   54MB
poojacimg                      v007       7331a74ea55c   18 hours ago   452MB
pavancimg                      v007       a2a772db271b   19 hours ago   452MB
ashucmig                       v007       1cba1484fcf7   19 hours ago   452MB
alpine                         latest     e9adb5357e84   6 days ago     5.57MB
busybox                        latest     2fb6fc2d97e1   11 days ago    1.24MB
centos                         centos7    eeb6ee3f44bd   6 months ago   204MB

```
