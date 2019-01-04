<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>MyBlogBack 登陆界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link href="<%=basePath%>static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script src="<%=basePath%>static/jquery.min.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap.min.js"></script>
<style>
 /*web background*/
 		body{
 		 background-image:url("<%=basePath%>static/images/login.jpg");
 		}
            .container{
                display:table;
                height:100%;
               
            }

            .row{
                display: table-cell;
                vertical-align: middle;
            }
            /* centered columns styles */
            .row-centered {
                text-align:center;
            }
            .col-centered {
                display:inline-block;
                float:none;
                text-align:left;
                margin-right:-4px;
            }

</style>
  </head>
  
  <body>
    	<div class="container">
            <div class="row row-centered">
                <div class="well col-md-4 col-centered">
                    <h2>欢迎登录</h2>
                    <form action="<%=basePath%>user/login" method="post" role="form">
                        <div class="input-group input-group-md">
                            <span class="input-group-addon" id="sizing-addon1"><i class="glyphicon glyphicon-user" aria-hidden="true"></i></span>
                            <input type="text" class="form-control" id="uname" name="uname" value="${uname}" placeholder="请输入用户ID"/>
                        </div>
                        <div class="input-group input-group-md">
                            <span class="input-group-addon" id="sizing-addon1"><i class="glyphicon glyphicon-lock"></i></span>
                            <input type="password" class="form-control" id="pwd" name="pwd" placeholder="请输入密码"/>
                        </div>
                        <br/>
                        <button type="submit" class="btn btn-success btn-block">登录</button>
                        <p>${msg}</p>
                    </form>
                </div>
            </div>
        </div>
  </body>
</html>
