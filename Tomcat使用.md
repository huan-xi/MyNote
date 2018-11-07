## tomcat的安装
    安装jdk(官网下载jdk的rpm包):
        rpm -ivh jdk-8u171-linux-x64.rpm
    安装tomcat
        解压至/usr/local
        tar xf apache-tomcat-9.0.8.tar.gz -C /usr/local/
    配置环境变量:
        vim /etc/profile.d/tomcat.sh
        ```
        export CATALINA_HOME=/usr/local/tomcat
        export PATH=$CATALINA_HOME/bin:$PATH
        ```
        执行脚本配置变量. /etc/profile.d/tomcat.sh
        启动tomcat: catalina.sh start
## tamcat目录结构:
    bin,lib,logs,webapps,work,tem
##  配置文件
    server.xml :主配置文件
    context.xml :每个webapp都可以有的专用配置文件,位于webapp应用的WEB_INf目录下,用于定义回话访问,jdbc等:conf/context.xml是为各webapp提供默认配置
    web.xml:每个webapp 部署之后才能被访问
    tomcat-user.xml:用户账号认证配置文件
    catalina.policy:当使用-security选项启动tomcat实例时会读取此配置文件实现其安全策略
    catalina.properties:java属性定义文件
    logging.properties:日志相关配置信息
    
## JAVA 文本组织结构
    webapp归档格式
        war :webapp
        jar :EJB的类
        rar :资源适配器
        
## tomcat自带应用
