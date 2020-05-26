<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Discount</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./CSS/addProduct.css">
</head>
<body>
<%
int discountId = Integer.parseInt(request.getParameter("discountId"));
String discountCode = "";
double discountValue = 0;
String discountType = "DIRECT";
int usageLimit = 0;
int usageCount = 0;

try{
	 //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
     String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

	    Connection conn = DriverManager.getConnection(connURL); 
	    Statement stmt = conn.createStatement();

	    String sqlStr = "SELECT discountCode, discountValue, discountType, usageLimit, usageCount FROM discount WHERE discountId="+discountId;         
	    ResultSet rs = stmt.executeQuery(sqlStr);

	    if (rs.next()) {
	    	discountCode = rs.getString("discountCode");
	    	discountValue = rs.getDouble("discountValue");
	    	discountType = rs.getString("discountType");
	    	usageLimit = rs.getInt("usageLimit");
	    	usageCount = rs.getInt("usageCount");
	    }
	  
	    conn.close();
}catch(Exception e){
	out.println("Error retrieving original values of products from the database");
}
%>
<div class="d-flex justify-content-center text-center">
<h2 class="text-warning">Edit Product</h2>

<form action='verifyEditDiscount.jsp'>

<!-- The user will not see the line 42 input field! -->
<input type="hidden" name="discountId" value="<%=discountId %>"/>

<div>
<label>Discount Code</label><br>
<input type="text" name="discountCode" value="<%=discountCode%>" required/>
</div>
<br>
<div>
<label>Discount Value</label><br>
<input type="number" step="0.01" name="discountValue" value="<%=discountValue%>" required/>
</div>
<br>
<div>
<label>Type of Discount</label><br>
<input type="text" name="discountType" value="<%=discountType%>" required/>
</div>
<br>
<div>
<label>Usage Limit (Default is 0)</label>
<input type="number" name="usageLimit" value="<%=usageLimit%>"/>
</div>
<br>
<div>
<label>Number of Usage (Default is 0)</label>
<input type="number" name="usageCount" value="<%=usageCount%>"/>
</div>
<br>
<input type="submit" class="submit bg-warning" value="EDIT DISCOUNT"/>

</form>
</div>
</body>
</html>