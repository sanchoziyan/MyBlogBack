<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>后台管理系统</title>
<link href="<%=basePath%>static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script src="<%=basePath%>static/jquery.min.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript" src="<%=basePath%>static/js/upload.js"></script>
<link rel="stylesheet"
	href="<%=basePath%>static/bootstrap_table/bootstrap-table.min.css"
	type="text/css"></link>
<script type="text/javascript"
	src="<%=basePath%>static/bootstrap_table/bootstrap-table.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>static/bootstrap_table/bootstrap-table-zh-CN.min.js"></script>

<style>
.panel-group {
	max-height: 770px;
	overflow: auto;
}

.leftMenu {
	margin: 10px;
	margin-top: 5px;
}

.leftMenu .panel-heading {
	font-size: 14px;
	padding-left: 20px;
	height: 36px;
	line-height: 36px;
	/* color: white; */
	position: relative;
	cursor: pointer;
} /*转成手形图标*/
.leftMenu .panel-heading span {
	position: absolute;
	right: 10px;
	top: 12px;
}

.leftMenu .menu-item-left {
	padding: 2px;
	background: transparent;
	border: 1px solid transparent;
	border-radius: 6px;
}

.leftMenu .menu-item-left:hover {
	background: #C4E3F3;
	border: 1px solid #1E90FF;
}
</style>
</head>
<body>

	<jsp:include page="header.jsp" flush="true" />
	<div class="container-fluid">
		<div class="row">

			<div class="col-md-2">
				<div class="panel-group table-responsive" role="tablist">
					<div class="panel panel-success leftMenu">
					<c:forEach items="${map}" var="item" varStatus="go">
						<div class="panel-heading " id="collapseListGroupHeading${go.count}"
							data-toggle="collapse" data-target="#collapseListGroup${go.count}"
							role="tab">
							<h4 class="panel-title ">
								<i class="glyphicon glyphicon-picture"></i>&nbsp;${item.key} <span
									class="glyphicon glyphicon-chevron-down right"></span>
							</h4>
						</div><!-- class="panel-collapse collapse in" 打开状态 -->
						
						<div id="collapseListGroup${go.count}" class="panel-collapse collapse in"
							role="tabpanel" aria-labelledby="collapseListGroupHeading${go.count}">
							<ul class="list-group">
								<c:forEach items="${item.value}" var="i">
								<li class="list-group-item">
									<!-- 利用data-target指定URL -->
									<button class="menu-item-left" data-target="test2.html"
										onclick="loadPage('<%=basePath%>${i.rurl}')">
										<span class="glyphicon glyphicon-triangle-right"></span> ${i.rname}
									</button>
								</li>
							</c:forEach>
							</ul>
						</div>
						
					</c:forEach>
					</div><!--panel end-->
					
				</div>
			</div>
			<div class="col-md-10">
				<div id="loadPage">
					<jsp:include page="echarts.jsp"></jsp:include>
					<div>
						<div class="panel panel-default">
							<!-- Default panel contents -->
							<div class="panel-heading">新闻列表</div>
							<div class="panel-body">
								<div class="btn-group" role="group" aria-label="...">
									<a type="button" class="btn btn-default edit" 
										data-toggle="modal" data-remote='<%=basePath%>news/edit?nid='>
										<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;新增</a>
									<button type="button" class="btn btn-default">
										<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>&nbsp;删除
									</button>
								</div>
							</div>
							<table id="table"></table>
						</div> 
						
						
					</div>
				</div>
			</div>
		</div>
		<script>
			
				$(".panel-heading").click(function(e) {
					/*切换折叠指示图标*/
					$(this).find("span").toggleClass("glyphicon-chevron-down");
					$(this).find("span").toggleClass("glyphicon-chevron-up");
				});
				
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

	$(function(){
		//1.初始化Table
		var oTable = new TableInit();
		oTable.Init();
	});	
		
	var TableInit = function () {
    var oTableInit = new Object();
    //初始化Table
    oTableInit.Init = function () {
    	$("#table").bootstrapTable('destroy');  //避免重复执行，需要销毁
    	$('#table').bootstrapTable({
				url : '<%=basePath%>news/list',
				method: 'get',
				toolbar: '#toolbar',                //工具按钮用哪个容器
				striped: true,                      //是否显示行间隔色
				undefinedText: "空",//当数据为 undefined 时显示的字符
				cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination: true,                   //是否显示分页（*）
				sortable: true,                     //是否启用排序
				sortName:"pubtime",
				sortOrder: "asc",                   //排序方式 asc desc
				queryParams: oTableInit.queryParams,//传递参数（*）
				sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
				pageNumber:1,                       //初始化加载第一页，默认第一页
				pageSize: 4,                       //每页的记录行数（*）
				pageList: [5,10,20,40],        //可供选择的每页的行数（*）
				search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				strictSearch: true,
				showColumns: true,                  //是否显示所有的列
				showRefresh: true,                  //是否显示刷新按钮
				minimumCountColumns: 2,             //最少允许的列数
				clickToSelect: true,                //是否启用点击选中行
				//height: 200,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				data_local: "zh-US",//表格汉化
				uniqueId: "nid",                     //每一行的唯一标识，一般为主键列
				showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
				cardView: false,                    //是否显示详细视图
				detailView: false,                   //是否显示父子表onEditableSave
				rowStyle: function (row, index) { //设置行的特殊样式
					//这里有5个取值颜色['active', 'success', 'info', 'warning', 'danger'];
					var colors = ['active', 'success', 'info', 'warning', 'danger'];
					 var strclass = "";
					 	if(index%2==0){
					 		strclass = colors[1]
					 	} 
					 return { classes: strclass }
				},
				columns : [{
					checkbox: true,
             }, {
					field : 'nid',
					title : 'Item ID',
					sortable: true,
				}, {
					field : 'title',
					title : 'Item title',
					sortable: true,
				}, {
					field : 'pubtimeStr',
					title : 'Item pubtime',
					sortable: true,
					//——修改——获取日期列的值进行转换
                	/* formatter: function (value, row, index) {
                    	return changeDateFormat(value)
                	} */
				}, {
					field : "nid",
					title : "操作",
					align : "center",
					//events: operateEvents,
					formatter:operateFomatter
				}],
				onLoadSuccess: function () {},
				onLoadError: function () {},
				onDblClickRow: function (row, $element) {},
				onEditableSave:function(field,row,oldValue,$el){
					$.ajax({
						type:"post",
						url:"/edit",
						data:{strJson : JSON.stringify(row)},
						success:function(data,status){
							if(status == "success"){
								alert("编辑成功")
							}
						},
						error:function(){
							alert("Error")
						},
						complete:function(){
						}
					});
				}
			});
			
    
    	};
    	function operateFomatter(value, row, index){
    		var id = value;
             var result = "";
             result += "<a href='javascript:;' class='btn btn-xs green' onclick=\"EditViewById('<%=basePath%>news/show?nid='+'" + id + "')\" title='查看'><span class='glyphicon glyphicon-search'></span></a>";
             result += "<a href='javascript:;' class='btn btn-xs blue edit' onclick=\"EditViewById('<%=basePath%>news/edit?nid='+'" + id + "')\" title='编辑'><span class='glyphicon glyphicon-pencil'></span></a>";
             result += "<a href='javascript:;' class='btn btn-xs red' onclick=\"DeleteByIds('<%=basePath%>news/remove?nid='+'" + id + "')\" title='删除'><span class='glyphicon glyphicon-remove'></span></a>";
 
             return result;
    	}
    	
    	oTableInit.queryParams = function (params) { console.log(params)
				var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
					limit: params.limit,   //页面大小
					offset: params.offset,  //页码
					search:params.search
				}
				return temp;
			};
			
		//修改——转换日期格式(时间戳转换为datetime格式)
        	function changeDateFormat(cellval) {
        		return "lsjfljsd";
        	};	
    	return oTableInit;
    }			
    //新增
		$(".edit").click(function(e) {
			//如果是a链接，阻止其跳转到url页面
			e.preventDefault();
			//获取url的值
			var url = $(this).data('remote') || $(this).attr('href');
			loadPage(url)

		});	
		function EditViewById(url){
			loadPage(url)
    	}	
		function DeleteByIds(url){
		$.ajax({
				url : url,
				async : true,
				type : "get",
				contentType : "application/text,charset=utf-8",
				dataType : "text",
				data : {},
				success : function(data) {//alert(JSON.stringify(data));
				
				//局部刷新
				loadPage("<%=basePath%>back/index")
					},
					error : function() {
						//  alert("请求失败");
					}
				});
			}
		</script>
</body>
</html>