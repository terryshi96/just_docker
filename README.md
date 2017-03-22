## 旨在探索docker环境下的rails开发
开发本地环境要求:安装docker并修改docker镜像源
```
https://get.daocloud.io/boot2docker/osx-installer/
https://jxus37ad.mirror.aliyuncs.com
https://github.com/docker/compose/releases
```


```
http://guides.rubyonrails.org/
alias drails='docker-compose run --rm app rails'
drails new . --force --database=postgresql --skip-bundle
drails db:migrate
```


- 通过Dockerfile构建rails环境
- redis采用容器的方式
- 数据库由于涉及到数据的共享没有在每个compose_project单独起一个postgresql而是采用外部连接的方式
- 配置采用环境变量的方式 以这种形式引用<%= ENV['xxx'] %>
- 使用docker的服务最佳实践应该是作为一个微服务提供api服务,个人认为不适合巨石系统,这样的系统依赖多,构建复杂


现在常见的利用 Docker 进行持续集成的流程如下：

- 开发者提交代码到(gitlab)
- 触发镜像构建 运行自动化测试脚本 构建镜像上传至私有仓库(jenkens)
- 分发任务到服务器,拉取最新的镜像 镜像运行(容器编排工具)