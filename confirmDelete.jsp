<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Deleting Product</title>
</head>
<body>
<%
int productId= Integer.parseInt(request.getParameter("productId"));
String updateStr = "DELETE FROM product WHERE productId=?";
int count=0;


 try {
     String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
     Connection conn = DriverManager.getConnection(connURL); 
     
 	PreparedStatement pstmt = conn.prepareStatement(updateStr);
     pstmt.setInt(1, productId);
     count = pstmt.executeUpdate();
     conn.close(); 
     out.print(count+" rows deleted!");
     response.sendRedirect("productTable.jsp?page=1");

} catch (Exception e) {
   out.print("error");
}
%>
</body>
</html>