# git的简单使用

> ​	学习简单使用git。

## git之前版本控制工具

	### 1. cvs

### 2. SVN

## git命令

####	  查看Git版本	git --version

#### 设置用户信

> ​	git config --global user.name
>
> ​	git config --global user.email

#### 命令别名

> ​	git config --global alias.st status
>
> ​	git config --global alias.ci commit

#### 创建版本库

> ​	git init	会创建一个.git 文件夹	

#### git暂存区

> #### git大概分三个区
>
> 1. 工作区间
>
> 2. 暂存区
>
>    > ​	git add 将文件从工作区提交至暂存区
>    >
>    > ​	git commit 将暂存区提交至仓库
>
> 3. 仓库 
>
> **git diff 命令**
>
> 	 > git diff 比较工作区与暂存区
> 	 >
> 	 > git diff HEAD （版本库头指针）：
> 	 >
> 	 > 	将工作区与HEAD（当前工作分支）相比
> 	 >
> 	 > git diff --cached 暂存区与仓库比

#### 查看提交日志 	git log