<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
       <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Product</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./CSS/addProduct.css">
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
    //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
    String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

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
<div class="d-flex justify-content-center text-center">
<h2 class="text-warning">Edit Product</h2>
<form action='verifyEditProduct.jsp'>
	<input type="hidden" name="productId" value="<%=productId%>"/>

    <div class="form-group">
      <label>Name of Product</label><br>
		<input type="text" name="productName" value="<%=productName%>" required/>
    </div>
  <div class="form-group">
    <label>Brief Description</label><br>
		<textarea rows="4" cols="100" name="briefDescription" placeholder="<%=briefDescription%>" required></textarea>
  </div>
  
  <div class="form-group">
    <label>Detailed Description</label><br>
		<textarea rows="10" cols="100" name="detailDescription" placeholder="<%=detailDescription%>"></textarea>   
  </div>
  
  <div class="form-row">
    <div class="form-group col-md-6">
      <label>Cost Price</label><br>
      <input type="number" name="costPrice"  value="<%=costPrice%>" step="0.01" required/>
    </div>
     <div class="form-group col-md-6">
      <label>Retail Price</label><br>
      <input type="number" name="retailPrice"  value="<%=retailPrice%>" step="0.01" required/>
    </div>
   
  </div>
  
  <div class="form-row">
    <div class="form-group col-md-6">
      <label>Stock Quantity</label><br>
	  <input type="number" name="stockQuantity" value="<%=stockQuantity%>" required />
    </div>
     <div class="form-group col-md-6">
      <label>Image Location</label><br>
	  <input type="text" name="imageLocation" value="<%=imageLocation%>"/>
    </div>
   
  </div>
  
      <div class="form-group">
      <label>Product Category</label>
      <select id="prodCategory" name="productCategory" class="form-control" required>
		<option></option>
        <option>Gaming Keyboard</option>
        <option>Gaming Mouse</option>
        <option>Gaming Mouse Pad</option>
        <option>Gaming Headphones</option>
        <option>Computer Graphics Card</option>
        
      </select>
    </div>
    
	<input type="submit" class="submit bg-warning" value="EDIT PRODUCT"/>
</form>
</div>
<script>
document.getElementById("prodCategory").value = "<%=productCategory%>"
</script>
</body>
</html>