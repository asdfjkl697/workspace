function add(){
	document.getElementById("pageid").value=parseInt(document.getElementById("pageid").value)+1;
}
function reduce() {
	if (parseInt(document.getElementById("pageid").value) > 1) {
		document.getElementById("pageid").value = parseInt(document
				.getElementById("pageid").value) - 1;
	} else {
		alert("文本框内的数值为1时不允许再减了！");
	}
}

var XMLHttpReq;
//创建XMLHttpRequest对象         
function createXMLHttpRequest() {
	if (window.XMLHttpRequest) { //Mozilla 浏览器  
		XMLHttpReq = new XMLHttpRequest();
	} else if (window.ActiveXObject) { // IE浏览器  
		try {
			XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
			}
		}
	}
	return XMLHttpReq;
}
//发送请求函数  
function sendRequest(sdate,edate,number,devid,pageid) {
	createXMLHttpRequest();
	var url = "ajax/search_ajax.jsp";
	var postdata="sdate="+document.getElementById(sdate).value+"&edate="
	+document.getElementById(edate).value+"&number="+document.getElementById(number).value
	+"&devid="+document.getElementById(devid).value
	+"&pageid="+document.getElementById(pageid).value;
	
	XMLHttpReq.open("GET", url, true);
	XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
	
	XMLHttpReq.open("POST",url,true);
	XMLHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	XMLHttpReq.send(postdata);
}

// 处理返回信息函数  
function processResponse() {
	if (XMLHttpReq.readyState == 4) { // 判断对象状态  
		if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
			DisplayHot();
			//setTimeout("sendRequest()", 1000);
		} else { //页面不正常  
			window.alert("您所请求的页面有异常。");
		}
	}
}
function DisplayHot() {
	var message = XMLHttpReq.responseXML.getElementsByTagName("response")[0].firstChild.nodeValue;
	document.getElementById("pageall").value = message.substring(1,4);
	for (var i = 1; i < 21; i++) {
		var msglen = 48*i-44;
		var dateid = "dateid" + i;
		var timeid = "timeid" + i;
		var devid = "devid" + i;
		var numid = "numid" + i;
		var tempid = "tempid" + i;
		var humidityid = "humidityid" + i;
		var pressid = "pressid" + i;
		var densityid = "densityid" + i;
		var windid = "windid" + i;
		var consumid = "consumid" + i;
		var stateid = "stateid" + i;
		var cmd = "cmd" + i;
		document.getElementById(dateid).innerHTML = message.substring(
				msglen + 1, msglen + 11);
		document.getElementById(timeid).innerHTML = message.substring(
				msglen + 11, msglen + 19);
		document.getElementById(devid).innerHTML = message.substring(
				msglen + 19, msglen + 23);
		document.getElementById(numid).innerHTML = message.substring(
				msglen + 23, msglen + 25);
		document.getElementById(tempid).innerHTML = message.substring(
				msglen+25, msglen+27)+"."+message.substring(msglen+27, msglen+28);
		document.getElementById(humidityid).innerHTML = message.substring(
				msglen+28, msglen+30)+"."+message.substring(msglen+30, msglen+31);
		document.getElementById(pressid).innerHTML = message.substring(
				msglen+31, msglen+34)+"."+message.substring(msglen+34, msglen+35);
		document.getElementById(densityid).innerHTML = message.substring(
				msglen + 35, msglen + 39);
		document.getElementById(windid).innerHTML = message.substring(
				msglen+39, msglen+40)+"."+message.substring(msglen+40, msglen+42);
		document.getElementById(consumid).innerHTML = message.substring(
				msglen + 42, msglen + 45);
		document.getElementById(stateid).innerHTML = message.substring(
				msglen + 45, msglen + 46);
		document.getElementById(cmd).innerHTML = message.substring(msglen + 46,
				msglen + 48);
	}
}

//发送请求函数  
function RequestUserList(list) {
	createXMLHttpRequest();
	var url = "ajax/author_ajax.jsp";
	postdata = "list="+list;

	XMLHttpReq.open("GET", url, true);
	XMLHttpReq.onreadystatechange = ResponseList;//指定响应函数
	
	XMLHttpReq.open("POST",url,true);
	XMLHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	XMLHttpReq.send(postdata);
}

//处理返回信息函数  
function ResponseList() {
	if (XMLHttpReq.readyState == 4) { // 判断对象状态  
		if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
			DisplayList();
			//setTimeout("sendRequest()", 1000);
		} else { //页面不正常  
			window.alert("您所请求的页面有异常。");
		}
	}
}
function DisplayList() {
	var message = XMLHttpReq.responseXML.getElementsByTagName("response")[0].firstChild.nodeValue;

	var list = message.substring(1,2);
	var msgnum1 = message.substring(3,6);
	var msgnum = Number(msgnum1);
	var listid,authid;
	if(list=="a"){
		listid="userlistid";
		authid="userauthid";
	}else if(list=="b"){
		listid="devlistid";
		authid="devauthid";
	}
	
	for (var i = 1; i < msgnum; i++) {
		var msglen = 10 * (i - 1);

		var userlistid = listid + i;
		var userauthid = authid + i;
		document.getElementById(userlistid).innerHTML = message.substring(
				msglen + 6, msglen + 15);
		document.getElementById(userauthid).innerHTML = message.substring(
				msglen + 15, msglen + 16);		

	}
	//document.getElementById("useridnum").innerHTML = message.substring(1,4);
}


//发送请求函数
function userfun(gpName,userName,userPWD,author,mode) {
	var len = document.getElementById(userName).value.toString().length;
	var first = document.getElementById(userName).value.substring(0,1);
	if(((len!=3)|(first!=0))&&(mode=="add")){
		alert("用户名请输入 001-0ff");
		return;
	}
	if(((len!=3)|(first==0))&&(mode=="addev")){
		alert("用户名请输入 100-fff");
		return;
	}
	if ((mode == "add") | (mode == "modify")) {
		var len = document.getElementById(author).value.toString().length;
		var temp = document.getElementById(author).value
		if ((len != 1) | (temp > 3)) {
			alert("权限请输入1-3");
			return;
		}
	}

	createXMLHttpRequest();
	var url = "ajax/user_ajax.jsp";
	var postdata="userName="+document.getElementById(gpName).value+document.getElementById(userName).value+
	"&userPWD="+document.getElementById(userPWD).value+
	"&author="+document.getElementById(author).value+
	"&mode="+mode;

	XMLHttpReq.open("POST",url,true);
	XMLHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	XMLHttpReq.send(postdata);
	alert("操作成功");
}


function sendpara(sdate,edate,number,devid){
	
	var postdata="sdate="+document.getElementById(sdate).value+"&edate="
	+document.getElementById(edate).value+"&number="+document.getElementById(number).value
	+"&devid="+document.getElementById(devid).value;
	
	window.location.href="topdf.jsp?"+postdata;
	//window.location.href="topdf.jsp";
}

