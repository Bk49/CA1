<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Adding Product</title>
</head>
<body>
<%
String productName = request.getParameter("productName");
String briefDescription = request.getParameter("briefDescription");
String detailDescription = request.getParameter("detailDescription");
String costPriceStr = request.getParameter("costPrice");
String retailPriceStr = request.getParameter("retailPrice");
String stockQuantityStr = request.getParameter("stockQuantity");
String productCategory = request.getParameter("productCategory");
String imageLocation = request.getParameter("imageLocation");
String insertStr = "INSERT INTO product (productName, briefDescription, detailDescription, costPrice, retailPrice, stockQuantity, productCategory, imageLocation)"+
					"VALUES (?,?,?,?,?,?,?,?)";
int count = 0;
int retailPrice = 0;
double costPrice=0;
int stockQuantity=0;

if(!retailPriceStr.equals("")){
	retailPrice = Integer.parseInt(retailPriceStr);
}

if(imageLocation.equals("")){
	imageLocation = "/images/p101.png";
}

try{
costPrice = Double.parseDouble(costPriceStr);
stockQuantity = Integer.parseInt(stockQuantityStr);
}catch( NumberFormatException e ){
	out.print("<p>There is an input with that should be a number but was not input as number</p>");
}

 try {
	  Class.forName("com.mysql.jdbc.Driver");
     //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
     String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

     Connection conn = DriverManager.getConnection(connURL); 
     
 	PreparedStatement pstmt = conn.prepareStatement(insertStr);
     pstmt.setString(1,productName);
     pstmt.setString(2, briefDescription);
     pstmt.setString(3, detailDescription);
     pstmt.setDouble(4, costPrice);
     pstmt.setDouble(5, retailPrice);
     pstmt.setInt(6, stockQuantity);
     pstmt.setString(7, productCategory);
     pstmt.setString(8, imageLocation);
     count = pstmt.executeUpdate();
     conn.close(); 

		response.sendRedirect("successPage.jsp?type=ProductAdded");
} catch (Exception e) {
   out.print("error");
	  response.sendRedirect("errorPage.jsp");

}
%>
</body>
</html>