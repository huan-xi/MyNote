# SpringMVC的使用

## Springmvc处理流程

![](https://huanxi-image.oss-cn-beijing.aliyuncs.com/markdown/springmvc.png)

## SpringMVC的使用

1. 配置前端控制器


   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   	xmlns="http://java.sun.com/xml/ns/javaee"
   	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
   	id="WebApp_ID" version="2.5">
   	<display-name>springmvc-first</display-name>
   	<welcome-file-list>
   		<welcome-file>index.html</welcome-file>
   		<welcome-file>index.htm</welcome-file>
   		<welcome-file>index.jsp</welcome-file>
   		<welcome-file>default.html</welcome-file>
   		<welcome-file>default.htm</welcome-file>
   		<welcome-file>default.jsp</welcome-file>
   	</welcome-file-list>
   
   	<!-- 配置SpringMVC前端控制器 -->
   	<servlet>
   		<servlet-name>springmvc-first</servlet-name>
   		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
   		<!-- 指定SpringMVC配置文件 -->
   		<!-- SpringMVC的配置文件的默认路径是/WEB-INF/${servlet-name}-servlet.xml -->
   		<init-param>
   			<param-name>contextConfigLocation</param-name>
   			<param-value>classpath:springmvc.xml</param-value>
   		</init-param>
   	</servlet>
   
   	<servlet-mapping>
   		<servlet-name>springmvc-first</servlet-name>
   		<!-- 设置所有以action结尾的请求进入SpringMVC -->
   		<url-pattern>*.action</url-pattern>
   	</servlet-mapping>
   </web-app>
   
   ```

   2. 配置springMVC主配置文件springmvc.xml
   > ​	创建SpringMVC的核心配置文件SpringMVC本身就是Spring的子项目，对Spring兼容性很好，不需要做很多配置。这里只配置一个Controller扫描就可以了，让Spring对页面控制层Controller进行管理。
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <beans xmlns="http://www.springframework.org/schema/beans"
   	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
   	xmlns:context="http://www.springframework.org/schema/context"
   	xmlns:mvc="http://www.springframework.org/schema/mvc"
   	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
           http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-4.0.xsd
           http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.0.xsd">
   
   	<!-- 配置controller扫描包 -->
   	<context:component-scan base-package="cn.itcast.springmvc.controller" />
   
   </beans>
   
   ```

   