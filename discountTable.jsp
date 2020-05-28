<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Discount Codes</title>
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
    		  <li class="nav-item ">
    		    <a class="nav-link" href="Administrator.jsp">Administrator <span class="sr-only">(current)</span></a>
    		  </li>
    		  <li class="nav-item active">
    		    <a class="nav-link" href="discountTable.jsp">Edit Discounts<span class="sr-only">(current)</span></a>
    		  </li>
    		  <li class="nav-item ">
    		    <a class="nav-link" href="productTable.jsp">Edit Products<span class="sr-only">(current)</span></a>
    		  </li>
 		   </ul>
   		 
  </div>
</nav>
<div class="container text-center">

<h1>Discount Codes in the database</h1>

<!-- This button will allow the user to add new discount codes into the database -->
<a class="btn btn-warning" href='addDiscount.jsp'>Add new discount code</a><br><br>

<table class="table table-striped table-hover"><!-- All discount code will be pushed into this table -->
<tr>
<th>No.</th>
<th>Discount Code</th>
<th>Discount Price</th>
<th>Usage Limit</th>
<th>Amount Used</th>
<th colspan="2">Discount Options</th>
</tr>
<%
int pg=1;
if(request.getParameter("page")!=null){
	pg=Integer.parseInt(request.getParameter("page"));
}
int startRow = pg*10-10;
int count = startRow+1;
String discountPrice;
double discountValue;
String discountType;
try {
    Class.forName("com.mysql.jdbc.Driver");
   //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
   String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

   Connection conn = DriverManager.getConnection(connURL); 
   Statement stmt = conn.createStatement();

   String sqlStr = "SELECT * FROM discount LIMIT "+startRow+",10";         
   ResultSet rs = stmt.executeQuery(sqlStr);

   while (rs.next()) {       
	   discountValue = rs.getDouble("discountValue");
	   discountType = rs.getString("discountType");
	   if(discountType.equals("DIRECT")){
		   discountPrice = "$"+String.format("%.2f",discountValue);
	   }else{
		   discountPrice = String.format("%.2f",discountValue)+"%";
	   }
       // Printing all the items in the rs
       out.print("<tr>"+
       "<td>"+count+"</td>"+
       "<td>"+rs.getString("discountCode")+"</td>"+
       "<td>"+discountPrice+"</td>"+
       "<td>"+rs.getInt("usageLimit")+"</td>"+
       "<td>"+rs.getInt("usageCount")+"</td>"+
       "<td><a class='btn btn-warning' href='editDiscount.jsp?discountId="+rs.getInt("discountId")+"'\">Edit</button></td>"+
       "<td><a class='btn btn-warning' href='deleteDiscount.jsp?discountId="+rs.getInt("discountId")+"'\">Delete</button></td>"+
       "</tr>");
       
       count++;
   }
 
   conn.close();
} catch (Exception e) {
 System.err.println("Error :" + e);
}
%>

</table>

<div class='pagination'>
<%
double noOfProducts;
    try {
           Class.forName("com.mysql.jdbc.Driver");
          //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
          String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT COUNT(*) count FROM discount"; 
          ResultSet rs = stmt.executeQuery(sqlStr);
         
			while (rs.next()) {
				 noOfProducts = rs.getDouble("count");
		          double Pages = (double)Math.ceil((double) noOfProducts/(double)10.0);

		          for(int i = 0 ; i < Pages; i++)
			      out.print("<a  class='active' href='discountTable.jsp?page="+(i+1)+"'>"+ (i+1) +"</a>");	          
		          
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