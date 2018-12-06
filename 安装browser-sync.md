## 安装cnpm

```
npm install -g cnpm --registry=http://registry.npm.taobao.org
```

```shell
npm init -y
```

### 安装`browser-sync`

```shell
npm i --save-dev browser-sync

#注意，这里是--save-dev，因为其只是开发工具
```

打开项目中的`package.json`，在其中的`scripts`项中添加字段如下。

```json
"dev":"browser-sync start --server --files \"*.html, css/*.css ,js/*.js\""
```