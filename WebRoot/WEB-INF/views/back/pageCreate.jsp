<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'pageCreate.jsp' starting page</title>

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
	<h4>生成首页</h4>
	<!-- 按钮触发模态框 -->
	<button class="btn btn-primary btn-sm" data-toggle="modal"
		data-target="#myModal">生成首页</button>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">正在生成首页</h4>
				</div>
				<div class="modal-body">
					正在生成首页... ...

					<div class="progress">
						<div class="progress-bar progress-bar-striped active"
							role="progressbar" aria-valuenow="45" aria-valuemin="0"
							aria-valuemax="100" style="width: 100%">
							<span class="sr-only">45% Complete</span>
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<script>

	$('#myModal').on('hidden.bs.modal', function (e) {
  // do something...
	})
	$('#myModal').on('shown.bs.modal', function (e) {
  // do something...
  $.ajax({
				url : "<%=basePath%>pagecreate/create",
				async : true,
				type : "get",
				contentType : "application/text,charset=utf-8",
				dataType : "text",
				data : {},
				success : function(data) {//alert(JSON.stringify(data));
					$(".modal-body").each(function() {
						$(this).text('生成成功')
					});
				},
				error : function() {
					//  alert("请求失败");
				}
			});
		})
	</script>
</body>
</html>
