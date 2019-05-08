# docker build . -t android_flutter:1
FROM openjdk:8-jdk

WORKDIR /root

ENV PUB_HOSTED_URL https://pub.flutter-io.cn
ENV FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn
ENV PATH /root/android-sdk-linux/platform-tools:/root/flutter/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV ANDROID_COMPILE_SDK "28"
ENV ANDROID_BUILD_TOOLS "28.0.3"
ENV ANDROID_SDK_TOOLS  "4333796"
ENV ANDROID_HOME /root/android-sdk-linux
ENV ANDROID_SDK_ROOT /root/android-sdk-linux

RUN echo "deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >/etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian-security/ stretch/updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian-security/ stretch/updates main non-free contrib" >>/etc/apt/sources.list && \
    apt-get --quiet update --yes && \
    apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 lcov nodejs curl
   
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install nodejs -y && \
    npm set registry https://registry.npm.taobao.org && \
    npm install -g lcov-summary && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip && \
    unzip -d android-sdk-linux android-sdk.zip && \
    mkdir .android && touch .android/repositories.cfg && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null && \
    yes | android-sdk-linux/tools/bin/sdkmanager --licenses

RUN git clone -b stable https://github.com/flutter/flutter.git && flutter doctor

COPY init.gradle /root/.gradle/init.gradle
