## 整合流程

 ### 1.配置AuthenticationEntryPoint

> ​	首先需要做的是将应用的登录认证入口改为使用CasAuthenticationEntryPoint。所以首先我们需要配置一个CasAuthenticationEntryPoint对应的bean，然后指定需要进行登录认证时使用该AuthenticationEntryPoint。配置CasAuthenticationEntryPoint时需要指定一个ServiceProperties，该对象主要用来描述service（Cas概念）相关的属性，主要是指定在Cas Server认证成功后将要跳转的地址。 

 ### 2.配置CasAuthenticationFilter

### 3.配置AuthenticationManager



