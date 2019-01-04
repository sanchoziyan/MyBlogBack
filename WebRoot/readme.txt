搭建我的个人博客网站，采用前后台分离
MyBlog--->前端系统
MyBlogBack--->后台系统
SSM框架  oracle数据库  redis内存数据库  template动态代码静态化  

步骤：
1.数据库设计sql--->blog.sql
2.引入lib包 spring相关jar / mybatis相关包  / json /jedis /oracle /commons相关jar
3.log4j配置文件AA---》控制台 ; BB--->tomcat/bin目录下对应文件log日志
4.spring整合springmvc---->
	web.xml配置：DispatcherServlet前端控制器
	
	spring-mvc.xml配置：
	context:component-scan自动扫描包路径文件下注解
	InternalResourceViewResolver视图解析器
	CommonsMultipartResolver配置文件上传--->form表单中添加属性：enctype="multipart/form-data" input type="file"
	创建control包路径--》编写controller类--》注解：@controller/@requestMapping
	运行tomcat 测试是否可用
5.spring整合mybatis
	jdbc.properties数据库连接配置信息
	spring-mybatis.xml 配置文件 1配置数据库连接2.配置sqlsessionfaction 3.DAO接口所在包名 4.tx事务管理
	web.xml配置：Spring和mybatis的配置文件
	
	创建用户，创建表
	使用mybaitis自动创建类及接口映射文件
	创建表  TAdmin TUser  TCategory TNews  THotNews TPlun
	测试数据库连接及操作表方法
整合完成

前端样式使用bootstrap js

6.图片服务器设置
Tomcat conf/Catalina/localhost下，如果没有需要手动创建文件夹
新建img.xml
在xml文件中配置<Context path="/img" reloadable="true" docBase="F:\img" />
path:浏览器访问目录，与xml文件名必须一至 ***
docBase:虚拟目录

在Tomcat的conf\web.xml文件中找到如下配置：
listings 修改为true
通过浏览器访问
http://ip:端口号/虚拟目录 ，如可以显示，虚拟目录配置成功
例如：http://127.0.0.1:8080/img	
	
	将图片服务器和web服务器分离开来
	创建一个系统配置信息SysConfig.xml
7.读取xml和properties 配置文件的工具类的编写
8.配置tomcat 热部署 和get请求出现的中文乱码的解决办法
	热部署：
	get请求的中文乱码：
9.模板生成页面
	使用io流
	
10.Spring AOP自定义注解实现权限控制