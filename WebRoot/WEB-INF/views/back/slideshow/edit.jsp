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

<title>My JSP 'edit.jsp' starting page</title>

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
	<!-- 模态框（Modal） -->
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="myModalLabel">添加轮播图</h4>
	</div>
	<form id="tf" action="<%=basePath%>slideshow/uploadImg" method="post" class="form-horizontal"
		enctype="multipart/form-data">
			<div class="modal-body">
				<div class="form-group">
    				<label for="inputEmail3" class="col-sm-2 control-label">图片描述</label>
    				<div class="col-sm-10">
      					<input type="text" name="description" class="form-control" placeholder="description">
    				</div>
  				</div>
				<div class="form-group">
    				<label for="inputEmail3" class="col-sm-2 control-label">图片所属</label>
    				<div class="col-sm-10">
      					<input type="text" name="state" class="form-control" placeholder="state">
    				</div>
  				</div>
				<div class="form-group">
    				<label for="inputEmail3" class="col-sm-2 control-label">图片序号</label>
    				<div class="col-sm-10">
      					<input type="text" name="num" class="form-control" placeholder="num">
    				</div>
  				</div>
				 <div class="form-group">
    				<label for="exampleInputFile" class="col-sm-2 control-label">上传文件</label>
    				<input type="file" id="exampleInputFile" name="image" onchange="previewImage(this,'imgPreviewId')"> 
    				<p class="help-block ">Example block-level help text here.</p>
  				</div>
				
				上传图片显示<br> <div style="width:120px;height:120px;border:1px solid #ccc;">
				<img alt="" src="" name="srcImage" id="imgPreviewId"
				width="120px;" height="120px;"></div> 

			</div>
			
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			<button type="button" id="mybutton" class="btn btn-primary">提交更改</button>
		</div>
	</form>
	

</div>

<script type="text/javascript">
	$('#mybutton').click(function(e) {
		var form = new FormData(document.getElementById("tf"));
	
	$.ajax({
                url:"<%=basePath%>slideshow/uploadImg",
                type:"post",
                data:form,
                processData:false,
                contentType:false,
                success:function(data){
                //关闭模态框
                $('#myModal').modal('hide')
                },
                error:function(e){
                    alert("错误！！");
                   
                }
            });      
     });  
     
     
     
</script>
	
</body>
</html>
