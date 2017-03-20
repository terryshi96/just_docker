## 旨在探索docker环境下的rails开发
开发本地环境要求:安装docker并修改docker镜像源
```
https://get.daocloud.io/boot2docker/osx-installer/
https://jxus37ad.mirror.aliyuncs.com
```

通过Dockerfile构建rails环境,Dockerfile由运维编写
redis采用容器的方式
数据库由于涉及到数据的共享没有在每个compose_project单独起一个postgresql而是采用外部连接的方式

由于要区分不同环境(这里不是指开发和生产环境,而是不同的生产环境),任需要采取environments的形式

基于docker的rails应用都应该是微服务的形式,提供模块api,所以不需要资产编译。

测试

```
docker-compose build
docker-compose run --rm web rails new . --api --force --database=postgresql --skip-bundle
docker-compose run --rm web rake db:migrate
```
添加别名
```
alias dc="docker-compose"
alias dcb="docker-compose build"
alias dcr="docker-compose run --rm"
```
```
#清理虚悬镜像
docker rmi -f $(docker images -q -f dangling=true)
#清理停止容器
docker rm $(docker ps -a -q)
```

问题
redis\postgresql\mysql也是容器部署? 如何做redis\postgresql\mysql的集群?