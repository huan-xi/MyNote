#!/bin/bash
# *********************************************************
# * Author        : huanxi
# * Email         : 1355473748@qq.com
# * Last modified : 2018-11-12 22:31
# * Filename      : openvpn.sh
# * Description   : centos7 openvpn安装脚本
# * *******************************************************
open_firewall(){
systemctl start firewalld.service
firewall-cmd --state
firewall-cmd --zone=public --list-all
firewall-cmd --add-service=openvpn --permanent
firewall-cmd --add-port=53/udp --permanent
firewall-cmd --add-source=10.8.0.0 --permanent
firewall-cmd --query-source=10.8.0.0 --permanent
firewall-cmd --add-masquerade --permanent
firewall-cmd --query-masquerade --permanent
firewall-cmd --reload
}
start_openvpn(){
systemctl start openvpn@server
    if [ `ss -unlp | grep :53 | wc -l` -ge 1 ]; then
	    echo "启动成功"
    else
	    echo "启动失败"
    fi
}
install_openvpn(){
echo "开始安装openVPN服务端"
rm -rf /etc/openvpn
mkdir /etc/openvpn
mkdir /etc/openvpn/client
yum install easy-rsa openssh-server lzo openssl openssl-devel openvpn NetworkManager-openvpn openvpn-auth-ldap -y
cp -R /usr/share/easy-rsa/ /etc/openvpn
#配置vars
cd /etc/openvpn/easy-rsa/3
wget https://raw.githubusercontent.com/huan-xi/mynote/master/config/vars
openvpn --genkey --secret /etc/openvpn/ta.key
./easyrsa init-pki 
./easyrsa gen-dh
echo "准备建立ca，请记住输入的ca密码"
./easyrsa  build-ca
echo "创建服务器证书，输入上面ca设置的密码"
./easyrsa build-server-full server nopass
wget -P /etc/openvpn https://raw.githubusercontent.com/huan-xi/mynote/master/config/server.conf
open_firewall #关闭openVPN 防火墙
#开启ipv4转发
echo "安装成功正在启动"
start_openvpn
}
gen_client(){
echo "正在获取IP..."
ip=`curl -s v4.ident.me`
echo -e "请输入客户端名字\c"
read name
echo -e "设置密码？(y/n)\c"
read ispasswd
cd /etc/openvpn/easy-rsa/3/
if [ "$ispasswd" = y ];then
		./easyrsa build-client-full ${name}
	else
		./easyrsa build-client-full ${name} nopass
fi
pki_path="/etc/openvpn/easy-rsa/3/pki"
ca=`cat ${pki_path}/ca.crt`
cert=`cat ${pki_path}/issued/${name}.crt`
key=`cat ${pki_path}/private/${name}.key`
ta=`cat /etc/openvpn/ta.key`
touch /etc/openvpn/client/${name}.ovpn
cat > /etc/openvpn/client/${name}.ovpn <<EOF
client
dev tun
proto udp
remote ${ip} 53
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-CBC
route-delay 2
verb 3
<ca>
${ca}
</ca>
<cert>
${cert}
</cert>
<key>
${key}
</key>
key-direction 1
<tls-auth>
${ta}
</tls-auth>
EOF
echo "用户生成成功，配置文件在/etc/openvpn/client/${name}.ovpn"
}
pwd_path=$(cd `dirname $0`; pwd)
echo "欢迎使用centos7安装脚本，请输入数字选择功能"
echo "1.安装"
echo "2.启动服务"
echo "3.生成客户端"
echo "4.开启防火墙"
echo "5.关闭服务"
echo "0.退出"
echo -e "请输入数字>>\c"
read flag
case $flag in
	1)
	install_openvpn
	;;
	2)
	start_openvpn
	;;
	3)
	gen_client
	;;
	4)
	open_firewall
	;;
	q|0)
	echo "欢迎再次使用,脚本已退出"
	exit 0
	;;
	*)
	echo "输入不正确请重新输入"
	;; 
esac
sh ${pwd_path}/openvpn.sh
