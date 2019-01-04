<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
	<title>MyBlog主页面</title>
	
    <link href="<%=basePath%>/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>/static/jquery.min.js"></script>
    <script src="<%=basePath%>/static/bootstrap/js/bootstrap.min.js"></script>
	<style>
  /* Make the image fully responsive */
  .carousel-inner img {
      width: 100%;
      height: 100%;
  }
  .slideshow{
  	 width: 200px;
     height:200px;
  }
  </style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	
	<div id="myCarousel" class="carousel slide">
	<!-- 轮播（Carousel）指标 -->
	<ol class="carousel-indicators">
	<c:forEach var="item"  items="${model}" varStatus="go">
	<c:if test="${go.count==1}">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	</c:if>
	<c:if test="${go.count!=1}">
		<li data-target="#myCarousel" data-slide-to="${go.count}"></li>
	</c:if>
		
	</c:forEach>
	</ol>   
	<!-- 轮播（Carousel）项目 -->
	<div class="carousel-inner">
		<c:forEach var="i" items="${model}" varStatus="go">
		<c:if test="${go.count==1}">
			<div class="item active">
			<img src="${i.imgurl}" alt="${i.description}" >
			</div>
		</c:if>
		<c:if test="${go.count!=1}">
			<div class="item">
			<img src="${i.imgurl}" alt="${i.description}" >
			</div>
		</c:if>
			
		</c:forEach>
		
	</div>
	<!-- 轮播（Carousel）导航 -->
	<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
		<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		<span class="sr-only">Previous</span>
	</a>
	<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
		<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		<span class="sr-only">Next</span>
	</a>
	
	</div>
	<br />
	
	<div class="container" id="loadPage">
		<div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">新闻列表</div>
		<div class="panel-body">
			
		</div>

		<!-- Table -->
		<table class="table">
			<tr class="success">
				<td><input type="checkbox" />
				</td>
				<td>序号</td>
				<td>分类</td>
				<td>标题</td>
				<td>发布时间</td>
				<td>状态</td>
				<td>操作</td>
			</tr>
			<c:forEach var="item" items="${model1}" varStatus="go">
				<tr>
					<td><input type="checkbox" />
					</td>
					<td>${go.count}</td>
					<td>${item.category.cname}
					</td>
					<td>${item.title}</td>
					<td><fmt:formatDate value="${item.pubtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>${item.stateEnum.name}</td>
					<td>
						<div class="btn-group" role="group" aria-label="...">
							
							<button type="button" class="btn btn-info btn-sm show"
							data-remote='<%=basePath%>news/show?nid=${item.nid}'>
								<span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>&nbsp;查看
							</button>
						</div>
					</td>
				</tr>
			</c:forEach>

		</table>
	</div>
	
	</div>
 
<script type="text/javascript">
$('.show').click(function(e) {
			//如果是a链接，阻止其跳转到url页面
			e.preventDefault();
			//获取url的值
			var url =  $(this).data('remote') || $(this).attr('href');
			flush(url)
		})
		
		//局部刷新
		function flush(url){
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