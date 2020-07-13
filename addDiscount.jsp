<%-- 
  - Author(s): LIEW KHYE LERK(P1937000), ERIC NG YONG WEI(P1940211);
  - Date: 29/5/20;
  --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Discount Code</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./CSS/Login.css">
</head>
<body>

<div class="d-flex justify-content-center text-center">
	<form action="verifyAddDiscount.jsp" method="post">
	    <h2 class="text-warning">Add Discount</h2><br>
			<input type="text" name="discountCode" placeholder="Discount Code" required/>
			<input type="number" name="discountValue" placeholder="Discount Value" step="0.01" required/>
			<input type="text" name="discountType" placeholder="Type of Discount (DIRECT/PERCENTAGE)" required/>
			<input type="number" name="usageLimit" placeholder="Usage Limit" step="0.01" required/>
			<input type="submit" class="submit bg-warning" value="Add Discount Code"/>
	</form>
</div>

</body>
</html>