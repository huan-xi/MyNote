

## armbian编译安装mentohust 认证锐捷客户端

> 在Linux arm版上编译mentohust认证锐捷客户端校园网并使用create_ap实现可热点用到文件下载地址



1. 编译mentohust

   > 1. 在编译mentohust之前需要先编译libpcap-1.0.0

   ```shell
   tar xvf libpcap-1.0.0.tar
   ./configure
   make && make install 
   ```



   ![](https://ws2.sinaimg.cn/large/006tNbRwgy1fx25dktsezj30ip0b3ta1.jpg)

   > 若出现以上错误
   >
   > >  configure: error: cannot guess build type; you must specify one
   >
   > 编译时带上build参数
   >
   > ```
   > ./configure --build=arm-linux
   > ```
   >
   > 编译成功后/usr/local/lib 会有libpcap.a文件
   >
   > ![](https://ws3.sinaimg.cn/large/006tNbRwgy1fx25hf4v7wj30h801iwel.jpg)

   2. 编译mentohust

      ```shell
      tar zxvf mentohust-0.3.1.tar.gz
      tar xvf mentohust-0.3.1.tar.gz
      cd mentohust
      ./configure --build=arm-linux --with-pcap=/usr/local/lib/libpcap.a #带上之前编译的libpcap
      make && make install
      ```

      > 编译mentohust完成
      >
      > menthoust -h 查看帮助

   3. 配置mentohust.conf

      > 在配置认证信息的的时候遇到几个坑

      1. mentohust配置 vim /etc/mentohust.conf

         执行完mentohust 之后会增加mentohust.conf 文件

         ![](https://ws4.sinaimg.cn/large/006tNbRwgy1fx25z9z63ij30kj0kfdkq.jpg)

      2. mac 地址绑定错误

         > 解决办法：修改mac地址 vim /etc/network/interface
         >
         > ![](https://ws4.sinaimg.cn/large/006tNbRwgy1fx25s1lv4tj30ei03e74j.jpg)

      3. 不允许该用户在该地区使用本服务

         > 解决办法：使用静态ip，并在mentohust.conf 配置静态ip认证
         >
         > 静态ip 配置如上图

      4. 不支持的客户端类型

         > 解决办法：拷贝认证信息文件/etc/mentost
         >
         > tar xvf menthust.tar
         >
         > cp -r menthust /etc



   4. 安装create_ap 

      > 附上GitHub地址[create_ap](https://github.com/oblique/create_ap.git)
      >
      > 安装好create_ap 所需支持库后直接make install 安装
      >
      > 尝试使用create_ap wlan0 eth0 MyAccessPoint MyPassPhrase开启热点，若设备不支持virt 启动时加上 --no-virt 参数
      >
      > 如果能开启热点再配置/etc/create_ap.conf 文件
      >
      > 然后 systemctl start create_ap 启动

   5. 开机自动认证

      systemctl enable create_ap #开机自动开热点

      vim /etc/rc.local + 再exit（0）之前加上 mentohust -b1 （后台运行mentohust）

   6. 断网和自动认证

      > 由于我们学校11点断网7点才有网所以使用定时任务自动认证

      ```shell
      systemctl status crond #查看crond 服务是否正常
      date #查看时间是否正确，如时间不正确多半是时区问题运行armbian-config 配置时区
      crontab -e 
      #添加 2 7 * * * mentohust -b1 每天7：02 自动认证
      #添加 2 11 * * * mentohust -k 每天11：02 自动结束
      crontab -l # 查看
      ```

   7. 利用53端口破解断网

      > 破解条件
      >
      >  	1. 有服务器（速度取决服务器带宽）
      >  	2. 53端口打开
      >  	3. 有两张WiFi网卡（一张连接一张创建ap）
      >
      > 学校Techer老师端WiFi是不断网的，而校园网53端口的dns服务是开的 查看校园网53端口是否打开（能否破解）ping www.baidu.com若能ping 出ip地址则可以破解。破解则是通过53端口使用openVPN连接服务器代理请求实现上网。
      >
      > 附上使用docker一键配置openVPN地址
      >
      > [docker部署openVPn脚本](https://raw.githubusercontent.com/huan-xi/mynote/master/script/openvpn/start.sh)
      >
      > 脚本好像还有点不完善以后再写一下使用文档
      >
      > 配置好后使用 openvpn cline.ovpn 即可破解了

      ​	