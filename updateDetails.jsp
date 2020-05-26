<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Updating Profile</title>
</head>
<body>
<%
int userId= (int)session.getAttribute("userId");
String name = request.getParameter("name");
String email = request.getParameter("email");
String pfp = request.getParameter("pfp");
String phoneNoStr = request.getParameter("phoneNo");
int phoneNo;
if(pfp == null){
	pfp = "/images/u101.png";
}
if(phoneNoStr == null){
	phoneNo = 0;
}else{
	phoneNo = Integer.parseInt(phoneNoStr);
}

String updateStr = "UPDATE user SET name=?, email=?, pfp=?, phoneNo=?  WHERE userId=?";
int count=0;


 try {
     // Step 2: Define Connection URL
		// String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
		 String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";
		 
     // Step 3: Establish connection to URL
     Connection conn = DriverManager.getConnection(connURL); 
     
 	PreparedStatement pstmt = conn.prepareStatement(updateStr);
 	 pstmt.setString(1,name);
 	 pstmt.setString(2,email);
 	 pstmt.setString(3,pfp);
 	 pstmt.setInt(4,phoneNo);
     pstmt.setInt(5, userId);
     count = pstmt.executeUpdate();
     conn.close(); 
     response.sendRedirect("profilePage.jsp?id="+userId);

} catch (Exception e) {
   out.print("error");
	  response.sendRedirect("errorPage.jsp");

}
%>
</body>
</html>