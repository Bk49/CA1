<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Editing...</title>
</head>
<body>
<%
int productId = Integer.parseInt(request.getParameter("productId"));
String productName = request.getParameter("productName");
String briefDescription = request.getParameter("briefDescription");
String detailDescription = request.getParameter("detailDescription");
double costPrice = Double.parseDouble(request.getParameter("costPrice"));
double retailPrice = Double.parseDouble(request.getParameter("retailPrice"));
int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
String productCategory = request.getParameter("productCategory");
String imageLocation = request.getParameter("imageLocation");
int count=0;

    try {
           Class.forName("com.mysql.jdbc.Driver");
          //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
          String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          String updateStr = "UPDATE product SET productName=?, briefdescription=?, detailDescription=?, costPrice=?, retailPrice=?, stockQuantity=?, productCategory=?, imageLocation=? WHERE productId=?";         
          
          PreparedStatement pstmt = conn.prepareStatement(updateStr);
          pstmt.setString(1,productName);
          pstmt.setString(2, briefDescription);
          pstmt.setString(3, detailDescription);
          pstmt.setDouble(4, costPrice);
          pstmt.setDouble(5, retailPrice);
          pstmt.setInt(6, stockQuantity);
          pstmt.setString(7, productCategory);
          pstmt.setString(8, imageLocation);
          pstmt.setInt(9, productId);
          count = pstmt.executeUpdate();
          conn.close(); 
		  response.sendRedirect("successPage.jsp?type=ProductEdit");
     } catch (Exception e) {
        out.print("An unknown error has occured");
  	  response.sendRedirect("errorPage.jsp");

     }
%>
</body>
</html>