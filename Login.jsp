<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
<form action="verifyLogin.jsp" method="post">
<input type="text" name="email" placeholder="Email"/>
<input type="password" name="pwd" placeholder="Password"/>
<input type="submit" value="Login"/>
</form>
<%
	String errorCode = request.getParameter("errorCode");
	if(errorCode == null) return;
	if(errorCode.equals("invalidLogin")){
		out.print("Incorrect input! Please check again!");
	}
%>
</body>
</html>