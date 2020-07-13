<%-- 
  - Author(s): LIEW KHYE LERK(P1937000), ERIC NG YONG WEI(P1940211);
  - Date: 29/5/20;
  --%>
 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Products</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./CSS/addProduct.css">
</head>
<body>
<div class="d-flex justify-content-center text-center">
<h2 class="text-warning">Add Product</h2>
<form  action="verifyAddProduct.jsp" method="post">
    <div class="form-group">
      <label>Name of Product</label><br>
		<input type="text" name="productName" placeholder="Name of Product" required/>
    </div>
  <div class="form-group">
    <label>Brief Description</label><br>
		<textarea rows="4" cols="100" name="briefDescription" placeholder="Brief Description" required></textarea>
  </div>
  
  <div class="form-group">
    <label>Detailed Description</label><br>
		<textarea rows="10" cols="100" name="detailDescription" placeholder="Detailed Description"></textarea>   
  </div>
  
  <div class="form-row">
    <div class="form-group col-md-6">
      <label>Cost Price</label><br>
      <input type="number" name="costPrice" placeholder="Cost Price" step="0.01" required/>
    </div>
     <div class="form-group col-md-6">
      <label>Retail Price</label><br>
      <input type="number" name="retailPrice" placeholder="Retail Price" step="0.01" required/>
    </div>
   
  </div>
  
  <div class="form-row">
    <div class="form-group col-md-6">
      <label>Stock Quantity</label><br>
	  <input type="number" name="stockQuantity" placeholder="Stock Quantity" required/>
    </div>
     <div class="form-group col-md-6">
      <label>Image Location</label><br>
	  <input type="text" name="imageLocation" placeholder="Image Location"/>
    </div>
   
  </div>
  
      <div class="form-group">
      <label>Product Category</label>
      <select name="productCategory" class="form-control" required>
		<option></option>
        <option>Gaming Keyboard</option>
        <option>Gaming Mouse</option>
        <option>Gaming Mouse Pad</option>
        <option>Gaming Headphones</option>
        <option>Computer Graphics Card</option>
        
      </select>
    </div>
    
  
  
	<input type="submit" class="submit bg-warning" value="SUBMIT"/>
</form>


</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>