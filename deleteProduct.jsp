<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Deleting product</title>
</head>
<body>
<%
int productId = Integer.parseInt(request.getParameter("productId"));
String name;
    try {
           Class.forName("com.mysql.jdbc.Driver");
          String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT productName, briefDescription, detailDescription, costPrice, retailPrice, stockQuantity, productCategory, imageLocation FROM product";         
          ResultSet rs = stmt.executeQuery(sqlStr);

          if (rs.next()) {
			out.print("<div><h1>Are you sure you want to delete this product?</h1>"+
          			"<img src='"+rs.getString("imageLocation")+"'alt='image'>"+
          			"<div>"+rs.getString("productName")+"</div>"+
          			"<div>"+rs.getString("briefDescription")+"</div>"+
          			"<div>"+rs.getString("detailDescription")+"</div>"+
          			"<div>"+rs.getString("costPrice")+"</div>"+
          			"<div>"+rs.getString("retailPrice")+"</div>"+
          			"<div>"+rs.getString("stockQuantity")+"</div>"+
          			"<div>"+rs.getString("productCategory")+"</div>"+
					"</div>");
          }
        
          conn.close();
     } catch (Exception e) {
        System.err.println("Error :" + e);
     }
%>
<button onClick="window.location.href='confirmDelete.jsp?productId=<%=productId%>'">Confirm Delete!</button>
</body>
</html>