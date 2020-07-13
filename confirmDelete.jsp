<%-- 
  - Author(s): LIEW KHYE LERK(P1937000), ERIC NG YONG WEI(P1940211);
  - Date: 29/5/20;
  --%>
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
     //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
     String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

     Connection conn = DriverManager.getConnection(connURL); 
     
 	PreparedStatement pstmt = conn.prepareStatement(updateStr);
     pstmt.setInt(1, productId);
     count = pstmt.executeUpdate();
     conn.close(); 
     out.print(count+" rows deleted!");
     response.sendRedirect("successPage.jsp?type=ProductDelete");

} catch (Exception e) {
   out.print("error");
	  response.sendRedirect("errorPage.jsp");

}
%>
</body>
</html>