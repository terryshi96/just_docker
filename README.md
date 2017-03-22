## 旨在探索docker环境下的rails开发
开发本地环境要求:安装docker并修改docker镜像源
```
https://get.daocloud.io/boot2docker/osx-installer/
https://jxus37ad.mirror.aliyuncs.com
https://github.com/docker/compose/releases
```

- 通过Dockerfile构建rails环境,Dockerfile由运维编写
- redis采用容器的方式
- 数据库由于涉及到数据的共享没有在每个compose_project单独起一个postgresql而是采用外部连接的方式
- 配置采用环境变量的方式 以这种形式引用<%= ENV['xxx'] %>
- commit触发CI/CD,之后构建镜像,上传到镜像仓库,服务器端进行镜像的拉取更新(通过触发ansible分发服务器端的compose文件)
- 使用docker的服务最佳实践应该是作为一个微服务提供api服务,个人认为不适合巨石系统,这样的系统依赖多,构建复杂

```
alias drails='docker-compose run --rm app rails'
drails new . --force --database=postgresql --skip-bundle
drails db:migrate
```