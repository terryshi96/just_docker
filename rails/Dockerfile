# ruby基础镜像
FROM ruby:2.6.0-preview3-alpine3.8

# 刷新deian源
# RUN echo "deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >/etc/apt/sources.list && \
#     echo "deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >>/etc/apt/sources.list && \
#     echo "deb http://mirrors.aliyun.com/debian-security/ stretch/updates main non-free contrib" >>/etc/apt/sources.list && \
#     echo "deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >>/etc/apt/sources.list && \
#     echo "deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >>/etc/apt/sources.list && \
#     echo "deb-src http://mirrors.aliyun.com/debian-security/ stretch/updates main non-free contrib" >>/etc/apt/sources.list

# 修改alpine源
RUN cp /etc/apk/repositories /etc/apk/repositories.bak && \
    echo "https://mirrors.aliyun.com/alpine/v3.8/main/" > /etc/apk/repositories

# 安装必要套件
#RUN apt-get update && apt-get install -y build-essential openssh-server git libpq-dev nodejs && rm -rf /var/lib/apt/lists/*
RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                nodejs \
                                tzdata \
                                openssh \
                                mysql-dev


#定义变量
ENV HOME /app

#添加gitlab身份验证文件
ADD id_rsa /root/.ssh/id_rsa

#创建目录
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime && \
    mkdir $HOME && \
    mkdir -p $HOME/tmp/pids && \
    chmod 0600 /root/.ssh/id_rsa && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

#设置工作目录
WORKDIR $HOME

#添加Gemfile
COPY Gemfile Gemfile
#COPY Gemfile.lock Gemfile.lock

#bundle
RUN bundle install

# Remove SSH keys
RUN rm -f /root/.ssh/id_rsa

#添加代码
ADD . $HOME

ENV RAILS_ENV production

# 编译资产
RUN bundle exec rake assets:precompile

CMD puma -C config/puma.rb