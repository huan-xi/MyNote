Zsh 插件

- ```
  wd
  ```

  - 简单地讲就是给指定目录映射一个全局的名字，以后方便直接跳转到这个目录，比如：
  - 编辑配置文件，添加上 wd 的名字：`vim /root/.zshrc`
  - 我常去目录：/opt/setups，每次进入该目录下都需要这样：`cd /opt/setups`
  - 现在用 wd 给他映射一个快捷方式：`cd /opt/setups ; wd add setups`
  - 以后我在任何目录下只要运行：`wd setups` 就自动跑到 /opt/setups 目录下了
  - 插件官网：<https://github.com/mfaerevaag/wd>

- ```
  autojump
  ```

  - 这个插件会记录你常去的那些目录，然后做一下权重记录，你可以用这个命令看到你的习惯：`j --stat`，如果这个里面有你的记录，那你就只要敲最后一个文件夹名字即可进入，比如我个人习惯的 program：`j  program`，就可以直接到：`/usr/program`
  - 插件官网：<https://github.com/wting/autojump>
  - 官网插件下载地址：<https://github.com/wting/autojump/downloads>
  - 插件下载：`wget https://github.com/downloads/wting/autojump/autojump_v21.1.2.tar.gz`
  - 解压：`tar zxvf autojump_v21.1.2.tar.gz`
  - 进入解压后目录并安装：`cd autojump_v21.1.2/ ; ./install.sh`
  - 再执行下这个：`source /etc/profile.d/autojump.sh`
  - 编辑配置文件，添加上 autojump 的名字：`vim /root/.zshrc`

- ```
  zsh-syntax-highlighting
  ```

  - 这个插件会对终端命令高亮显示,比如正确的拼写会是绿色标识,否则是红色,另外对于一些shell输出语句也会有高亮显示,算是不错的辅助插件
  - 插件官网：<https://github.com/zsh-users/zsh-syntax-highlighting>
  - 安装，复制该命令：'git clone <https://github.com/zsh-users/zsh-syntax-highlighting.git> ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'
  - 编辑：`vim ~/.zshrc`，找到这一行，后括号里面的后面添加：`plugins=(  前面的一些插件名称 zsh-syntax-highlighting)`
  - 刷新下配置：`source ~/.zshrc`