# Plan 

<img src="plan.png">

## app deploy  / testing problems in past 

<img src="prob.png">

## bare-metal to hypervisor journey 

<img src="hyper.png">

## problem with VMs

<img src="vmprob1.png">

### OS layer understanding 

<img src="os.png">

### vm problem solved by COntainers 

<img src="cont1.png">

### intro to containers  by Docker 

<img src="cont2.png">

### Container runtime vs Hypervisor 

<img src="cre.png">

### only LInux and windows 2016 + based containers are possible by Docker 

<img src="cont3.png">

### Docker architecture 

<img src="darch.png">

### installing docker ce in OL 7.9 

```
[root@docker-engine ~]# yum   install docker  -y
Failed to set locale, defaulting to C
Loaded plugins: langpacks, ulninfo
ol7_MySQL80                                                                                | 3.0 kB  00:00:00     
ol7_MySQL80_connectors_community                                                           | 2.9 kB  00:00:00     
ol7_MySQL80_tools_community                                                                | 2.9 kB  00:00:00     
ol7_UEKR6                                                                                  | 3.0 kB  00:00:00     
ol7_addons                                                                                 | 3.0 kB  00:00:00     
ol7_ksplice                                                                                | 3.0 kB  00:00:00     
ol7_latest                   

```

### Docker ce installation link 

[link](https://docs.docker.com/engine/install/)

### start docker service in OL vm 

```
[root@docker-engine ~]# systemctl start  docker 
[root@docker-engine ~]# systemctl enable  docker 
Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
[root@docker-engine ~]# 
[root@docker-engine ~]# systemctl status docker 
● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2022-03-21 06:13:23 GMT; 40s ago
     Docs: https://docs.docker.com
 Main PID: 12249 (dockerd)
   CGroup: /system.slice/docker.service
           └─12249 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

```

### Docker infra team -- troubleshooting --

### non root users can't connection to docker daemon / service 

```
[ashu@docker-engine ~]$ docker  version 
Client: Docker Engine - Community
 Version:           19.03.11-ol
 API version:       1.40
 Go version:        go1.16.2
 Git commit:        9bb540d
 Built:             Fri Jul 23 01:33:55 2021
 OS/Arch:           linux/amd64
 Experimental:      false
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.40/version": dial unix /var/run/docker.sock: connect: permission denied

```

### solution --

```
usermod -aG docker  ashu
```

### testing back 

```
[ashu@docker-engine ~]$ docker  version  
Client: Docker Engine - Community
 Version:           19.03.11-ol
 API version:       1.40
 Go version:        go1.16.2
 Git commit:        9bb540d
 Built:             Fri Jul 23 01:33:55 2021
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.11-ol
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.16.2
  Git commit:       9bb540d
  Built:            Fri Jul 23 01:32:08 2021
  OS/Arch:          linux/amd64
```

### overall job done by root user in OL 7.9 vm 

```
[root@docker-engine ~]# history 
    1  yum   install docker  -y
    2  systemctl start  docker 
    3  systemctl enable  docker 
    4  systemctl status docker 
    5  for  i in   ashu deevena dwarka mahesh mari  natarajan nitin pavan sai suneel venkat pooja ; do useradd $i ; echo "Oracle098#"  |  passwd $i --stdin ; done 
    6  vim /etc/ssh/sshd_config 
    7  systemctl restart sshd
    8  history 
    9  docker  version 
   10  ls /home
   11  usermod -aG docker  ashu
   12  for  i in  `ls /home`; do usermod -aG docker $i ; done 

```


