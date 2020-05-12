<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Page</title>
</head>
<body>
<form action="verifyRegister.jsp" method="post">
<input type="text" name="fname" placeholder="First Name" required/>
<input type="text" name="lname" placeholder="Last Name" required/>
<input type="text" name="email" placeholder="Email" required/>
<input type="password" name="pwd" placeholder="Password" required/>
<input type="password" name="pwdc" placeholder="Confirm Password" required/>
<input type="text" name="address" placeholder="Address"/>
<input type="number" name="phoneNo" placeholder="Phone Number"/>
<input type="submit" value="submit"/>
</form>
<%
	String errorCode = request.getParameter("errorCode");
	if(errorCode == null){
		return;
	}
	else if(errorCode.equals("invalidPw")){
		out.print("<p>Your password inputs in both fields does not tally!</p>");
	}
%>
</body>
</html>
