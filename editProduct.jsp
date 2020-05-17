<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
       <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Product</title>
</head>
<body>
<%
int productId= Integer.parseInt(request.getParameter("productId"));
String productName ="";
String briefDescription="";
String detailDescription="";
double costPrice=0;
double retailPrice=0;
int stockQuantity=0;
String productCategory="";
String imageLocation="";
try {
     Class.forName("com.mysql.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";

    Connection conn = DriverManager.getConnection(connURL); 
    Statement stmt = conn.createStatement();

    String sqlStr = "SELECT productName, briefDescription, detailDescription, costPrice, retailPrice, stockQuantity, productCategory, imageLocation FROM product WHERE productId="+productId;         
    ResultSet rs = stmt.executeQuery(sqlStr);

    if (rs.next()) {
    	productName = rs.getString("productName");
    	briefDescription = rs.getString("briefDescription");
    	detailDescription = rs.getString("detailDescription");
    	costPrice = rs.getDouble("costPrice");
    	retailPrice = rs.getDouble("retailPrice");
    	stockQuantity = rs.getInt("stockQuantity");
    	productCategory = rs.getString("productCategory");
    	imageLocation = rs.getString("imageLocation");
    }
  
    // Step 7: Close connection
    conn.close();
} catch (Exception e) {
  	out.println("Edit product cannot be done! Server error!");
}
%>
<form action='verifyEditProduct.jsp'>

<!-- The user will not see line 51 input field! -->
<input type="hidden" name="productId" value="<%=productId%>"/>

<div>
<label>Name of Product</label>
<input type="text" name="productName" value="<%=productName%>"/>
</div>
<br>
<div>
<label>Brief Description</label>
<input type="text" name="briefDescription" value="<%=briefDescription%>"/>
</div>
<br>
<div>
<label>Detailed Description</label>
<input type="text" name="detailDescription" value="<%=detailDescription%>"/>
</div>
<br>
<div>
<label>Cost Price</label>
<input type="number" step="0.01" name="costPrice" value="<%=costPrice%>"/>
</div>
<br>
<div>
<label>Retail Price</label>
<input type="number" step="0.01" name="retailPrice" value="<%=retailPrice%>"/>
</div>
<br>
<div>
<label>Stock Quantity</label>
<input type="number" name="stockQuantity" value="<%=stockQuantity%>"/>
</div>
<br>
<div>
<label>Product Category</label>
<input type="text" name="productCategory" value="<%=productCategory%>"/>
</div>
<br>
<div>
<label>Image Location</label>
<input type="text" name="imageLocation" value="<%=imageLocation%>"/>
</div>
<br>
<input type="submit" value="Confirm Edit">

</form>
</body>
</html>