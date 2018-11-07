# 使用阿里云OSS+python搭建图床服务

## 简介

> ​	markdown作为纯文本编辑器，显示图片只能靠上传至服务器获取连接。而阿里云OSS提供50G做Markdown图床还是够了的。搭建好OSS 用python写个脚本就能轻松上传文件并获取到连接。

## 创建OSS容器

1. 注册阿里云并开通OSS服务[创建帮助](`https://help.aliyun.com/product/31815.html` )

2. 创建容器（Bucket）

   1. 输入Bucket名称
   2. 点击创建

   ​	 ![](https://huanxi-image.oss-cn-beijing.aliyuncs.com/markdown/20180809181017.png)

3. 创建好容器后可再创建一个Markdown目录用来存Markdown文件

   ​	 ![](https://huanxi-image.oss-cn-beijing.aliyuncs.com/markdown/20180809181824.png)

4. 获取AccessKey ID 和 Access Key Secret （用于python上传文件时的身份验证）

   > ​	鼠标放头像处点Access Key 即可创建。创建好后记录下来，OSS搭建就完成了，下面就是python脚本实现上传。（其他语言可参考SDK自己开发）

![](https://huanxi-image.oss-cn-beijing.aliyuncs.com/markdown/20180809182536.png)

![](https://huanxi-image.oss-cn-beijing.aliyuncs.com/markdown/20180809182631.png)

## Python脚本实现上传图片并获取连接

#### python代码

```python
# -*- coding: utf-8 -*-
import oss2
import time
import os
import sys
# 阿里云主账号AccessKey拥有所有API的访问权限，风险很高。强烈建议您创建并使用RAM账号进行API访问或日常运维，请登录 https://ram.console.aliyun.com 创建RAM账号。
auth = oss2.Auth('AccessKey ID', 'Access Key Secret')
# Endpoint以杭州为例，其它Region请按实际情况填写。
endpoint = 'http://oss-cn-beijing.aliyuncs.com'
# 设置连接超时时间设为30秒。
bucket = oss2.Bucket(auth, endpoint, 'Bucket名称', connect_timeout=30)

def percentage(consumed_bytes, total_bytes):
    if total_bytes:
        rate = int(100 * (float(consumed_bytes) / float(total_bytes)))
        print('\r{0}% '.format(rate), end='')
        sys.stdout.flush()
def uploadFiles(bucket,tmp_file):
    """ uploadFiles
    Upload FLAGS.files to the oss
    """
    start_time = time.time()
    if not os.path.exists(tmp_file):
        print("File {0} is not exists!".format(tmp_file))
    else:
        print("Will upload {0} to the oss!".format(tmp_file))
        tmp_time = time.time()
        # cut the file name
        filename = tmp_file[tmp_file.rfind("\\") + 1: len(tmp_file)]
        ossFilename = 'markdown/'+filename
        oss2.resumable_upload(
            bucket,
            ossFilename,
            tmp_file,
         progress_callback=percentage)
        print("URL:https://huanxi-image.oss-cn-beijing.aliyuncs.com/markdown/"+filename)

if __name__=='__main__':
    file_name=input("please input a image filename>>")
    uploadFiles(bucket,file_name)

```



##### 填写好AccessKey ID，Access Key Secret，Bucket名称，即可上传文件了

> ​	每次上传一个文件，函数功能都很简单若需其他需求，可自己去阿里云查看SDK文档。



#### 好了脚本写完了让我们看一下效果吧

![](https://huanxi-image.oss-cn-beijing.aliyuncs.com/markdown/20180809184152.png)

> ​	python main.py 后提示输入一个文件名
>
> ​	将文件脱至cmd下即可输入文件名
>
> ​	然后或得了外联URL地址 复制到Markdown即可