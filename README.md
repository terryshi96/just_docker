## 旨在探索docker环境下的rails开发
开发本地环境要求:安装docker并修改docker镜像源
```
https://get.daocloud.io/boot2docker/osx-installer/
https://jxus37ad.mirror.aliyuncs.com
```

通过Dockerfile构建rails环境,Dockerfile由运维编写
redis采用容器的方式,数据库由于涉及到数据的共享没有在每个compose_project单独起一个postgresql而是采用外部连接的方式


基于docker的rails应用都应该是微服务的形式,提供模块api,所以不需要资产编译。

测试

```
docker-compose run web rails new myapp -m https://raw.github.com/80percent/rails-template/master/composer.rb --force --database=postgresql --skip-bundle
```