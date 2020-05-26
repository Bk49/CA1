<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Deleting Discount Code</title>
</head>
<body>
<%
int discountId= Integer.parseInt(request.getParameter("discountId"));
String updateStr = "DELETE FROM discount WHERE discountId=?";
int count=0;


 try {
//     String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
     String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

     Connection conn = DriverManager.getConnection(connURL); 
     
 	PreparedStatement pstmt = conn.prepareStatement(updateStr);
     pstmt.setInt(1, discountId);
     count = pstmt.executeUpdate();
     conn.close(); 
     out.print(count+" rows deleted!");
	  response.sendRedirect("successPage.jsp?type=DiscountDelete");

} catch (Exception e) {
   out.print("error");
	  response.sendRedirect("errorPage.jsp");

}
%>
</body>
</html>