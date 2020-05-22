<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./CSS/Login.css">
</head>
<body>
<div class="d-flex justify-content-center text-center">
	<form action="verifyLogin.jsp" method="post"><br>
	    <h2 class="text-warning">SHOPMANIA LOGIN</h2><br>
		<input type="text" name="email" placeholder="Email" required/><br>
		<input type="password" name="pwd" placeholder="Password" required/><br>
					<%
			String errorCode = request.getParameter("errorCode");
				if("invalidLogin".equals(errorCode)){
					out.print("<p class=\"text-danger\">Invalid credentials! Please check again!</p>");
			}
			%>;
		<input type="submit" class="submit bg-warning" value="LOGIN"/>
		<p class="text-white">Don't have an account? <a href="CustomerRegistration.jsp">Sign up here</a></p>
	</form>
</div>

</body>
</html>