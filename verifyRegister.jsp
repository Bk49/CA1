<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import ="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration status</title>
</head>
<body>
<%
String name = request.getParameter("fname")+" "+request.getParameter("lname");
String password = request.getParameter("pwd");
String passwordConfirm = request.getParameter("pwdc");
if(!password.equals(passwordConfirm))  response.sendRedirect("CustomerRegistration.jsp?errorCode=invalidPw"); 
String email = request.getParameter("email");
String address = request.getParameter("address");
String phoneNoStr = request.getParameter("phoneNo");
int phoneNo;
if(phoneNoStr.equals("")){
	phoneNo = 0;
}else{
	phoneNo = Integer.parseInt(phoneNoStr);
}
String insertStr = "INSERT INTO user (name, pwd, email, role, address, phoneNo) VALUES (?,?,?,'M',?,?)";
int count=0;


 try {
	  Class.forName("com.mysql.jdbc.Driver");
 //    String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
     String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

     Connection conn = DriverManager.getConnection(connURL); 
     
 	PreparedStatement pstmt = conn.prepareStatement(insertStr);
     pstmt.setString(1, name);
     pstmt.setString(2, password);
     pstmt.setString(3, email);
     pstmt.setString(4, address);
     pstmt.setInt(5, phoneNo);
     count = pstmt.executeUpdate();
     conn.close(); 
	
		response.sendRedirect("successPage.jsp?type=Register");

} catch (Exception e) {
   out.print("The email has been used!<br>Server error!");
}
%>
</body>
</html>