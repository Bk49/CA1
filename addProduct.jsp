<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Products</title>
</head>
<body>
<form action="verifyAddProduct.jsp" method="post">
<input type="text" name="productName" placeholder="Name of Product" required/>
<textarea rows="4" cols="100" name="briefDescription" placeholder="Brief Description" required></textarea>
<textarea rows="10" cols="100" name="detailDescription" placeholder="Detailed Description"></textarea>
<input type="number" name="costPrice" placeholder="Cost Price" step="0.01" required/>
<input type="number" name="retailPrice" placeholder="Retail Price" step="0.01"/>
<input type="number" name="stockQuantity" placeholder="Stock Quantity" required/>
<input type="text" name="productCategory" placeholder="Product Category"/>
<input type="text" name="imageLocation" placeholder="Image Location"/>
<input type="submit" value="Submit"/>
</form>

</body>
</html>