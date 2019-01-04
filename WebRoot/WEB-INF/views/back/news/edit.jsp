<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>新闻编辑</title>
<link href="<%=basePath%>static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script src="<%=basePath%>static/jquery.min.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript" src="<%=basePath%>static/js/upload.js"></script>

<link rel="stylesheet" href="<%=basePath%>static/summernote/summernote.css" type="text/css"></link>
<script type="text/javascript" src="<%=basePath%>static/summernote/summernote.js"></script>
<script type="text/javascript" src="<%=basePath%>static/summernote/lang/summernote-zh-CN.js"></script>
<link rel="stylesheet" href="<%=basePath%>static/bootstrap_datetimepicker/bootstrap-datetimepicker.min.css" type="text/css"></link>
<script type="text/javascript" src="<%=basePath%>static/bootstrap_datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/bootstrap_datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script></head>

<body>
	<div>
    <form class="form-horizontal required-validate" action="#" id="myForm" enctype="multipart/form-data" method="post" onsubmit="return iframeCallback(this, pageAjaxDone)">
    <div class="form-group">
        <label for="" class="col-md-2 control-label">新闻封面</label>
        <div class="col-md-8 tl th">
            <input type="file" name="image" class="projectfile"/>
            <p class="help-block">支持jpg、jpeg、png、gif格式，大小不超过2.0M</p>
        </div>
    </div>
	<div class="form-group">
        <label for="" class="col-md-2 control-label">新闻标题</label>
        <div class="col-md-8 tl th">
            <input type="hidden" id="nid" name="nid" value="${model.nid}"/>
            <input type="text" name="title" class="projectfile" value="${model.title}"/>
        </div>
    </div>
    <div class="form-group">
        <label for="" class="col-md-2 control-label">发布时间</label>
        <div class="col-md-8 tl th">
        <div class="input-append date" id="datetimepicker" data-date="${model.pubtimeStr}" data-date-format="yyyy-mm-dd hh:ii:ss">
    		<input class="span2" size="16" type="text" value="${model.pubtimeStr}" name="pubtime">
    		<span class="add-on"><i class="icon-remove"></i></span>
    		<span class="add-on"><i class="icon-th"></i></span>
		</div>         
        </div>
    </div>
	<div class="form-group">
        <label for="" class="col-md-2 control-label">新闻分类</label>
        <div class="col-md-2 tl th">
            <input type="hidden" id="cid" name="cid" id="cid" class="projectfile" value="${model.cid}"/>
            <select class="form-control projectfile" id="category">
            <c:forEach var="item" items="${categorys}">
            	<option value="${item.cid}">${item.cname}</option>
            </c:forEach>
  			</select>
        </div>
    </div>
    <div class="form-group">
        <label for="" class="col-md-2 control-label">所属状态</label>
        <div class="col-md-2 tl th">
            <input type="hidden" id="state" name="state" id="state" class="projectfile" value="${model.state}" />
            <select class="form-control projectfile" id="statenums">
            <c:forEach var="item" items="${statenums}">
            	<option value="${item.num}">${item.name}</option>
            </c:forEach>
  			</select>
        </div>
    </div>
      <div class="form-group">
        <label for="" class="col-md-2 control-label">新闻详情</label>
        <div class="col-md-8">
            <textarea class="summernote" name="info" id="summernote" 
            placeholder="请对项目进行具体的描写叙述。使很多其它的人了解你的" action="<%=basePath%>news/upload.do">
            ${model.info}
            </textarea>
        </div>
    </div>
    
    <div class="form-group">
    	<label for="" class="col-md-2 control-label"></label>
        <div class="col-md-8">
            <input type="button" class="projectfile" value="提交" onclick="formSubmit()"/>
        </div>
    </div>
    </form>
</div>

<script type="text/javascript">
/*页面初始化*/
var cid = "1"; //默认为1
var state = 1; //默认为1
if($("#nid").val() != ''){
	var cidval = $("#cid").val();
	var staval = $("#state").val();
 	$("#category option[value = '"+cidval+"']").attr("selected",true);
 	$("#statenums option[value = '"+staval+"']").attr("selected",true);
	
	
} else {
	$("#cid").val("1")
	$("#state").val(1)
}

	
    $("#category").change(function(){
    	cid = $('#category option:selected').val();
    	$("#cid").val(cid)
    });
    
    $("#statenums").change(function(){
    	state = $('#statenums option:selected').val();
    	$("#state").val(state)
    })

	$('#datetimepicker').datetimepicker('update');
    $('#summernote').each(function() {
        var $this = $(this);
        var placeholder = $this.attr("placeholder") || '';
        var url = $this.attr("action") || '';
        $this.summernote({
            lang : 'zh-CN',
            placeholder : placeholder,
            minHeight : 300,
            dialogsFade : true,// Add fade effect on dialogs
            dialogsInBody : true,// Dialogs can be placed in body, not in
            // summernote.
            disableDragAndDrop : false,// default false You can disable drag
            // and drop
            callbacks : {
                onImageUpload : function(files) {

                    var $files = $(files);
                    $files.each(function() {
                        var file = this;
                        var data = new FormData();
                        data.append("file", file);

                        $.ajax({
                            data : data,
                            type : "POST",
                            url : url,
                            cache : false,
                            contentType : false,
                            processData : false,
                            success : function(data) {
							var data = JSON.parse(data)
                            $('.summernote').summernote('editor.insertImage',data.imgUrl);
                               
                            },
                           
                        });
                    });
                }
            }
        });
    });
    
    
    function formSubmit(){ 
    	var data = $("#myForm").serialize();
    	//var markupStr = $('#summernote').summernote('code');
    //	console.log(markupStr)
    	 $.ajax({
          url: "<%=basePath%>news/submit",
          type: "POST",
          dataType: "json",
          data: data,
          async: false,
          success: function(data) { 
          	//局部刷新
          	flush("<%=basePath%>back/news")
          },
          error: function() {
            alert("error");
          }
        });
    }
    
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
