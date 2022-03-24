# Plan 

<img src="plan.png">

## Docker compose to automate container process 

<img src="compose.png">

### compose installation link and verification 

[compose link](https://docs.docker.com/compose/install/)

## verification 

```
docker-compose  -v 
docker-compose version 1.29.2, build 5becea4c
```

### compose file 1 

<img src="file1.png">

### running compsoe file 

```
[ashu@docker-engine-new docker_images]$ ls
docker-compose.yaml  Dockerfile  java_app  python_app  webapp
[ashu@docker-engine-new docker_images]$ docker-compose up  -d 
Creating network "docker_images_default" with the default driver
Pulling ashuapp1 (alpine:)...
Trying to pull repository docker.io/library/alpine ... 
latest: Pulling from docker.io/library/alpine
3aa4d0bbde19: Pull complete
Digest: sha256:ceeae2849a425ef1a7e591d8288f1a58cdf1f4e8d9da7510e29ea829e61cf512
Status: Downloaded newer image for alpine:latest
Creating ashuc1 ... done
```

### some more compose commands 

### list containers

```
 docker-compose ps
 Name      Command     State   Ports
------------------------------------
ashuc1   ping fb.com   Up           
```

### 

```
ashu@docker-engine-new ashucompose]$ docker-compose kill 
Killing ashuc1 ... done
[ashu@docker-engine-new ashucompose]$ docker-compose  ps
 Name      Command      State     Ports
---------------------------------------
ashuc1   ping fb.com   Exit 137        
[ashu@docker-engine-new ashucompose]$ docker-compose  start
Starting ashuapp1 ... done
[ashu@docker-engine-new ashucompose]$ docker-compose  ps
 Name      Command     State   Ports
------------------------------------
ashuc1   ping fb.com   Up           
```

### all clean up 

```
 docker-compose  down 
Stopping ashuc1 ... done
Removing ashuc1 ... done
Removing network ashucompose_default
```

### compose file with differnet

```
ashu@docker-engine-new ashucompose]$ docker-compose -f ashu.yaml up  -d
Creating network "ashucompose_default" with the default driver
Creating volume "ashucompose_ashudbvol1" with default driver
Pulling ashuapp2 (nginx:)...
Trying to pull repository docker.io/library/nginx ... 
latest: Pulling from docker.io/library/nginx
ae13dd578326: Pull complete
6c0ee9353e13: Pull complete
dca7733b187e: Pull complete
352e5a6cac26: Pull complete
9eaf108767c7: Pull complete
be0c016df0be: Pull complete
Digest: sha256:4ed64c2e0857ad21c38b98345ebb5edb01791a0a10b0e9e3d9ddde185cdbd31a
Status: Image is up to date for nginx:latest
Creating ashuc1   ... done
Creating ashuc22  ... done
Creating ashudbc1 ... done
[ashu@docker-engine-new ashucompose]$ docker-compose -f ashu.yaml  ps
  Name                Command               State          Ports        
------------------------------------------------------------------------
ashuc1     ping fb.com                      Up                          
ashuc22    /docker-entrypoint.sh ngin ...   Up      0.0.0.0:1144->80/tcp
ashudbc1   docker-entrypoint.sh mysqld      Up      3306/tcp, 33060/tcp 
```

### more compsoe examples 

[compose examples](https://github.com/redashu/docker-compose)

### portainer webui

```
docker  run -itd --name webui -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock --restart always portainer/portainer
```

