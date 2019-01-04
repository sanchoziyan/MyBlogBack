<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>轮播图管理</title>

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
	<div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">轮播图管理</div>
		<div class="panel-body">
			<div class="btn-group" role="group" aria-label="...">
				<a type="button" class="btn btn-default edit" data-toggle="modal"
					data-remote='<%=basePath%>slideshow/edit'> <span
					class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;新增</a>
				<button type="button" class="btn btn-default">
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>&nbsp;删除
				</button>
			</div>
		</div>

		<!-- Table -->
		<table class="table">
			<tr class="success">
				<td><input type="checkbox" />
				</td>
				<td>序号</td>
				<td>图片</td>
				<td>名称</td>
				<td>所属</td>
				<td>地址</td>
				<td>操作</td>
			</tr>
			<c:forEach var="item" items="${model}" varStatus="go">
				<tr>
					<td><input type="checkbox" />
					</td>
					<td>${go.count}</td>
					<td><img src="${item.imgurl}"
						style="width:50px;height:50px" />
					</td>
					<td>${item.name}</td>
					<td>${item.state}</td>
					<td>${item.imgurl}</td>
					<td>
						<div class="btn-group" role="group" aria-label="...">
							<a type="button" class="btn btn-danger btn-sm remove"  
							data-remote='<%=basePath%>slideshow/remove?uuid=${item.uuid}'>
								<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>&nbsp;删除
							</a>
							<button type="button" class="btn btn-info btn-sm ">
								<span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>&nbsp;查看
							</button>
						</div>
					</td>
				</tr>
			</c:forEach>

		</table>
	</div>

	<!-- 模态框内容 -->
	<div class="modal fade" style="top:13%;" tabindex="-1" role="dialog"
		id="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<!-- 内容会加载到这里 -->
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<script type="text/javascript">
		//监听模态框关闭事件, 清除数据，保证每次打开都是新数据
		$("#myModal").on("hidden.bs.modal", function() {
		
			$(this).removeData("bs.modal");
			$(this).find(".modal-content").children().remove();
			//局部刷新
			flush("<%=basePath%>back/slideshow")
		})

		//新增
		$(".edit").click(function(e) {
			//如果是a链接，阻止其跳转到url页面
			e.preventDefault();
			//获取url的值
			var url = $(this).data('remote') || $(this).attr('href');
			//将id为myModal的页面元素作为模态框激活
			$('#myModal').modal({

				backdrop : 'static', // 点击空白不关闭
				keyboard : false, // 按键盘esc也不会关闭
				remote : url
			// 从远程加载内容的地址
			});

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
				flush("<%=basePath%>back/slideshow")
				},
				error : function() {
					//  alert("请求失败");
				}
			});
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
