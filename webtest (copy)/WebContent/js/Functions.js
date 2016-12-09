var xmlHttp

/*读取数据*/
function getUserInfo(uid) 
{
  xmlHttp=GetXmlHttpObject();
  if (xmlHttp==null)
  {
    alert ("您的浏览器不支持AJAX！");
    return;
  } 
  var url="data.jsp";
  url=url+"?uid="+uid;
  xmlHttp.onreadystatechange=stateChanged;
  xmlHttp.open("GET",url,true);
  xmlHttp.send(null);
}
function stateChanged()
{ 
  if (xmlHttp.readyState==4)
  { 
    alert(xmlHttp.responseText);
  } 
}

/*保存数据*/
function saveUserInfo(uid)
{
  xmlHttp=GetXmlHttpObject();
  if (xmlHttp==null)
  {
    alert ("您的浏览器不支持AJAX！");
    return;
  } 
  var url="savedata.jsp";
  var info="postdate..";
  var postdate="uid="+uid+"&info="+info;
  xmlHttp.onreadystatechange=function()
  {
    if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
      alert("data posted!");
    }
  };
  xmlHttp.open("POST",url,true);
  xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
  xmlHttp.send(postdate);
}

/*创建Request对象*/
function GetXmlHttpObject()
{
  var xmlHttp=null;
  try 
  {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }
  catch(e) 
  {
    // Internet Explorer
    try 
    {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (e)
    {
      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
  }
  return xmlHttp;
}