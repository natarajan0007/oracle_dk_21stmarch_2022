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

## Docker container restart policy 

[docs](https://docs.docker.com/config/containers/start-containers-automatically/)

```
docker run -itd --name c3  --restart always alpine 
```

## Webapps in a container 

### app servers 

<img src="apps.png">

### sample webapp with apache httpd server 

<img src="httpd.png">

## Docker networking 

### setup 1

<img src="net1.png">

### checking network bridge details as docker client 

```
[ashu@docker-engine-new webapp]$ docker  network   ls
NETWORK ID          NAME                DRIVER              SCOPE
653848cd21ea        bridge              bridge              local
79e79a3c217c        host                host                local
f753c4f2115d        none                null                local
[ashu@docker-engine-new webapp]$ 

```

### checking bridge details from docker client 

```
[ashu@docker-engine-new webapp]$ docker  network   inspect  bridge 
[
    {
        "Name": "bridge",
        "Id": "653848cd21eafb4126b93757282b93d157a949ccde319cfef86d0edac5a00dc4",
        "Created": "2022-03-23T05:06:15.603691969Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
```

### check NIC from linux admin as root user 

<img src="root.png">

### IP address allocation to containers using bridge 

<img src="ip.png">

### docker json format 

```
418  docker  inspect  ashuc1  --format='{{.Id}}'
  419  docker  inspect  ashuc1  --format='{{.State.Status}}'
  420  docker  inspect  ashuc1  --format='{{.NetworkSettings.IPAddress}}'
  421  docker  ps
  422  docker  inspect  pragnyac1  --format='{{.NetworkSettings.IPAddress}}'
```

### checking network from inside container 

```
[ashu@docker-engine-new webapp]$ docker  exec  -it  ashuc1  sh 
/ # ifconfig 
eth0      Link encap:Ethernet  HWaddr 02:42:AC:11:00:02  
          inet addr:172.17.0.2  Bcast:172.17.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:14 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:1156 (1.1 KiB)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

/ # route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         172.17.0.1      0.0.0.0         UG    0      0        0 eth0
172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 eth0
/ # exit
```

### port forwarding 

<img src="portf.png">

```
docker  run  -itd  --name ashwebapp1  -p   1234:80  ashuhttpd:v1  
444c4e71f5282e4a191297de984df623b5516e98a4e598094ed78010e82d091d
[ashu@docker-engine-new webapp]$ docker  ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
444c4e71f528        ashuhttpd:v1        "/bin/sh -c 'httpd -…"   19 seconds ago      Up 17 seconds       0.0.0.0:1234->80/tcp   ashwebapp1
[ashu@docker-engine-new webapp]$ 
```
