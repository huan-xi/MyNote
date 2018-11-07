# 搭建openvpn服务

## 安装软件并添加用户

```shell
yum install epel-release lsb_release -y
yum install  openssl openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig makecache -y
yum install -y openvpn yum install -y easy-rsa
#添加启动openvpn的用户
groupadd openvpn useradd -g openvpn -M -s /sbin/nologin openvpn

```



## 创建证书

> ​	vim /etc/openvpn/easy-rsa/3.0/vars  修改第45、65、76、84-89、97、105、113、117、134、139、171、180、192行： 

```shell
cp -R /usr/share/easy-rsa/ /etc/openvpn/
cp -r /usr/share/doc/easy-rsa-3.0.3/vars.example /etc/openvpn/easy-rsa/3.0/vars
```

