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
<title>Deleting product</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./CSS/addProduct.css">
</head>
<body>
<div class="container text-center">
<%
int productId = Integer.parseInt(request.getParameter("productId"));
String name;
    try {
           Class.forName("com.mysql.jdbc.Driver");
    //      String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
          String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT productName, briefDescription, detailDescription, costPrice, retailPrice, stockQuantity, productCategory, imageLocation FROM product WHERE productId ="+productId;         
          ResultSet rs = stmt.executeQuery(sqlStr);

          if (rs.next()) {
			out.print("<div><h1 class='text-warning'>Are you sure you want to delete this product?</h1>"+
          			"<img src='."+rs.getString("imageLocation")+"'alt='image'>"+
                  	"<div class='text-warning'>Product Name:</div>"+
          			"<div class='text-white'>"+rs.getString("productName")+"</div>"+
                    "<div class='text-warning'>Brief Description: </div>"+
          			"<div class='text-white'>"+rs.getString("briefDescription")+"</div>"+
                    "<div class='text-warning'>Detailed Description: </div>"+
          			"<div class='text-white'>"+rs.getString("detailDescription")+"</div>"+
                    "<div class='text-warning'>Cost Price: </div>"+
          			"<div class='text-white'>"+String.format("%.2f",rs.getDouble("costPrice"))+"</div>"+
                    "<div class='text-warning'>Retail Price: </div>"+
          			"<div class='text-white'>"+String.format("%.2f",rs.getDouble("retailPrice"))+"</div>"+
                    "<div class='text-warning'>Stock Quantity:</div>"+
          			"<div class='text-white'>"+rs.getString("stockQuantity")+"</div>"+
                    "<div class='text-warning'>Product Category: </div>"+
          			"<div class='text-white'>"+rs.getString("productCategory")+"</div>"+
					"</div>");
          }
        
          conn.close();
     } catch (Exception e) {
        System.err.println("Error :" + e);
     }
%>
<br>
<a class="btn btn-warning" href='confirmDelete.jsp?productId=<%=productId%>'>Confirm Delete!</a>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>