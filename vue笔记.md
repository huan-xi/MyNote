## 多页面配置

1. 多入口配置

   在entry中配置入口js

   ```javascript
     entry: {
       app: './src/pages/index/main.js',
       home:'./src/pages/home/main.js',
       admin:'./src/pages/admin/main.js',
     },
   ```

2. webpack.dev.conf 插件配置

   新建HtmlWwebpackPlugin

   ```javascript
    new HtmlWebpackPlugin({
         filename: 'admin.html',
         template: './src/pages/admin/admin.html',
         inject: true,
         chunks: ['admin']
       }),
   ```

3. 路径配置

   在config/index.js中的build中加入

   ​	admin: path.resolve(__dirname, '../dist/admin.html'),

4. webpack.prod.conf 插件配置

   ```javascript
       new HtmlWebpackPlugin({
         filename: process.env.NODE_ENV === 'testing'
           ? 'admin.html'
           : config.build.home,
         template: './src/pages/admin/admin.html',
         inject: true,
         minify: {
           removeComments: true,
           collapseWhitespace: true,
           removeAttributeQuotes: true
           // more options:
           // https://github.com/kangax/html-minifier#options-quick-reference
         },
   ```


## 引入bootstrap

- 安装jQuery

   1. npm install font-awesome --save

   2. 在webpack.base.conf.js中添加

     ```javascript
      var webpack = require('webpack')
      plugins: [
         new webpack.ProvidePlugin({
           $: "jquery",
           jQuery: "jquery"
         })
       ],
     ```

- 安装bootstrap 

  ```npm
  npm install bootstrap@3 --save
  ```

- 安装font-awesome

  ​	npm install font-awesome --save

- 导入

```javascript
    import 'bootstrap/dist/css/bootstrap.min.css'
    import 'bootstrap/dist/js/bootstrap.min'
    import 'font-awesome/css/font-awesome.css'
```

