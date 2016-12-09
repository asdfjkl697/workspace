<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <title>用户登录</title> -->
<title>Apache Tomcat WebSocket Examples: Echo</title>
<style type="text/css">
#Container {
	/* width: 1200px; */
	margin: 0 auto; /*设置整个容器在浏览器中水平居中*/
	background: #CF3;
}

#Header {
	height: 120px;
	/* background: #093; */
}

#logo {
	padding-left: 50px;
	padding-top: 20px;
	padding-bottom: 50px;
}

#Content {
	height: 540px;
	/*此处对容器设置了高度，一般不建议对容器设置高度，一般使用overflow:auto;属性设置容器根据内容自适应高度，如果不指定高度或不设置自适应高度，容器将默认为1个字符高度，容器下方的布局元素（footer）设置margin-top:属性将无效*/
	margin-top: 20px; /*此处讲解margin的用法，设置content与上面header元素之间的距离*/
	background: #0FF;
}

#Content-Left {
	height: 500px;
	width: 350px;
	margin: 20px; /*设置元素跟其他元素的距离为20像素*/
	float: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/
	/* background: #cc0; */
}

#Content-Main {
	height: 500px;
	width: 420px;
	margin: 20px; /*设置元素跟其他元素的距离为20像素*/
	float: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/
	/* background: #f00; */
}

/*注：Content-Left和Content-Main元素是Content元素的子元素，两个元素使用了float:left;设置成两列，这个两个元素的宽度和这个两个元素设置的padding、margin的和一定不能大于父层Content元素的宽度，否则设置列将失败*/
#Footer {
	height: 40px;
	background: #90C;
	margin-top: 20px;
}

.Clear {
	clear: both;
}
</style>
   
</head>

<body background="image/DNA.jpg">
		<div id="Header">

		</div>
<div id="Content-Left">
</div>
<div id="Content-Main">
	<h1>联舟测试平台</h1>
	<form action="checklogin.jsp" method="post" style="font-size:25px">
		用户:<input type="text" name="userName" value="TW001083"
			style="width:100px;height: 30px; margin:5px"> <br/>		
		密码:<input type="password" name="password" 
			style="width:100px;height: 30px; margin:5px"><br/>
		<input type="submit" name="login" value="登录" 
			style="width:80px;height: 30px; margin:5px"> 
		<input type="reset" name="reset" value="取消" 
			style="width:80px;height: 30px; margin:5px">
	</form>
	</div>
</body>

</html>

