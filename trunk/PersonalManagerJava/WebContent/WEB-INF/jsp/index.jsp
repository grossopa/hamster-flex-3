<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Wei Bo</title>
</head>
<body>
  <div style="width : 100%">
	<select id="typeSelector">
	  <option>Sina</option>
	</select>
  </div>
  
  <div style="width : 100%">
    Your login key : <input id="login_key_input" type="text" value="${cookieUUID}" style="width : 100%" />
  </div>
    <div style="width: 100%">
    <textarea id="message_ta" style="width : 100%"></textarea>
    <input id="submit_btn" type="button" onclick="submitBtn_clickHandler()" value="Click to Send" />
  </div>
  <script type="text/javascript" src="../js/jquery.js"></script>
  <script type="text/javascript" src="../js/index.js"></script>
  <script type="text/javascript" src="../js/AjaxTool.js"></script>
</body>

</html>