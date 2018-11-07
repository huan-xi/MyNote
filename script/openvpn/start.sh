#!/bin/bash
# *********************************************************
# * Author        : huanxi
# * Email         : 1355473748@qq.com
# * Last modified : 2018-11-06 22:38
# * Filename      : start.sh
# * Description   : 校园网破解（openvpn 跑53端口）
# * *******************************************************
docker pull kylemanna/openvpn
echo "请输入IP地址(默认为公网IP)" 
read ip
if [ -z "$ip" ]; then
	echo "正在获取IP..."
	ip=`curl -s v4.ident.me`
fi
#配置文件路径
echo "请输入配置文件路径（默认当前路径下的ovpn_data）"
read ovpn_data
if [ -z "$ovpn_data" ]; then
	ovpn_data=`pwd`/ovpn_data
fi
echo $ovpn_data
mkdir -p $ovpn_data
#生成配置文件
docker run -v ${ovpn_data}:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u tcp://${ip}
#修改端口
port=53
sed -i "s/1194/$port" /etc/openvpn/openvpn.conf
#初始化服务器
docker run -v ${ovpn_data}:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
#创建用户
docker run -v ${ovpn_data}:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass
#生成客户端配置文件
docker run -v ${ovpn_data}:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > ${ovpn_data}/CLIENTNAME.ovpn
echo "客户端配置文件生成成功${ovpn_data}/CLIENTNAME.ovpn(无密码)"
exit 0
#创建用户
docker run -v ${ovpn_data}:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass
echo $ip

