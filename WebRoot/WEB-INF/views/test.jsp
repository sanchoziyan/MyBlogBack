<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    This is my lala  test ----page. <br>
    	
    <img src="./static/images/5893e4fb981ce.jpg" style="width:300px;" /><br>
    <form action="<%=basePath%>lala/uploadPosdetailFile" method="post" enctype="multipart/form-data">
    <div class="form" >
            <p>	<label>uname: </label>	
                <input name="uname" type="text" />
            </p>
            
            <p>	<label>upwd: </label>
                <input name="upwd" type="text" />
            </p>
            <p>	<label>Upload file:</label>
                <input type="file"  name="uploadFileCtrl"  />
                
            </p>
            
    </div>
    
    <div class="buttons">
        <input id="queryBtn" type="Submit" class="button" value="Submit" />
    </div>
    
    </form>
  </body>
</html>
