# Linux源码安装JDK

## 下载源码包

 1. 下载源码包

 2. 解压，移动到安装目录

     1. 解压 tar -zxvf jdk1.8.0_131.tar.gz

        > 如果报错，则
        >
        > 先gzip -d jdk1.8.0_131.tar.gz
        >
        > 再tar -xvf jdk1.8.0_131.tar



## 环境变量配置

```shell
vim /etc/profile
export JAVA_HOME=/usr/local/jdk
export JRE_HOME=/usr/local/jdk/jre
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
```

再source /etc/profile 使配置文件生效