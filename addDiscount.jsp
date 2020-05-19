<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Discount Code</title>
</head>
<body>
<form action="verifyAddDiscount.jsp" method="post">
<input type="text" name="discountCode" placeholder="Discount Code" required/>
<input type="number" name="discountValue" placeholder="Discount Value" step="0.01" required/>
<input type="text" name="discountType" placeholder="Type of Discount (DIRECT/PERCENTAGE)" required/>
<input type="number" name="usageLimit" placeholder="Usage Limit" step="0.01" required/>
<input type="submit" value="Add Discount Code"/>
</form>
</body>
</html>