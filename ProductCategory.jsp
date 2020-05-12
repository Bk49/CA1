<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Category</title>
</head>
<body>
<!-- Testing for this page's query has not been done yet -->
<%
int id;
String category;
    try {

           Class.forName("com.mysql.jdbc.Driver");
          String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
          
          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT productCategory FROM product";         
          ResultSet rs = stmt.executeQuery(sqlStr);

          while (rs.next()) {
              category = rs.getString("productCategory");
              out.print("<a href='ProductsOfCategory.jsp?category="+category+"'>"+category.toUpperCase()+"</a>");
          }
        
          conn.close();
     } catch (Exception e) {
        out.print("Error :" + e);
     }
%>
</body>
</html>