## 中文文档
    http://www.nginx.cn/doc/
    
##     ngnix.conf
####     主配置段的指令(每个指令以分号结尾)
    正常运行配置
        1.user UserName[FROUPNAME];  运行worker进程用户和用户组
        
        2.pid /path/to/pid_file;指定pid文件 pid /var/run/ngnix/ngnix.pid
        
        3.worker_rlimit_nofile #; 指定打开最大文件句柄数
        
    性能优化配置
        1.worker_processes #;worker进程数 (CPU数减一)
        
        2.worker_cpu_affinity cpumask(cpu二进制掩码);将进程绑定在cpu上(提升缓存的命中率) 
        
        3.timer_resolution interval; 计时器解析度,降低此值,可减少gettimeofday()系统调用次数
        
        3.worker_priority number;指明worker进程的nice值(越小对应的运行优先级越高) 
            -20 -19
            100,139
       
    事件相关配置:
        1.accept_mutex {on |off }; master调度用户请求至worker进程时使用的负载均衡锁,on表示能让多个worker轮流的序列化的去响应
        
        2.lock_file ;锁文件路径
        
        3.use [epoll|rtsig|select|poll];指明使用事件模型:建议让Nginx自行选择
        
        4.worker_connections 10240;设置单个worker进程所能处理的最大并发连接数
        
    用于调试,定位问题
        1.daemon {on|off};
            是否已守护进程方式运行Nginx,调试off
            
            .....
            
            
##  Nginx作为web服务器使用的配置
    
    配置框架
        http{
            upstream{
                ...
            }
            
            server{#类似httpd中的一个<VirtualHost>
                location URL{
                    root "/path/to/somedir"
                    
                }
            }
        }
    
    配置指令:
        1.server{}
        定义一个虚拟主机:
            server{
                listen 8080;
                server_name www.huanxi.com;
                root "/vhosts/web1";
            }
        
        2.listen 
            指定监听端口
                listen address[:prot];
                listen port;
                
        3.server_name NAME [...];
            后可跟多个主机
            
        4.root path; 文档root路径
        
        5.location [=|~|~*|^~] uri{};
            功能:允许根据用户请求的uri来请求定义的各location
            
            =: 表示精确检查匹配,
            ~: 正则表达式模式匹配检查,区分大小写
            ~*: 正则,不区分大小写
            ^~: uri的前半部分匹配,不支持正则表达式
            匹配优先级:精确匹配(=),^~,~,~*,无符号
            location /{
                root "/vhosts/web1";
            }
            location /images/{
                root "/vhosts/images/";
            }
        
            location ~* \.php${
                fcgipass
            }
        
        6.alias path;
            用于location配置段,定义路径别名
            注意:root 表示路径为对应的location "/" URL ;
            
            alias 表示路径映射,即location制定后定义的URL是相对于alias所指明的路径而言
            
            location /images/{
                alias "/www/pictures";
            }
            
            .com/images/a.jpg --> /www/picuter/a.jpg
            
        7.index file
            默认主页面
             index index.php index.html
             
        8.error_page code 
            根据http的响应状态返回制定错误页
            
            error_page 404 /404_customed.html
        9. 基于IP的访问控制
            allow IP/Netmask
            deny IP/Network
            
        10.基于用户的访问控制
        
            basic,digest
            
                auth_basic
                auth_basic_user_file
                    账号创建
                        htpasswd -c -m /etc/nginx/.httpass
                        
        11.https服务
        
        生成私钥,生成证书签署请求,并获得证书
        
        server{
            listen 443 ssl;
            ....
        }
        
        12.防盗链
        location ~*\.(jpg|gif|jpeg|png){
            valid_referer none blocked www.huanxi.com 定义合法应用
            if($invalid_regerer){
                rewrite ~/ http://www.huanxi.com/403.html
            }
            
        }
    
    
    
##   fastcgi代理

    
    
    
    
    
    
    
    
    
    