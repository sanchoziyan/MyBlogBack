<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'page.jsp' starting page</title>
    
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
   


  <nav aria-label="Page navigation" >
  <ul class="pagination">
    <li>
      <a href="javascript:;" aria-label="Previous"
      onclick="loadPage('<%=basePath%>back/news?currentPage=${PrevPage}')">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <c:forEach begin="1" end="${pageCount}" var="i">
    <li><a href="javascript:;" onclick="loadPage('<%=basePath%>back/news?currentPage=${i}')">${i}</a></li>
     </c:forEach>
    <li>
      <a href="javascript:;" aria-label="Next" onclick="loadPage('<%=basePath%>back/news?currentPage=${NextPage}')">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
    
    <script type="text/javascript">
    function loadPage(url) {
				$('#loadPage').html("");
				$.ajax({
					type : "POST",
					url : url,
					data : {},
					dataType : "html", //返回值类型       使用json的话也可以，但是需要在JS中编写迭代的html代码，如果格式样式
					cache : false,
					success : function(data) {
						//var json = eval('('+msg+')');//拼接的json串
						$('#loadPage').empty().html(data);
					},
					error : function(error) {
						alert(error);
					}
				});
			}
    </script>
  </body>
</html>
