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