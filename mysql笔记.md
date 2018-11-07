# mysql笔记:
## 1.安装
    OS vendor ：rpm
    MYSQL：
        rpm 
        展开可用
        源码
## 1. 将mysql的data目录独立分区
    1. 创建data分区
         ```
        fdisk /dev/sdb
        mkfs.ext4 /dev/sdb1
        mkdir -p /mydata/data #创建挂在目录
        chown -R mysql:mysql data
        mount /dev/sdb1 /mydata/data/ #挂载硬盘
        ls -l /dev/disk/by-uuid/ #查看硬盘UUID
        vim /etc/fstab #添加开机自动挂在
        ```
    2. 初始化数据目录
        ```
        /usr/bin/mysqld_safe --datadir='/mydata/data'
        ```
    3. 修改mysql配置文件/etc/my.cnf。将datadir和socket的路径改为/mydata/data目录下
        
        ```
        [mysqld]
        #datadir=/var/lib/mysql                      ------原系统默认路径
        datadir=/mydata/data     ------现有路径
        #socket=/var/lib/mysql/mysql.sock            ------原socket路径现
        socket=/mydata/data/mysql.sock                ------现有路径
        ```
    4. 修改php配置文件(/etc/php.ini)中的socket路径。没错，千万不要忘记了php.ini里也要指明socket的路径，否则php网站会无法连接到数据库的。php.ini里默认socket路径是空的，默认是指向/var/lib/mysql，所以也要改为/mydata/mysql.
        ```
        [mysql]
        mysql.default_socket = /mydata/data/mysql.sock
        [mysqli]
        mysql.default_socket = /mydata/data/mysql.sock
        ```
    6. 重启apache.mysql
    7. 修改客户端(否则客户端无法打开)
        ```
        vim /etc/my.cnf.d/client.cnf
        [client]  
        socket = /mydata/data/mysql.sock 
        ```
        或者将mysql.sock链接至默认路径中
## 2. mysql的安全初始化
    
    ```
    /usr/bin/mysql_secure_installation
    ```
    1.设置管理员密码
    
    2.删除所有匿名用户
    mysql>drop user ''@localhost
    
    上诉
    3.关闭主机名反解
    
## 3. 客户端
    - 登入 mysql  
        -u: 用户名默认root  
        -h: 服务器主机  
        -p: 密码默认为空
    - 命令:
        客户端命令:本地命令
            mysql>help
        服务端命令:通过mysql协议发往服务器并取得返回结果每个命令必须有命令结束符,默认为分号
    
## 4. SQL语句
    DDL: Data Defination Language
        create,drop,alter
    DML: Data Manipulation Language
        insert,delete,update,select
    DCL Data Control Language     
        grant,revoke
    注意:sql语句不区分大小写,一般采用大写
    数据库:
######  - 获取命令使用帮助:
            help 关键字
######  - 创建数据库:
            CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] db_name
            create_specification:
            [DEFAULT] CHARACTER(字符集) SET [=] charset_name
            | [DEFAULT] COLLATE(排序规则) [=] collation_name
            
            查看所支持的字符集:SHOW CHARACTER SET;
            查看所支持的排序规则:SHOW COLLATIONS;
            查看 SHOW DATABASES;
######  - 表:
            创建CREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name
                (col_name data_type 修饰符,...) --create_definition字段
                [table_options]
                [partition_options]
            
            查看　SHOW TABLES [FROM db_name]
            查看表结构 DESC [ab_name.]tb_name
            
            删除表:
            DROP TABLE [IF EXIST] tb_name
            
            查看变状态:
                SHOW TABLE STATUS LILE 'tb_name' \G --\G 是让数据竖排显示
                
            修改表:
                ALTER TABLE tb_name
                添加字段:add
                删除字段:drop
                修改字段:alter 
-     数据类型:
            字符型:
                    定长字符型: CHAR,BINART
                    变长字符型: VARCHAR() ,VARBINARY
    
                    对象存诸:
                        TEXT:不区分大小写
                        BLOB:区分大小写
            数值型:
                精准数值型:
                    整型:
                        tinyint
                        smallint
                        mediumint
                        int
                        bigint
                    十进制:decimal
                    
                近似数值型:
                    单精度浮点型
                        flaot
                    双精度浮点型:
                        double
                        
            修饰符:
                NOT NULL
                DEFAULT VALUE :设定默认值
            
######  - 示例:
            设置密码
            刷新
            flush privileges;
            2 #mysqladmin -uroot-h host -p password 'password'
            3修改表
            update user set password=password('fasd') where user=root and host=
            创建后表的修改
            alter table 语句用于创建后对表的修改, 基础用法如下:
            添加列
            基本形式: alter table 表名 add 列名 列数据类型 [after 插入位置];
            示例:
            在表的最后追加列 address: alter table students add address char(60);
            
            在名为 age 的列后插入列 birthday: alter table students add birthday date after age;
            修改列
            
            基本形式: alter table 表名 change 列名称 列新名称 新数据类型;
            
            示例:
            
            将表 tel 列改名为 telphone: alter table students change tel telphone char(13) default "-";
            
            将 name 列的数据类型改为 char(16): alter table students change name name char(16) not null;
            删除列
            
            基本形式: alter table 表名 drop 列名称;
            
            示例:
            
            删除 birthday 列: alter table students drop birthday;
            重命名表
            
            基本形式: alter table 表名 rename 新表名;
            
            示例:
            
            重命名 students 表为 workmates: alter table students rename workmates;
            删除整张表
            
            基本形式: drop table 表名;
            
            示例: 删除 workmates 表: drop table workmates;
            删除整个数据库
            
            基本形式: drop database 数据库名;
            
            示例: 删除 samp_db 数据库: drop database samp_db;