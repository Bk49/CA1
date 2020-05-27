<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,java.lang.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Products</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./CSS/productTable.css">
</head>
<body>
<%
int id = 0;
if(session.getAttribute("userId") != null){
	id = (int)session.getAttribute("userId");
	}
else{
	response.sendRedirect("errorPage.jsp");
}
String role;
   try {
	   		
          // Step 2: Define Connection URL
 				// String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
		         String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";
          // Step 3: Establish connection to URL
          
          Connection conn = DriverManager.getConnection(connURL); 
         // Step 4: Create Statement object
          Statement stmt = conn.createStatement();

                    // Step 5: Execute SQL Command
          String sqlStr = "SELECT * FROM user WHERE userId = ?" ;
            ResultSet rs;
    		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
    		pstmt.setInt(1,id);
    		rs = pstmt.executeQuery();
    		
			if(rs.next()){
    			role = rs.getString("role");
    			if(role.equals("M")){
    				session.setAttribute("userId",id);
    				session.setMaxInactiveInterval(30 * 60);
    				response.sendRedirect("errorPage.jsp?type=AccessDenied");
    			}
			}
    		
     } catch (Exception e) {
			response.sendRedirect("errorPage.jsp");
     }
%>

<nav class="navbar navbar-expand-lg navbar-custom navbar-dark ">
 		 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
   			 <span class="navbar-toggler-icon"></span>
 		 </button>
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  		  <ul class="navbar-nav mr-auto">
    		  <li class="nav-item active">
    		    <a class="nav-link" href="Home.jsp">Home <span class="sr-only">(current)</span></a>
    		  </li>
    		  <li class="nav-item active">
    		    <a class="nav-link" href="discountTable.jsp">Edit Discounts<span class="sr-only">(current)</span></a>
    		  </li>
    		  <li class="nav-item active">
    		    <a class="nav-link" href="productTable.jsp">Edit Products<span class="sr-only">(current)</span></a>
    		  </li>
 		   </ul>
   		 
  </div>
</nav>

<div class="container text-center">
<h1>Products in the database</h1>

<!-- This button will allow the user to add new products into the database -->
<a class='btn btn-warning' href='addProduct.jsp'>Add new item</a><br><br>

<table class="table table-striped table-hover" > <!-- All products will be pushed into this table -->
<tr>
<th>No.</th>
<th>Product Name</th>
<th>Cost Price</th>
<th>Retail Price</th>
<th>Stock Quantity</th>
<th>Category</th>
<th colspan="2">Product Options</th>

</tr>
<%
int pg = 1 ;// Integer.parseInt(request.getParameter("page"));
if(request.getParameter("page") != null){
	pg= Integer.parseInt(request.getParameter("page"));
}
int startRow = pg*10-10;

int productId;
String productName;
int count = startRow+1;

double costPrice;
double retailPrice;
int stockQuantity;
String productCategory;
    try {
           Class.forName("com.mysql.jdbc.Driver");
          //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
          String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT productId, productName, costPrice, retailPrice, stockQuantity, productCategory FROM product LIMIT "+startRow+",10";         
          ResultSet rs = stmt.executeQuery(sqlStr);

          while (rs.next()) {
              productId = rs.getInt("productId");
              productName = rs.getString("productName");
              costPrice = rs.getDouble("costPrice");
              retailPrice = rs.getDouble("retailPrice");
              stockQuantity = rs.getInt("stockQuantity");
              productCategory = rs.getString("productCategory");
              
              // Printing all the items in the rs
              out.print("<tr>"+
              "<td>"+count+"</td>"+
              "<td>"+productName+"</td>"+
              "<td>"+costPrice+"</td>"+
              "<td>"+retailPrice+"</td>"+
              "<td>"+stockQuantity+"</td>"+
              "<td>"+productCategory+"</td>"+
              "<td><a class='btn btn-warning' href='editProduct.jsp?productId="+productId+"'\">Edit</button></td>"+
              "<td><a class='btn btn-warning' href='deleteProduct.jsp?productId="+productId+"'\">Delete</button></td>"+
              "</tr>");
			count++;
          }
        
          conn.close();
     } catch (Exception e) {
        System.err.println("Error :" + e);
     }
%>
</table>

<!-- Use this button to access to the next 10 rows in the second page -->
<div class='pagination'>
<%
double noOfProducts;
    try {
           Class.forName("com.mysql.jdbc.Driver");
          //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
          String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT COUNT(*) count FROM product"; 
          ResultSet rs = stmt.executeQuery(sqlStr);
         
			while (rs.next()) {
				 noOfProducts = rs.getDouble("count");
		          double Pages = (double)Math.ceil((double) noOfProducts/(double)10.0);

		          for(int i = 0 ; i < Pages; i++)
			      out.print("<a  class='active' href='productTable.jsp?page="+(i+1)+"'>"+ (i+1) +"</a>");	          
		          
          }

          conn.close();
     } catch (Exception e) {
        System.err.println("Error :" + e);
     }
%>
</div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>