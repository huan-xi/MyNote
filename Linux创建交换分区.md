# Linux 创建内存交换分区

> swap通常配置如下(看你实际业务需求调整)：
>
> 4G以内的物理内存，SWAP 设置为内存的2倍。
> 4-8G的物理内存，SWAP 等于内存大小。
> 8-64G 的物理内存，SWAP 设置为8G。
>
> 64-256G物理内存，SWAP 设置为16G。



1. 分区磁盘

   创建4G 分区作为交换分区

   ![](https://ws4.sinaimg.cn/large/006tNbRwgy1fwzs7krq3pj30fv09vq48.jpg)

2. 更换类型为Linux swap 并输入w保存

   ![](https://ws4.sinaimg.cn/large/006tNbRwgy1fwzsenr06jj30fo07pmy7.jpg)

3. 再下一步使用 `mkswap` 命令来格式化交换分区

   ```shell
   mkswap /dev/sda3
   swapon /dev/sda3 #激活分区
   ```

4. 编辑/etc/fstab 开机自动挂载

   ```shell
   vim /etc/fsta
   /dev/sda3 swap  swap  default  0  0
   ```

5. 

