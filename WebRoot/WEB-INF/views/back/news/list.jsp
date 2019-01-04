<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>新闻列表页</title>
    
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
 总记录数${pageBean.totalCount}&nbsp;
 当前页${pageBean.currentPage}&nbsp;
 每页显示记录数：${pageBean.pageSize }&nbsp;
 总页数${pageCount}&nbsp;
上一页${PrevPage}&nbsp;
下一页${NextPage}&nbsp;

    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">新闻列表</div>
		<div class="panel-body">
			<div class="btn-group" role="group" aria-label="...">
				<a type="button" class="btn btn-default edit" data-toggle="modal"
					data-remote='<%=basePath%>news/edit?nid=' > <span
					class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;新增</a>
				<button type="button" class="btn btn-default">
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>&nbsp;删除
				</button>
			</div>
		</div>

		<!-- Table -->
		<table class="table">
		<thead>
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
		</thead>
		<tbody>
			<c:forEach var="item" items="${model}" varStatus="go">
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
							<a type="button" class="btn btn-danger btn-sm remove"  
							data-remote='<%=basePath%>news/remove?nid=${item.nid}'>
								<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>&nbsp;删除
							</a>
							<button type="button" class="btn btn-success btn-sm show"
							data-remote='<%=basePath%>news/edit?nid=${item.nid}'>
								<span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>&nbsp;修改
							</button>
							<button type="button" class="btn btn-info btn-sm show"
							data-remote='<%=basePath%>news/show?nid=${item.nid}'>
								<span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>&nbsp;查看
							</button>
						</div>
					</td>
				</tr>
			</c:forEach>
			
			</tbody>				
		</table>
		
	</div><jsp:include page="../page.jsp"></jsp:include>
	
		<script type="text/javascript">

		//新增
		$(".edit").click(function(e) {
			//如果是a链接，阻止其跳转到url页面
			e.preventDefault();
			//获取url的值
			var url = $(this).data('remote') || $(this).attr('href');
			flush(url)

		})

		//删除
		$('.remove').click(function(e) {
			//如果是a链接，阻止其跳转到url页面
			e.preventDefault();
			//获取url的值
			var url =  $(this).data('remote') || $(this).attr('href');
			$.ajax({
				url : url,
				async : true,
				type : "get",
				contentType : "application/text,charset=utf-8",
				dataType : "text",
				data : {},
				success : function(data) {//alert(JSON.stringify(data));
				
				//局部刷新
				flush("<%=basePath%>back/news")
				},
				error : function() {
					//  alert("请求失败");
				}
			});
		})
		//查看 <%=basePath%>news/show
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
